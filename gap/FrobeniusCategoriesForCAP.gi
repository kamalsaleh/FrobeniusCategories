


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


FR3 := rec( 

installation_name := "FR3", 
filter_list := [ IsCapCategoryConflation, IsCapCategoryConflation ],
cache_name := "FR3",

pre_function := function( conf1, conf2 )
                
                if not IsEqualForObjects( conf2!.object2, conf1!.object3 ) then 
                
                  return [ false, "The deflations of the given conflations are not composable" ];
                  
                fi;
                
                return [ true ];
                
                end,
                
return_type := [ IsCapCategoryConflation ],

post_function := function( conf1, conf2, return_value )
                 
                 if not IsEqualForMorphisms( PreCompose( conf1!.morphism2, conf2!.morphism2 ), return_value!.morphism2 ) then 
                 
                     Error( "The deflation of the output computed by your function of FR3 should equal the composition of the deflations of the conflations that are given as input" );
                  
                 fi;
                 
                 end ),
                 
FR4 := rec( 

installation_name := "FR4", 
filter_list := [ IsCapCategoryConflation, IsCapCategoryConflation ],
cache_name := "FR4",

pre_function := function( conf1, conf2 )
                
                if not IsEqualForObjects( conf2!.object1, conf1!.object2 ) then 
                
                  return [ false, "The inflations of the given conflations are not composable" ];
                  
                fi;
                
                return [ true ];
                
                end,
                
return_type := [ IsCapCategoryConflation ],

post_function := function( conf1, conf2, return_value )
                 
                 if not IsEqualForMorphisms( PreCompose( conf1!.morphism1, conf2!.morphism1 ), return_value!.morphism1 ) then 
                 
                     Error( "The inflation of the output computed by your function of FR4 should equal the composition of the inflations of the conflations that are given as input" );
                  
                 fi;
                 
                 end ),
              
FR5:= rec( 

installation_name := "FR5", 
filter_list := [ IsCapCategoryConflation, "morphism" ],
cache_name := "FR5",

pre_function := function( conf, mor )
                local is_equal_for_objects;
                
                is_equal_for_objects := IsEqualForObjects( conf!.object3, Range( mor ) );
                
                if is_equal_for_objects = fail then 
                
                    return [ false, "Cannot decide if the object3 in the conflation is equal to the range of the given morphism" ];
                 
                elif is_equal_for_objects = false then 
                
                    return  [ false, "The object3 in the conflation is not equal to the range of the input morphism" ];
                    
                else 
                
                    return [ true ];
                    
                fi;
                
                end,
                
return_type := [ IsCapCategoryConflation, "morphism" ],

post_function := function( conf, mor, return_value )
                 
                 if not IsEqualForObjects( return_value[ 1 ]!.object3, Source( mor ) ) then 
                 
                    Error( "Object3 of output conflation is not equal to the source of the input morphism" );
                 
                 fi;
                 
                 if not IsEqualForObjects( return_value[ 1 ]!.object2, Source( return_value[ 2 ] ) ) then 
                 
                    Error( "Object2 of output conflation is not equal to the source of the output morphism" );
                    
                 fi;
                 
                 
                 if not IsEqualForMorphisms( PreCompose( return_value[ 2], conf!.morphism2 ), PreCompose( return_value[ 1 ]!.morphism2, mor ) ) then 
                 
                    Error( "The function given does not provid a Pullback, since the diagram resulted is not commutative" );
                    
                 fi;
                 
                 end ),
FiberProductByFR5:= rec( 

installation_name := "FiberProductByFR5", 
filter_list := [ IsCapCategoryConflation, "morphism" ],
cache_name := "FiberProductByFR5",
return_type := "object",

post_function := function( conf, mor, return_value )
 
                 AddToGenesis( return_value, "FiberProductDiagramByFR5", [ conf, mor ] );
                 
                 end ),                 


ProjectionsOfFiberProductByFR5:= rec( 

installation_name := "ProjectionsOfFiberProductByFR5", 
filter_list := [ IsCapCategoryConflation, "morphism" ],
cache_name := "ProjectionsOfFiberProductByFR5",
return_type := [ "morphism", "morphism" ] ),                 

UniversalMorphismIntoFiberProductByFR5:= rec( 

installation_name := "UniversalMorphismIntoFiberProductByFR5", 
filter_list := [ IsList, IsList ],
cache_name := "UniversalMorphismIntoFiberProductByFR5",

pre_function:= function( D, tau )
               local f,g, is_equal_for_morphisms;
               
               if not IsCapCategoryConflation( D[ 1 ] ) then 
               
                  return [ false, "The first entry of the first list should be a conflation" ];
                  
               fi;
               
               if not IsCapCategoryMorphism( D[ 2 ] ) then
                 
                  return [ false, "The second entry of the first list should be a morphism" ];
                  
               fi;
               
               if not IsCapCategoryMorphism( tau[ 1 ] ) or not IsCapCategoryMorphism( tau[ 2 ] ) then
               
                  return [ false, "The second list should be list of two morphisms" ];
                  
               fi;
               
               
               f := D[ 1 ]!.morphism2;
               g := D[ 2 ];
               
               is_equal_for_morphisms := IsEqualForMorphisms( PreCompose( tau[ 1 ], f ), PreCompose( tau[ 2 ], g ) );
               
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
                 
                 p := ProjectionsOfFiberProductByFR5( D[ 1 ], D [ 2 ] );
                 
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

FR6:= rec( 

installation_name := "FR6", 
filter_list := [ IsCapCategoryConflation, "morphism" ],
cache_name := "FR6",

pre_function := function( conf, mor )
                local is_equal_for_objects;
                
                is_equal_for_objects := IsEqualForObjects( conf!.object1, Source( mor ) );
                
                if is_equal_for_objects = fail then 
                
                    return [ false, "Cannot decide if the object1 in the conflation is equal to the source of the given morphism" ];
                 
                elif is_equal_for_objects = false then 
                
                    return  [ false, "The object1 in the conflation is not equal to the source of the input morphism" ];
                    
                else 
                
                    return [ true ];
                    
                fi;
                
                end,
                
return_type := [ IsCapCategoryConflation, "morphism" ],

post_function := function( conf, mor, return_value )
                 
                 if not IsEqualForObjects( return_value[ 1 ]!.object1, Range( mor ) ) then 
                 
                    Error( "Object1 of output conflation is not equal to the range of the input morphism" );
                 
                 fi;
                 
                 if not IsEqualForObjects( return_value[ 1 ]!.object2, Range( return_value[ 2 ] ) ) then 
                 
                    Error( "Object2 of output conflation is not equal to the range of the output morphism" );
                    
                 fi;
                 
                 
                 if not IsEqualForMorphisms( PostCompose( return_value[ 2 ], conf!.morphism1 ), PostCompose( return_value[ 1 ]!.morphism1, mor ) ) then 
                 
                    Error( "The function given does not provid a pushout, since the diagram resulted is not commutative" );
                    
                 fi;
                 
                 end ),
                 
PushoutByFR6:= rec( 

installation_name := "PushoutByFR6", 
filter_list := [ IsCapCategoryConflation, "morphism" ],
cache_name := "PushoutByFR6",
return_type := "object",

post_function := function( conf, mor, return_value )
 
                 AddToGenesis( return_value, "PushoutDiagramByFR6", [ conf, mor ] );
                 
                 end ),
                 
InjectionsOfPushoutByFR6:= rec( 

installation_name := "InjectionsOfPushoutByFR6", 
filter_list := [ IsCapCategoryConflation, "morphism" ],
cache_name := "InjectionsOfPushoutByFR6",
return_type := [ "morphism", "morphism" ] ),                 


UniversalMorphismFromPushoutByFR6:= rec( 

installation_name := "UniversalMorphismFromPushoutByFR6", 
filter_list := [ IsList, IsList ],
cache_name := "UniversalMorphismFromPushoutByFR6",

pre_function:= function( D, tau )
               local f,g, is_equal_for_morphisms;
               
               if not IsCapCategoryConflation( D[ 1 ] ) then 
               
                  return [ false, "The first entry of the first list should be a conflation" ];
                  
               fi;
               
               if not IsCapCategoryMorphism( D[ 2 ] ) then
                 
                  return [ false, "The second entry of the first list should be a morphism" ];
                  
               fi;
               
               if not IsCapCategoryMorphism( tau[ 1 ] ) or not IsCapCategoryMorphism( tau[ 2 ] ) then
               
                  return [ false, "The second list should be list of two morphisms" ];
                  
               fi;
               
               
               f := D[ 1 ]!.morphism1;
               g := D[ 2 ];
               
               is_equal_for_morphisms := IsEqualForMorphisms( PostCompose( tau[ 1 ], f ), PostCompose( tau[ 2 ], g ) );
               
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
                 
                 p :=InjectionsOfPushoutByFR6( D[ 1 ], D [ 2 ] );
                 
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
