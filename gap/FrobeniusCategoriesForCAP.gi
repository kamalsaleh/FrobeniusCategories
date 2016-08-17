


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
##  
##
###############################

InstallValue( CAP_INTERNAL_FROBENIUS_CATEGORIES_BASIC_OPERATIONS, rec( ) );

InstallValue( FROBENIUS_CATEGORIES_METHOD_NAME_RECORD, rec( 

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
   
   Print( "object1 --(morphism1)--> object2 --(morphism2)--> object3\n" );
   
   Print( "\nobject1 is\n" ); Display( seq!.object1 );
   
   Print( "\n\nmorphism1 is\n" ); Display( seq!.morphism1 );
   
   Print( "\n\nobject2 is\n" ); Display( seq!.object2 );
  
   Print( "\n\nmorphism2 is\n" ); Display( seq!.morphism2 );
   
   Print( "\n\nobject3 is\n" ); Display( seq!.object3 );
   
end );
  

  
   





























  
  
  
  
  
  