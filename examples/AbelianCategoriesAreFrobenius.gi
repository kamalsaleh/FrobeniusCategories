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
    
    InstallMethod( ViewObj, 
                   [ ValueGlobal( name_of_rep_of_object_in_new_category ) ],
             function( obj )
             
             Print( "An object in ", new_category, " with original object in ", cat, ":\n\n" );
             
             ViewObj( obj!.object );
             
             end );
             
    InstallMethod( ViewObj, 
                   [ ValueGlobal( name_of_rep_of_morphism_in_new_category ) ],
             function( mor )
             
             Print( "A morphism in ", new_category, " with original morphism in ", cat, ":\n\n" );
             
             ViewObj( mor!.morphism );
             
             end );  

    
    InstallMethod( Display, 
                   [ ValueGlobal( name_of_rep_of_object_in_new_category ) ],
             function( obj )
             
             Print( "An object in ", new_category, " with original object in ", cat, ":\n\n" );
             
             Display( obj!.object );
             
             end );
             
    InstallMethod( Display, 
                   [ ValueGlobal( name_of_rep_of_morphism_in_new_category ) ],
             function( mor )
             
             Print( "A morphism in ", new_category, " with original morphism in ", cat, ":\n\n" );
             
             Display( mor!.morphism );
             
             end );  
    
    ## Adding additive methods
    
    
    ## IsEqualForObjects
    
    AddIsEqualForObjects( new_category,   function( obj1, obj2 )
                                   
                                          return IsEqualForObjects( obj1!.object, obj2!.object );
                                        
                                          end );
    
    ## IsEqualForMorphisms
    
    AddIsEqualForMorphisms( new_category, function( mor1, mor2 )
                                   
                                          return IsEqualForMorphisms( mor1!.morphism, mor2!.morphism );
                                        
                                          end );
    
    ## identity_morphism
                         
    AddIdentityMorphism( new_category,    function( obj )
    
                                          return ValueGlobal( name_of_mor_creation_in_new_category )( IdentityMorphism( obj!.object ) );
                                       
                                          end );
    ## PreCompose 
    
    AddPreCompose( new_category,          function( mor1, mor2 )
    
                                          return ValueGlobal( name_of_mor_creation_in_new_category )( PreCompose ( mor1!.morphism, mor2!.morphism ) );
                                 
                                          end );
                                 
    ## IsZeroForObjects
   
    AddIsZeroForObjects( new_category,    function( obj )
    
                                          return IsZeroForObjects( obj!.object );
                                          
                                          end );
                                          
    ## IsZeroForMorphisms
   
    AddIsZeroForMorphisms( new_category,  function( mor )
                                          
                                          return IsZeroForMorphisms( mor!.morphism );
                                          
                                          end );
                                          
    ## KernelEmbedding
    
    AddKernelEmbedding( new_category,     function( mor )
    
                                          return ValueGlobal( name_of_mor_creation_in_new_category )( KernelEmbedding( mor!.morphism ) );
                                      
                                          end  );
   
    ## KernelLift 
    
    AddKernelLift( new_category,          function( mor, tau)
    
                                          return ValueGlobal( name_of_mor_creation_in_new_category )( KernelLift( mor!.morphism, tau!.morphism ) );
                                          
                                          end );
    
    ## CokernelProjection
    
    AddCokernelProjection( new_category,  function( mor )
    
                                          return ValueGlobal( name_of_mor_creation_in_new_category )( CokernelProjection( mor!.morphism ) );
                                      
                                          end );
   
    ## 
    
    AddCokernelColift( new_category,      function( mor, tau)
    
                                          return ValueGlobal( name_of_mor_creation_in_new_category )( CokernelColift( mor!.morphism, tau!.morphism ) );
                                          
                                          end );
    
    
    
   return new_category;

end );
  