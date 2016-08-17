


#######################################
##
## Representations
##
#######################################


DeclareRepresentation( "IsCapCategoryShortSequenceRep",
                        IsCapCategoryShortSequence and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryExactShortSequenceRep",

                        IsCapCategoryExactShortSequence and IsAttributeStoringRep,
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

BindGlobal( "CapCategoryExactShortSequencesFamily",
  NewFamily( "CapCategoryExactShortSequencesFamily", IsCapCategoryShortSequence ) );

BindGlobal( "CapCategoryConflationsFamily",
  NewFamily( "CapCategoryConflationsFamily", IsCapCategoryConflation ) );
  
BindGlobal( "CapCategoryMorphismsOfShortSequencesFamily",
  NewFamily( "CapCategoryMorphismsOfShortSequencesFamily", IsObject ) );
  
BindGlobal( "TheTypeCapCategoryShortSequence", 
  NewType( CapCategoryShortSequencesFamily, 
                      IsCapCategoryShortSequenceRep ) );
                      
BindGlobal( "TheTypeCapCategoryExactShortSequence", 
  NewType( CapCategoryExactShortSequencesFamily, 
                      IsCapCategoryExactShortSequenceRep ) );
                      
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
             
             object1 := Range( beta ) );
             
    ObjectifyWithAttributes( s, TheTypeCapCategoryShortSequence,
    
                             CapCategory, CapCategory( alpha ) );
                             
    return s;
    
end );

InstallMethodWithCache( CreateExactShortSequence, 
              
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
             
             object1 := Range( beta ) );
             
    ObjectifyWithAttributes( s, TheTypeCapCategoryExactShortSequence,
    
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
             
             object1 := Range( beta ) );
             
    ObjectifyWithAttributes( s, TheTypeCapCategoryConflation,
    
                             CapCategory, CapCategory( alpha ) );
                             
    return s;
    
end );
    
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
