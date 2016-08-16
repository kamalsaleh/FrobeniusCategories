


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

BindGlobal( "CapCategoryMorphismsOfShortSequencesFamily",
  NewFamily( "CapCategoryMorphismsOfShortSequencesFamily", IsObject ) );
  
BindGlobal( "TheTypeCapCategoryShortSequence", 
  NewType( CapCategoryShortSequencesFamily, 
                      IsCapCategoryShortSequenceRep ) );
                      
BindGlobal( "TheTypeCapCategoryExactShortSequence", 
  NewType( CapCategoryExactShortSequencesFamily, 
                      IsCapCategoryExactShortSequenceRep ) );
                      
BindGlobal( "TheTypeCapCategoryMorphismOfShortSequences", 
  NewType( CapCategoryMorphismsOfShortSequencesFamily, 
                      IsCapCategoryMorphismOfShortSequencesRep ) );
       
                        
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

InstallMethodWithCache( CreateShortExactSequence, 
              
              [ IsCapCategoryMorphism, IsCapCategoryMorphism ], 
               
   function( alpha, beta )
   local s;
   
   
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
 
