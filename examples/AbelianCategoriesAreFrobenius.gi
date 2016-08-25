## Hey Kamal, 


DeclareOperation( "ConstructeFrobeniusCategoryFromAbelianCategory", [ IsCapCategory, IsString ] );

InstallMethod( ConstructeFrobeniusCategoryFromAbelianCategory, 
                [ IsCapCategory, IsString ], 
   function( cat, name_of_the_new_category )
   local new_category, name_of_obj_creation_in_new_category, name_of_mor_creation_in_new_category,
         name_of_type_of_object_in_new_category, name_of_rep_of_object_in_new_category,
         name_of_type_of_morphism_in_new_category, name_of_rep_of_morphism_in_new_category;
   
   if not HasIsAbelianCategory( cat ) or not IsAbelianCategory( cat ) then 
   
      Error( "The category in the input should be abelian" );
      
   fi;
   
   new_category := CreateCapCategory( name_of_the_new_category );
   
   
   name_of_rep_of_object_in_new_category := Concatenation( "IsObjectIn", name_of_the_new_category, "Rep" );
   
   DeclareRepresentation( name_of_rep_of_object_in_new_category,
                        IsCapCategoryObjectRep,
                        [ ] );
   name_of_type_of_object_in_new_category := Concatenation( "TheTypeOfObjectsIn", name_of_the_new_category );
   
   BindGlobal( name_of_type_of_object_in_new_category,
        NewType( TheFamilyOfCapCategoryObjects,
                ValueGlobal( name_of_rep_of_object_in_new_category ) ) );

   
   name_of_obj_creation_in_new_category := Concatenation( "AsObjectIn", name_of_the_new_category );
   
   DeclareOperation( name_of_obj_creation_in_new_category, [ IsCapCategoryObject ] );
   
   InstallMethod( ValueGlobal( name_of_obj_creation_in_new_category ), 
                           [ IsCapCategoryObject ],
                           
             function( obj_in_cat )
             local new_ob;
             
             if not Name( CapCategory( obj_in_cat ) ) = Name( cat ) then 
             
                Print( "The given object does not live in ", cat );
                Error( " " );
                
             fi;
             
             new_ob := rec( object := obj_in_cat );
             
             ObjectifyWithAttributes( new_ob, ValueGlobal( name_of_type_of_object_in_new_category ) );
             
             Add( new_category, new_ob );
             
             return new_ob;
             
             end );
   
   name_of_rep_of_morphism_in_new_category := Concatenation( "IsMorphismIn", name_of_the_new_category, "Rep" );
   
   DeclareRepresentation( name_of_rep_of_morphism_in_new_category,
                        IsCapCategoryMorphismRep,
                        [ ] );
   name_of_type_of_morphism_in_new_category := Concatenation( "TheTypeOfMorphismsIn", name_of_the_new_category );
   
   BindGlobal( name_of_type_of_morphism_in_new_category,
        NewType( TheFamilyOfCapCategoryMorphisms,
                ValueGlobal( name_of_rep_of_morphism_in_new_category ) ) );

   
   name_of_mor_creation_in_new_category := Concatenation( "AsMorphismIn", name_of_the_new_category );
   
   DeclareOperation( name_of_mor_creation_in_new_category, [ IsCapCategoryMorphism ] );
   
   InstallMethod( ValueGlobal( name_of_mor_creation_in_new_category ), 
                           [ IsCapCategoryMorphism ],
                           
             function( mor_in_cat )
             local new_mor;
             
             if not Name( CapCategory( mor_in_cat ) ) = Name( cat ) then 
             
                Print( "The given morphism does not live in ", cat );
                Error( " " );
                
             fi;
             
             new_mor := rec( morphism := mor_in_cat );
             
             ObjectifyWithAttributes( new_mor, ValueGlobal( name_of_type_of_morphism_in_new_category ),
                                    Source, ValueGlobal( name_of_obj_creation_in_new_category )( Source( mor_in_cat ) ),
                                    Range,  ValueGlobal( name_of_obj_creation_in_new_category )( Range( mor_in_cat ) )
                                    );
             
             Add( new_category, new_mor );
             
             return new_mor;
             
             end );
             
    InstallMethod( Display, 
                   [ ValueGlobal( name_of_rep_of_object_in_new_category ) ],
             function( obj )
             
             Print( "An object in ", new_category, " with original object in ", cat, ":\n" );
             
             Display( obj!.object );
             
             end );
             
    InstallMethod( Display, 
                   [ ValueGlobal( name_of_rep_of_morphism_in_new_category ) ],
             function( mor )
             
             Print( "A morphism in ", new_category, " with original morphism in ", cat, ":\n" );
             
             Display( mor!.morphism );
             
             end );  

   return new_category;

end );
  