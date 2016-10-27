


#######################################
##
## Representations
##
#######################################


DeclareRepresentation( "IsCapCategoryShortSequenceRep",
                        IsCapCategoryShortSequence and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryShortExactSequenceRep",

                        IsCapCategoryShortExactSequence and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryConflationRep",

                        IsCapCategoryConflation and IsAttributeStoringRep,
                        [ ] );
 
                        
DeclareRepresentation( "IsCapCategoryMorphismOfShortSequencesRep",

                        IsCapCategoryMorphismOfShortSequences and IsAttributeStoringRep, 
                        [ ] );


##############################
##
## Family and type 
##
##############################

BindGlobal( "CapCategoryShortSequencesFamily",
  NewFamily( "CapCategoryShortSequencesFamily", IsObject ) );

BindGlobal( "CapCategoryShortExactSequencesFamily",
  NewFamily( "CapCategoryShortExactSequencesFamily", IsCapCategoryShortSequence ) );

BindGlobal( "CapCategoryConflationsFamily",
  NewFamily( "CapCategoryConflationsFamily", IsCapCategoryConflation ) );
  
BindGlobal( "CapCategoryMorphismsOfShortSequencesFamily",
  NewFamily( "CapCategoryMorphismsOfShortSequencesFamily", IsObject ) );
  
BindGlobal( "TheTypeCapCategoryShortSequence", 
  NewType( CapCategoryShortSequencesFamily, 
                      IsCapCategoryShortSequenceRep ) );
                      
BindGlobal( "TheTypeCapCategoryShortExactSequence", 
  NewType( CapCategoryShortExactSequencesFamily, 
                      IsCapCategoryShortExactSequenceRep ) );
                      
BindGlobal( "TheTypeCapCategoryConflation", 
  NewType( CapCategoryConflationsFamily, 
                      IsCapCategoryConflationRep ) );
                      
BindGlobal( "TheTypeCapCategoryMorphismOfShortSequences", 
  NewType( CapCategoryMorphismsOfShortSequencesFamily, 
                      IsCapCategoryMorphismOfShortSequencesRep ) );
                      
###############################
##
##  Records and methods
##
###############################

InstallValue( CAP_INTERNAL_FROBENIUS_CATEGORIES_BASIC_OPERATIONS, rec( ) );

InstallValue( FROBENIUS_CATEGORIES_METHOD_NAME_RECORD, rec( 

IsInflation := rec( 

installation_name := "IsInflation", 
filter_list := [ "morphism" ],
cache_name := "IsInflation",
return_type := "bool",
post_function := function( morphism, return_value )
                 
                 if return_value = true then 
                 
                    SetFilterObj( morphism, IsCapCategoryInflation );
                    
                 fi;
                 
                 end ),

IsDeflation := rec( 

installation_name := "IsDeflation", 
filter_list := [ "morphism" ],
cache_name := "IsDeflation",
return_type := "bool",
post_function := function( morphism, return_value )
                 
                 if return_value = true then 
                 
                    SetFilterObj( morphism, IsCapCategoryDeflation );
                    
                 fi;
                 
                 end ),
                 
IsConflation := rec( 

installation_name := "IsConflation", 
filter_list := [ IsCapCategoryShortSequence ],
cache_name := "IsConflation",
return_type := "bool",
post_function := function( seq, return_value )
                 
                 if return_value = true then 
                 
                    SetFilterObj( seq, IsCapCategoryConflation );
                    
                 fi;
                 
                 end ),

FiberProductObjectInducedByStructureOfExactCategory:= rec( 

installation_name := "FiberProductObjectInducedByStructureOfExactCategory", 
filter_list := [ IsCapCategoryDeflation , "morphism" ],
cache_name := "FiberProductObjectInducedByStructureOfExactCategory",
pre_function := function( def, mor )
                local is_equal_for_objects;
                
                is_equal_for_objects := IsEqualForObjects( Range( def ), Range( mor ) );
                
                if is_equal_for_objects = fail then 
                
                    return [ false, "Cannot decide if the ranges of the both morphisms are equal" ];
                 
                elif is_equal_for_objects = false then 
                
                    return  [ false, "The ranges of both morphisms are not equal" ];
                    
                else 
                
                    return [ true ];
                    
                fi;
                
                end,
return_type := "object",

post_function := function( def, mor, return_value )
 
                 AddToGenesis( return_value, "FiberProductObjectInducedByStructureOfExactCategory", [ def, mor ] );
                 
                 end ),                 


ProjectionsOfFiberProductInducedByStructureOfExactCategory:= rec( 

installation_name := "ProjectionsOfFiberProductInducedByStructureOfExactCategory", 
filter_list := [ IsCapCategoryDeflation, "morphism" ],
cache_name := "ProjectionsOfFiberProductInducedByStructureOfExactCategory",
return_type := [ "morphism", IsCapCategoryDeflation ],
post_function := function( def, mor, return_value )
                 
                 if not IsEqualForMorphisms( PreCompose( return_value[ 2 ], mor ), PreCompose( return_value[ 1 ], def ) ) then 
                 
                    Error( "The function given does not provid a Pullback, since the diagram resulted is not commutative" );
                    
                 fi;
                 
                 end ),                 

UniversalMorphismIntoFiberProductInducedByStructureOfExactCategory:= rec( 

installation_name := "UniversalMorphismIntoFiberProductInducedByStructureOfExactCategory", 
filter_list := [ IsList, IsList ],
cache_name := "UniversalMorphismIntoFiberProductInducedByStructureOfExactCategory",

pre_function:= function( D, tau )
               local def,mor, is_equal_for_morphisms;
               
               if not IsCapCategoryDeflation( D[ 1 ] ) then 
               
                  return [ false, "The first entry of the first list should be a deflation" ];
                  
               fi;
               
               if not IsCapCategoryMorphism( D[ 2 ] ) then
                 
                  return [ false, "The second entry of the first list should be a morphism" ];
                  
               fi;
               
               if not IsCapCategoryMorphism( tau[ 1 ] ) or not IsCapCategoryMorphism( tau[ 2 ] ) then
               
                  return [ false, "The second list should be list of two morphisms" ];
                  
               fi;
               
               
               def := D[ 1 ];
               mor := D[ 2 ];
               
               is_equal_for_morphisms := IsEqualForMorphisms( PreCompose( tau[ 1 ], def ), PreCompose( tau[ 2 ], mor ) );
               
               if is_equal_for_morphisms = fail then 
               
                   return [ false, "Cannot determine if the resulted diagram is commutative" ];
                   
               elif is_equal_for_morphisms = false then 
               
                   return [ false, "The resulted diagram by the inputs is not commutative" ];
                   
               else
               
                   return [ true ];
                   
               fi;
               
               end,
               
               
return_type := "morphism", 

post_function := function( D, tau, return_value )
                 local p, proj1, proj2, is_equal_for_morphisms;
                 
                 p := ProjectionsOfFiberProductInducedByStructureOfExactCategory( D[ 1 ], D [ 2 ] );
                 
                 is_equal_for_morphisms := IsEqualForMorphisms( PreCompose( return_value, p[ 1 ] ), tau[ 1 ] );
               
                 if is_equal_for_morphisms = fail then 
                
                     Error( "Cannot determine if the resulted diagrams are commutative" );
                   
                 elif is_equal_for_morphisms = false then 
               
                     Error( "The resulted diagram by the output is not commutative" );
                   
                 fi;
                 
                 is_equal_for_morphisms := IsEqualForMorphisms( PreCompose( return_value, p[ 2 ] ), tau[ 2 ] );
               
                 if is_equal_for_morphisms = fail then 
                
                     Error( "Cannot determine if the resulted diagrams are commutative" );
                   
                 elif is_equal_for_morphisms = false then 
               
                     Error( "The resulted diagram by the output is not commutative" );
                   
                 fi;
                 
                 end ),                 

PushoutObjectInducedByStructureOfExactCategory:= rec( 

installation_name := "PushoutObjectInducedByStructureOfExactCategory", 
filter_list := [ IsCapCategoryInflation, "morphism" ],
cache_name := "PushoutObjectInducedByStructureOfExactCategory",
pre_function := function( inf, mor )
                local is_equal_for_objects;
                
                is_equal_for_objects := IsEqualForObjects( Source( inf ), Source( mor ) );
                
                if is_equal_for_objects = fail then 
                
                    return [ false, "Cannot decide if the sources of the given morphisms are equal or not" ];
                 
                elif is_equal_for_objects = false then 
                
                    return  [ false, "The sources of the given morphisms are not equal" ];
                    
                else 
                
                    return [ true ];
                    
                fi;
                
                end,
return_type := "object",

post_function := function( conf, mor, return_value )
 
                 AddToGenesis( return_value, "PushoutObjectInducedByStructureOfExactCategory", [ conf, mor ] );
                 
                 end ),
                 
InjectionsOfPushoutInducedByStructureOfExactCategory:= rec( 

installation_name := "InjectionsOfPushoutInducedByStructureOfExactCategory", 
filter_list := [ IsCapCategoryInflation, "morphism" ],
cache_name := "InjectionsOfPushoutInducedByStructureOfExactCategory",
return_type := [ "morphism", IsCapCategoryInflation ],

post_function := function( inf, mor, return_value )
                 
                 if not IsEqualForMorphisms( PostCompose( return_value[ 1 ], inf ), PostCompose( return_value[ 2 ], mor ) ) then 
                 
                    Error( "The function given does not provid a pushout, since the diagram resulted is not commutative" );
                    
                 fi;
                 
                 end ),                 


UniversalMorphismFromPushoutInducedByStructureOfExactCategory:= rec( 

installation_name := "UniversalMorphismFromPushoutInducedByStructureOfExactCategory", 
filter_list := [ IsList, IsList ],
cache_name := "UniversalMorphismFromPushoutInducedByStructureOfExactCategory",

pre_function:= function( D, tau )
               local inf,g, is_equal_for_morphisms;
               
               if not IsCapCategoryInflation( D[ 1 ] ) then 
               
                  return [ false, "The first entry of the first list should be an inflation" ];
                  
               fi;
               
               if not IsCapCategoryMorphism( D[ 2 ] ) then
                 
                  return [ false, "The second entry of the first list should be a morphism" ];
                  
               fi;
               
               if not IsCapCategoryMorphism( tau[ 1 ] ) or not IsCapCategoryMorphism( tau[ 2 ] ) then
               
                  return [ false, "The second list should be list of two morphisms" ];
                  
               fi;
               
               
               inf := D[ 1 ];
               g := D[ 2 ];
               
               is_equal_for_morphisms := IsEqualForMorphisms( PostCompose( tau[ 1 ], inf ), PostCompose( tau[ 2 ], g ) );
               
               if is_equal_for_morphisms = fail then 
               
                   return [ false, "Cannot determine if the resulted diagram is commutative" ];
                   
               elif is_equal_for_morphisms = false then 
               
                   return [ false, "The resulted diagram by the inputs is not commutative" ];
                   
               else
               
                   return [ true ];
                   
               fi;
               
               end,
               
               
return_type := "morphism", 

post_function := function( D, tau, return_value )
                 local p, proj1, proj2, is_equal_for_morphisms;
                 
                 p := InjectionsOfPushoutInducedByStructureOfExactCategory( D[ 1 ], D [ 2 ] );
                 
                 is_equal_for_morphisms := IsEqualForMorphisms( PostCompose( return_value, p[ 1 ] ), tau[ 1 ] );
               
                 if is_equal_for_morphisms = fail then 
                
                     Error( "Cannot determine if the resulted diagrams are commutative" );
                   
                 elif is_equal_for_morphisms = false then 
               
                     Error( "The resulted diagram by the output is not commutative" );
                   
                 fi;
                 
                 is_equal_for_morphisms := IsEqualForMorphisms( PostCompose( return_value, p[ 2 ] ), tau[ 2 ] );
               
                 if is_equal_for_morphisms = fail then 
                
                     Error( "Cannot determine if the resulted diagrams are commutative" );
                   
                 elif is_equal_for_morphisms = false then 
               
                     Error( "The resulted diagram by the output is not commutative" );
                   
                 fi;
                 
                 end ),                 

FitIntoConflationUsingInjectiveObject := rec( 

installation_name := "FitIntoConflationUsingInjectiveObject", 
filter_list := [ "object" ],
cache_name := "FitIntoConflationUsingInjectiveObject",
return_type := [ IsCapCategoryConflation ] ),

FitIntoConflationUsingProjectiveObject := rec( 

installation_name := "FitIntoConflationUsingProjectiveObject", 
filter_list := [ "object" ],
cache_name := "FitIntoConflationUsingProjectiveObject",
return_type := [ IsCapCategoryConflation ] ),

InjectiveColift := rec( 

installation_name := "InjectiveColift", 
filter_list := [ "morphism", "morphism" ],
cache_name := "InjectiveColift",
pre_function := function( f, g )

                if not IsEqualForObjects( Source( f ), Source( g ) ) then 
                
                   return [ false, "The sources of the both morphisms should be equal" ];
                   
                fi;
                
                if not IsMonomorphism( f ) then 

                   return [ false, "The first morphism should be mono" ];

                else 

                   return [ true ];

                fi;

                end,

return_type := "morphism" ),


ProjectiveLift := rec( 

installation_name := "ProjectiveLift", 
filter_list := [ "morphism", "morphism" ],
cache_name := "ProjectiveLift",
pre_function := function( f, g )
                
                if not IsEqualForObjects( Range( f ), Range( g ) ) then 
                
                   return [ false, "The ranges of the both morphisms should be equal" ];
                   
                fi;
                
                if not IsEpimorphism( g ) then 

                   return [ false, "The second morphism should be epi" ];

                else 

                   return [ true ];

                fi;

                end,
return_type := "morphism" ),


) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( FROBENIUS_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( FROBENIUS_CATEGORIES_METHOD_NAME_RECORD );
  
########################################
##
## Properties logic
##
########################################

InstallTrueMethod( IsExactCategory, IsFrobeniusCategory );

########################################
##
##  Constructors 
##
########################################

InstallMethodWithCache( CreateShortSequence, 
               
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ], 
               
   function( alpha, beta )
   local s;
   
   if not IsEqualForObjects( Range( alpha ), Source( beta ) ) then 
   
     Error( "Range of the first morphism should equal the Source of the second morphism" );
     
   fi;
   
   if not IsZeroForMorphisms( PreCompose( alpha, beta ) ) then 
   
     Error( "The composition of the two morphisms is not Zero" );
     
   fi;
   
   s := rec( object1:= Source( alpha ), 
             
             morphism1:= alpha,
             
             object2 := Range( alpha ),
             
             morphism2 := beta,
             
             object3 := Range( beta ) );
             
    ObjectifyWithAttributes( s, TheTypeCapCategoryShortSequence,
    
                             CapCategory, CapCategory( alpha ) );
                             
    return s;
    
end );

InstallMethodWithCache( CreateShortExactSequence, 
              
              [ IsCapCategoryMorphism, IsCapCategoryMorphism ], 
               
   function( alpha, beta )
   local s, coker_alpha, coker_colift, ker_beta, ker_lift;
   
   
   # the two morphisms should be composable
   
   if not IsEqualForObjects( Range( alpha ), Source( beta ) ) then 
   
       Error( "Range of the first morphism should equal the Source of the second morphism" );
     
   fi;
   
   # img alpha should be contained in ker of alpha
   
   if not IsZeroForMorphisms( PreCompose( alpha, beta ) ) then 
   
       Error( "The composition of the two morphisms is not Zero" );
     
   fi;
   
   ## alpha should be the kernel of beta ..
   
   ker_beta := KernelEmbedding( beta );
   
   ker_lift := KernelLift( beta, alpha );
   
   if not IsIsomorphism( ker_lift ) then 
   
      Error( "The first morphism is not kernel of the second morphism, thus the given sequence can not be exact" );
      
   fi;
   
   ## beta should be the cokernel of alpha
   
   coker_alpha  := CokernelProjection( alpha );
   
   coker_colift := CokernelColift( alpha, beta );
   
   if not IsIsomorphism( coker_colift ) then 
   
      Error( "The second morphism is not cokernel of the first morphism, thus the given sequence can not be exact" );
      
   fi;
   
   s := rec( object1:= Source( alpha ), 
             
             morphism1:= alpha,
             
             object2 := Range( alpha ),
             
             morphism2 := beta,
             
             object3 := Range( beta ) );
             
    ObjectifyWithAttributes( s, TheTypeCapCategoryShortExactSequence,
    
                             CapCategory, CapCategory( alpha ) );
                             
    return s;
    
end );
 
InstallMethodWithCache( CreateConflation, 
 
                       [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
    function( alpha, beta )
    local s, coker_alpha, coker_colift, ker_beta, ker_lift;
   
   
   # the two morphisms should be composable
   
   if not IsEqualForObjects( Range( alpha ), Source( beta ) ) then 
   
       Error( "Range of the first morphism should equal the Source of the second morphism" );
     
   fi;
   
   # img alpha should be contained in ker of alpha
   
   if not IsZeroForMorphisms( PreCompose( alpha, beta ) ) then 
   
       Error( "The composition of the two morphisms is not Zero" );
     
   fi;
   
   ## alpha should be the kernel of beta ..
   
   ker_beta := KernelEmbedding( beta );
   
   ker_lift := KernelLift( beta, alpha );
   
   if not IsIsomorphism( ker_lift ) then 
   
      Error( "The first morphism is not kernel of the second morphism, thus the given sequence can not be exact" );
      
   fi;
   
   ## beta should be the cokernel of alpha
   
   coker_alpha  := CokernelProjection( alpha );
   
   coker_colift := CokernelColift( alpha, beta );
   
   if not IsIsomorphism( coker_colift ) then 
   
      Error( "The second morphism is not cokernel of the first morphism, thus the given sequence can not be exact" );
      
   fi;
   
   s := rec( object1:= Source( alpha ), 
             
             morphism1:= alpha,
             
             object2 := Range( alpha ),
             
             morphism2 := beta,
             
             object3 := Range( beta ) );
             
    ObjectifyWithAttributes( s, TheTypeCapCategoryConflation,
    
                             CapCategory, CapCategory( alpha ) );
                             
    return s;
    
end );
    
    
##############################
##
## View
##
##############################   
    
InstallMethod( ViewObj,
               
               [ IsCapCategoryShortSequence ], 
               
  function( seq )
  
    if IsCapCategoryConflation( seq ) then 
    
       Print( "<A Conflation in ", CapCategory( seq ), ">" );
    
    elif IsCapCategoryShortExactSequence( seq ) then 
    
       Print( "<A short exact sequence in ", CapCategory( seq ), ">" );
   
    else 
   
       Print( "<A short sequence in ", CapCategory( seq ), ">" );
   
    fi;
    
end );

#################################
##
## Display
##
#################################

InstallMethod( Display, 
              
              [ IsCapCategoryShortSequence ], 
              
   function( seq )
   
   Print( "           morphism1                  morphism2\n" );
   Print( "object1 ----------------> object2 -----------------> object3\n" );
   
   Print( "\nobject1 is\n" ); Display( seq!.object1 );
   
   Print( "\n\nmorphism1 is\n" ); Display( seq!.morphism1 );
   
   Print( "\n\nobject2 is\n" ); Display( seq!.object2 );
  
   Print( "\n\nmorphism2 is\n" ); Display( seq!.morphism2 );
   
   Print( "\n\nobject3 is\n" ); Display( seq!.object3 );
   
end );


################################
##
## Immediate Methods and Attributes 
##
################################

InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS_FOR_FROBENIUS_CATEGORY,
               IsCapCategory and IsFrobeniusCategory, 
               0,
               
   function( category )
   
   AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "FrobeniusCategoriesForCAP", "LogicForFrobeniusCategories" ),
        "PredicateImplicationsForGeneralFrobeniusCategories.tex" ) );
     
end );

InstallMethod( AsInflation, 
                  [ IsCapCategoryMorphism ],
                  
    function( alpha )
    
    if IsCapCategoryInflation( alpha ) then 
    
       return alpha;
       
    elif HasIsInflation( alpha ) and IsInflation( alpha ) then 
    
       SetFilterObj( alpha, IsCapCategoryInflation );
       
    elif not CanCompute( CapCategory( alpha ), "IsInflation" ) then 
    
       Error( "There is no method to decide if the morphism is an inflation or not" );
       
    elif not IsInflation( alpha ) then 
    
       Error( "The morphism is not inflation" );
     
    else
    
       SetFilterObj( alpha, IsCapCategoryInflation );
    
    fi;
    
    return alpha;
    
end );

InstallMethod( AsDeflation, 
                  [ IsCapCategoryMorphism ],
                  
    function( alpha )
    
    if IsCapCategoryDeflation( alpha ) then 
    
       return alpha;
       
    elif HasIsDeflation( alpha ) and IsDeflation( alpha ) then 
    
      SetFilterObj( alpha, IsCapCategoryDeflation );
       
    elif not CanCompute( CapCategory( alpha ), "IsDeflation" ) then 
    
       Error( "There is no method to decide if the morphism is an deflationor not" );
       
    elif not IsDeflation( alpha ) then 
    
       Error( "The morphism is not deflation" );
     
    else
    
    SetFilterObj( alpha, IsCapCategoryDeflation );
    
    fi;
    
    return alpha;
    
end );

InstallMethod( ConflationOfInflation, 
               [ IsCapCategoryInflation ], 
   function( alpha )
   
   return CreateConflation( alpha, CokernelProjection( alpha ) );
   
end );

InstallMethod( ConflationOfDeflation, 
               [ IsCapCategoryDeflation ], 
   function( alpha )
   
   return CreateConflation( KernelEmbedding( alpha ), alpha );
   
end );
