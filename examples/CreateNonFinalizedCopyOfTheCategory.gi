


# ReadPackage( "FrobeniusCategoriesForCAP", "examples/CreateNonFinalizedCopyOfTheCategory.gi" );

LoadPackage( "FrobeniusCategoriesForCAP" );

DeclareOperation( "CreateNonFinalizedCopyOfTheCategory", [ IsCapCategory, IsString ] );

InstallMethod( CreateNonFinalizedCopyOfTheCategory, 
                [ IsCapCategory, IsString ], 
   function( cat, name_of_the_new_category )
   local new_category, name_of_obj_creation_in_new_category, name_of_mor_creation_in_new_category,
         name_of_type_of_object_in_new_category, name_of_rep_of_object_in_new_category,
         name_of_type_of_morphism_in_new_category, name_of_rep_of_morphism_in_new_category,
         name_of_cell_creation_in_new_category, convert_arg_from_original_to_new_category,
         convert_arg_from_new_category_to_original, recnames, current_name,add_current_name;
   
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
             
                Error( Concatenation( "The given object does not live in ", Name( cat ) ) );
                
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
             
                Error( Concatenation( "The given morphism does not live in ", Name( cat ) ) );
                
             fi;
             
             new_mor := rec( morphism := mor_in_cat );
             
             ObjectifyWithAttributes( new_mor, ValueGlobal( name_of_type_of_morphism_in_new_category ),
                                    Source, ValueGlobal( name_of_obj_creation_in_new_category )( Source( mor_in_cat ) ),
                                    Range,  ValueGlobal( name_of_obj_creation_in_new_category )( Range( mor_in_cat ) )
                                    );
             
             Add( new_category, new_mor );
             
             return new_mor;
             
             end );
    
   name_of_cell_creation_in_new_category := Concatenation( "AsCellIn", name_of_the_new_category );
   
   DeclareOperation( name_of_cell_creation_in_new_category, [ IsCapCategoryCell ] );
   
   InstallMethod( ValueGlobal( name_of_cell_creation_in_new_category ), 
                           [ IsCapCategoryCell ],
                           
             function( cell )
             
             if IsCapCategoryObject( cell ) then 
             
                return ValueGlobal( name_of_obj_creation_in_new_category )( cell );
                
             elif IsCapCategoryMorphism( cell ) then
             
                return ValueGlobal( name_of_mor_creation_in_new_category )( cell );
                
             else 
             
                Error( "this should not happen" );
                
             fi;
             
             end );
             
             
             
    convert_arg_from_original_to_new_category := Concatenation( "ConvertArgFromOriginalTo", name_of_the_new_category );
    
    DeclareGlobalFunction( convert_arg_from_original_to_new_category );
    
    InstallGlobalFunction( ValueGlobal( convert_arg_from_original_to_new_category ),
                       function( arg )
                                                 
                       if Length( arg )= 1 and IsCapCategoryCell( arg[ 1 ] ) then 
                                   
                          return ValueGlobal( name_of_cell_creation_in_new_category )( arg[ 1 ] );
                       
                      elif Length( arg )= 1 and IsBool( arg[ 1 ] ) then 
                       
                          return arg[ 1 ];
                          
                      elif Length( arg )= 1 and IsInt( arg[ 1 ] ) then 
                       
                          return arg[ 1 ];
                      
                      elif Length( arg )= 1 and IsList( arg[ 1 ] ) then 
                          
                          return List( arg[ 1 ], ValueGlobal( convert_arg_from_original_to_new_category ) );

                      else
                       
                         return List( arg, ValueGlobal( convert_arg_from_original_to_new_category ) );
                          
                      fi;
                       
                      end );
    
    convert_arg_from_new_category_to_original := Concatenation( "ConvertArgFrom", name_of_the_new_category, "ToTheOriginalCategory" );
    
    DeclareGlobalFunction( convert_arg_from_new_category_to_original );
    
    InstallGlobalFunction( ValueGlobal( convert_arg_from_new_category_to_original ),
                       function( arg )
                                                 
                       if Length( arg )= 1 and IsCapCategoryObject( arg[ 1 ] ) then 
                                   
                          return arg[ 1 ]!.object;
                       
                       elif Length( arg )= 1 and IsCapCategoryMorphism( arg[ 1 ] ) then 
                                   
                          return arg[ 1 ]!.morphism;
                       
                      elif Length( arg )= 1 and IsBool( arg[ 1 ] ) then 
                       
                          return arg[ 1 ];
                      
                      elif Length( arg )= 1 and IsInt( arg[ 1 ] ) then 
                       
                          return arg[ 1 ];
                          
                      elif Length( arg )= 1 and IsList( arg[ 1 ] ) then 
                          
                          return List( arg[ 1 ], ValueGlobal( convert_arg_from_new_category_to_original ) );

                      else
                       
                         return List( arg, ValueGlobal( convert_arg_from_new_category_to_original ) );
                          
                      fi;
                       
                      end );
    
    
    InstallMethod( ViewObj, 
                   [ ValueGlobal( name_of_rep_of_object_in_new_category ) ],
             function( obj )
             
             Print( "< An object in ", new_category, " >"); #, " with original object in ", cat, ":\n\n" );
             
#              ViewObj( obj!.object );
             
             end );
             
    InstallMethod( ViewObj, 
                   [ ValueGlobal( name_of_rep_of_morphism_in_new_category ) ],
             function( mor )
             
             Print( "< A morphism in ", new_category, " >");#, " with original morphism in ", cat, ":\n\n" );
             
#              ViewObj( mor!.morphism );
             
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
    
    recnames := RecNames( CAP_INTERNAL_METHOD_NAME_RECORD );
    
    
    for current_name in recnames do 
    
        if not IsSubset( current_name, "WithGiven" ) and CanCompute( cat, current_name ) then 
        
           add_current_name := Concatenation( "Add", current_name );
           
           ValueGlobal( add_current_name, function( arg )
                                          local arg_in_original, result_in_new, result_in_original;
                                          
                                          arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
                                          
                                          result_in_original := CallFuncList( ValueGlobal( current_name ), arg_in_original );
                                          
                                          result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
                                          
                                          return result_in_new;
                                          
                                          end );                                 
        fi;
        
    od;
    
    return new_category;
    
end );
   