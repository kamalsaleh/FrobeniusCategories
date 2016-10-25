##############################################################
##  AbelianToExactCategories.gd           Kamal Saleh
##
##                                        Siegen University 
##############################################################

BindGlobal( "TURN_ABELIAN_CATEGORY_TO_EXACT_CATEGORY",

function( category )

if HasIsFinalized( category ) then 

   return Error( "The category is finalized and hence no methods can be added!\n" );

fi;

## 
## A short sequence is conflation when it is exact

AddIsConflation( category, function( sequence )
                              local alpha, beta, s, coker_alpha, coker_colift, ker_beta, ker_lift;
                              alpha := sequence!.morphism1;
                              
                              beta  := sequence!.morphism2;
                              
                              ## alpha should be the kernel of beta ..
   
                              ker_beta := KernelEmbedding( beta );
   
                              ker_lift := KernelLift( beta, alpha );
   
                              if not IsIsomorphism( ker_lift ) then 
   
                                 return false;
                                 
                              fi;
   
                              ## beta should be the cokernel of alpha
   
                              coker_alpha  := CokernelProjection( alpha );
   
                              coker_colift := CokernelColift( alpha, beta );
   
                              if not IsIsomorphism( coker_colift ) then 
   
                                  return false;
                                  
                              fi;

                              return true;

                              end );

AddFR3( category, function( conf1, conf2 )
                          local alpha, beta;
       
                          beta := PreCompose( conf1!.morphism2, conf2!.morphism2 );
       
                          alpha := KernelEmbedding( beta );
       
                          return CreateConflation( alpha, beta );
       
                          end );
   
AddFR4( category,  function( conf1, conf2 )
                          local alpha, beta;
       
                          alpha := PreCompose( conf1!.morphism1, conf2!.morphism1 );
       
                          beta := CokernelProjection( alpha );
       
                          return CreateConflation( alpha, beta );
       
                          end );
                          
AddFR5( category,  function( conf, mor )
                                local f,g, gamma, beta;
       
                                f:= conf!.morphism2;
                                g:= mor;
       
                                f := f!.morphism;
                                g := g!.morphism;
       
       
                                gamma := ProjectionInFactorOfFiberProduct( [ f, g ], 1 );

                                beta  := ProjectionInFactorOfFiberProduct( [ f, g ], 2 );

                                return [ CreateConflation( KernelEmbedding( beta ), beta ), gamma ];
        
                                end );
                                
AddUniversalMorphismIntoFiberProductByFR5( category, function( D, tau )
                                                     local D1, universal_morphism;  
                                                     
                                                     D1 := [ D[ 1 ]!.morphism2, D[ 2 ] ];
                                                     
                                                     universal_morphism := UniversalMorphismIntoFiberProduct( D1, tau );
                                                     
                                                     return universal_morphism;
                                                     
                                                     end );


AddFR6( category,  function( conf, mor )
                                local f,g, gamma, beta;
       
                                f:= conf!.morphism1;
                                g:= mor;
       
                                f := f!.morphism;
                                g := g!.morphism;
       
                                gamma := InjectionOfCofactorOfPushout( [ f, g ], 1 );

                                beta  := InjectionOfCofactorOfPushout( [ f, g ], 2 );

                                return [ CreateConflation( beta, CokernelProjection( beta ) ), gamma ];
       
                                end );

AddUniversalMorphismFromPushoutByFR6( category, function( D, tau )
                                                local D1, universal_morphism;
        
                                                D1 := [ D[ 1 ]!.morphism1, D[ 2 ] ];
        
                                                universal_morphism := UniversalMorphismFromPushout( D1, tau );
        
                                                return universal_morphism ;
                                                
                                                end );
                                                
return category;

end );
