## Hey Kamal, 


DeclareOperation( "ConstructeFrobeniusCategoryFromAbelianCategory", [ IsCapCategory, IsString ] );

InstallMethod( ConstructeFrobeniusCategoryFromAbelianCategory, 
                [ IsCapCategory, IsString ], 
   function( cat, name_of_the_new_category )
   local new_category, name_of_obj_creation_in_new_category, name_of_mor_creation_in_new_category;
   
   if not IsAbelianCategory( cat ) then 
   
      Error( "The category in the input should be abelian" );
      
   fi;
   
   new_category := CreateCapCategory( name_of_the_new_category );
   
   name_of_obj_creation_in_new_category := Concatenation( "AsObjectIn", name_of_the_new_category );
   
   DeclareOperation( name_of_obj_creation_in_new_category, [ IsCapCategoryObject ] );
   
   InstallMethod( ValueGlobal( name_of_obj_creation_in_new_category ), 
                           [ IsCapCategoryObject ],
                           
             function( obj_in_cat )
             local new_ob;
             
             if not CapCategory( obj_in_cat ) = cat then 
             
                Print( "The given object does not live in ", cat );
                Error( " " );
                
             fi;
             
             new_ob := rec( object := obj_in_cat );
             
             ObjectifyWithAttributes( new_ob, TheTypeOfCapCategoryObjects );
             
             Add( new_category, new_ob );
             
             return new_ob;
             
             end );
   
   name_of_mor_creation_in_new_category := Concatenation( "AsMorphismIn", name_of_the_new_category );
   
   DeclareOperation( name_of_mor_creation_in_new_category, [ IsCapCategoryMorphism ] );
   
   InstallMethod( ValueGlobal( name_of_mor_creation_in_new_category ), 
                           [ IsCapCategoryMorphism ],
                           
             function( mor_in_cat )
             local new_mor;
             
             if not CapCategory( mor_in_cat ) = cat then 
             
                Print( "The given morphism does not live in ", cat );
                Error( " " );
                
             fi;
             
             new_mor := rec( morphism := mor_in_cat );
             
             ObjectifyWithAttributes( new_mor, TheTypeOfCapCategoryMorphisms,
                                    Source, ValueGlobal( name_of_obj_creation_in_new_category )( Source( mor_in_cat ) ),
                                    Range,  ValueGlobal( name_of_obj_creation_in_new_category )( Range( mor_in_cat ) )
                                    );
             
             Add( new_category, new_mor );
             
             return new_mor;
             
             end );
   
   return new_category;

end );
  