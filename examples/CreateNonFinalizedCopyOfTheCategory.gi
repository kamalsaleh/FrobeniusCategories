
LoadPackage( "CAP" );

# ReadPackage( "FrobeniusCategoriesForCAP", "examples/CreateNonFinalizedCopyOfTheCategory.gi" );

# LoadPackage( "FrobeniusCategoriesForCAP" );

DeclareOperation( "CreateNonFinalizedCopyOfTheCategory", [ IsCapCategory, IsString ] );

InstallMethod( CreateNonFinalizedCopyOfTheCategory, 
                [ IsCapCategory, IsString ], 
   function( cat, name_of_the_new_category )
   local new_category, name_of_obj_creation_in_new_category, name_of_mor_creation_in_new_category,
         name_of_type_of_object_in_new_category, name_of_rep_of_object_in_new_category,
         name_of_type_of_morphism_in_new_category, name_of_rep_of_morphism_in_new_category,
         name_of_cell_creation_in_new_category, convert_arg_from_original_to_new_category,
         convert_arg_from_new_category_to_original, recnames, current_name,add_current_name,
         name_of_the_global_variable_for_current_name;
   
#    if not HasIsAbelianCategory( cat ) or not IsAbelianCategory( cat ) then 
#    
#       Error( "The category in the input should be abelian" );
#       
#    fi;
   
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
             
    
    ## Adding additive methods
    
    
    ## IsEqualForObjects
    
    if CanCompute( cat, "IsEqualForObjects" ) then 
    
    AddIsEqualForObjects( new_category,                    function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( IsEqualForObjects, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
    ## IsEqualForMorphisms
    
    if CanCompute( cat, "IsEqualForMorphisms" ) then 
    
    AddIsEqualForMorphisms( new_category,                  function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( IsEqualForMorphisms, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
    
    ## IdentityMorphism
    
    if CanCompute( cat, "IdentityMorphism" ) then 
    
    AddIdentityMorphism( new_category,                  function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( IdentityMorphism, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
    ## PreCompose
    
    if CanCompute( cat, "PreCompose" ) then 
    
    AddPreCompose( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( PreCompose, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
    ## PostCompose
    
    if CanCompute( cat, "PostCompose" ) then 
    
    AddPostCompose( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( PostCompose, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
    # IsZeroForObjects
    
    if CanCompute( cat, "IsZeroForObjects" ) then 
    
    AddIsZeroForObjects( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( IsZeroForObjects, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
 
      # IsZeroForMorphisms
    
    if CanCompute( cat, "IsZeroForMorphisms" ) then 
    
    AddIsZeroForMorphisms( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( IsZeroForMorphisms, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
 
   
    # KernelEmbedding
    
    if CanCompute( cat, "KernelEmbedding" ) then 
    
    AddKernelEmbedding( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( KernelEmbedding, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
    # KernelLift
    
    if CanCompute( cat, "KernelLift" ) then 
    
    AddKernelLift( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( KernelLift, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
    
    # CokernelProjection
    
    if CanCompute( cat, "CokernelProjection" ) then 
    
    AddCokernelProjection( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( CokernelProjection, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
    # CokernelColift
    
    if CanCompute( cat, "CokernelColift" ) then 
    
    AddCokernelColift( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( CokernelColift, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
      # AdditionForMorphisms
    
    if CanCompute( cat, "AdditionForMorphisms" ) then 
    
    AddAdditionForMorphisms( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( AdditionForMorphisms, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
      # AdditiveInverseForMorphisms
    
    if CanCompute( cat, "AdditiveInverseForMorphisms" ) then 
    
    AddAdditiveInverseForMorphisms( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( AdditiveInverseForMorphisms, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
     
    # IsIsomorphism
    
    if CanCompute( cat, "IsIsomorphism" ) then 
    
    AddIsIsomorphism( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( IsIsomorphism, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
    # IsMonomorphism
    
    if CanCompute( cat, "IsMonomorphism" ) then 
    
    AddIsMonomorphism( new_category,                           function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( IsMonomorphism, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
     # IsEpimorphism
    
    if CanCompute( cat, "IsEpimorphism" ) then 
    
    AddIsEpimorphism( new_category,                        function( arg )
                                                           local arg_in_original, result_in_new, result_in_original;
                                                           
                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
 
                                                           if not IsList( arg_in_original ) then 
                                                                  
                                                                  arg_in_original:= [ arg_in_original ];
                                                                  
                                                           fi;
                                                          
                                                           result_in_original := CallFuncList( IsEpimorphism, arg_in_original );
 
                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
 
                                                           return result_in_new;
                                                          
                                                           end );
    fi;
    
    return new_category;
    
end );
   

LoadPackage( "LinearAlgebra" );
Q:= HomalgFieldOfRationals(); 
cat := CapCategory( VectorSpaceObject( 3, Q ) );
A := VectorSpaceObject( 3, Q );
B := VectorSpaceObject( 3, Q );

new_cat:= CreateNonFinalizedCopyOfTheCategory( cat, "new_cat" );


#     This code is a try add the medthods using a loop, but it does not work.....
#
#     recnames := RecNames( CAP_INTERNAL_METHOD_NAME_RECORD );
#     
#     Print( "Here is a list of installed methods for the category: ", name_of_the_new_category );
#            
#     for current_name in recnames do 
#        
#         if not IsSubset( current_name, "WithGiven" ) and CanCompute( cat, current_name ) then 
#                       
#            add_current_name := Concatenation( "Add", current_name );
#            
#            name_of_the_global_variable_for_current_name := Concatenation( "_1_crazy_", current_name );
#            
#            DeclareGlobalVariable( name_of_the_global_variable_for_current_name );
#            Print( add_current_name,"\n" );
#            InstallValue( name_of_the_global_variable_for_current_name, current_name );
#                       
#            ValueGlobal( add_current_name )( new_category, function( arg )
#                                                           local arg_in_original, result_in_new, result_in_original;
#                                                           Print( current_name );
# 
#                                                           arg_in_original := ValueGlobal( convert_arg_from_new_category_to_original )( arg );
# 
#                                                           if not IsList( arg_in_original ) then 
#                                                                  
#                                                                  Print( "Hey" );
#                                                                  arg_in_original:= [ arg_in_original ];
#                                                                  
#                                                           fi;
#                                                          
#                                                           result_in_original := CallFuncList( ValueGlobal( name_of_the_global_variable_for_current_name ), arg_in_original );
# 
#                                                           result_in_new := ValueGlobal( convert_arg_from_original_to_new_category )( result_in_original );
# 
#                                                           return result_in_new;
#                                                          
#                                                           end );                                 
#         fi;
#         
#     od;
  