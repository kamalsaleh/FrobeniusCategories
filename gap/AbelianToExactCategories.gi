##############################################################
##  AbelianToExactCategories.gd           Kamal Saleh
##
##                                        Siegen University 
##############################################################

BindGlobal( "TURN_ABELIAN_CATEGORY_TO_EXACT_CATEGORY",

function( category )

if not IsAbelianCategory( category ) then 
   
   Error( "The given category is supposed to be abelian" );
   
fi;

if HasIsFinalized( category ) then 

   Error( "The category is finalized and hence no methods can be added!\n" );

fi;

## We define the class of conflations to be the class of all short exact sequences.

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

# In Abelian categories every mono is the kernel mono of its cokernel epi;

AddIsInflation( category, function( mor )
                          
                          return IsMonomorphism( mor );
                          
                          end );

## I Abelian categories every epi is the cokernel epi of its kernel mono;
                          
AddIsDeflation( category, function( mor )
                          
                          return IsEpimorphism( mor );
                          
                          end );
                          
AddFiberProductObjectInducedByStructureOfExactCategory( category, function( def, mor )
                                                               
                                                               return FiberProduct( def, mor );
                                                               
                                                               end );

AddProjectionsOfFiberProductInducedByStructureOfExactCategory( category,  function(  def, mor )
                                local gamma, beta;
       
                                gamma := ProjectionInFactorOfFiberProduct( [ def, mor ], 1 );

                                beta  := AsDeflation( ProjectionInFactorOfFiberProduct( [ def, mor ], 2 ) );

                                return [ gamma, beta ];
        
                                end );
                                
AddUniversalMorphismIntoFiberProductInducedByStructureOfExactCategory( category, function( D, tau )
                                                     
                                                     return UniversalMorphismIntoFiberProduct( D, tau );
                                                     
                                                     end );


AddPushoutObjectInducedByStructureOfExactCategory( category, function( inf, mor )
                                                               
                                                               return Pushout( inf, mor );
                                                               
                                                               end );

AddInjectionsOfPushoutInducedByStructureOfExactCategory( category,  function( inf, mor )
                                local gamma, beta;
       
                                gamma := InjectionOfCofactorOfPushout( [ inf, mor ], 1 );

                                beta  := AsInflation( InjectionOfCofactorOfPushout( [ inf, mor ], 2 ) );

                                return [ gamma, beta ];
       
                                end );

AddUniversalMorphismFromPushoutInducedByStructureOfExactCategory( category, function( D, tau )
                                                
                                                return UniversalMorphismFromPushout( D, tau );
        
                                                end );
                                                
SetIsExactCategory( category, true );
                                                
return category;

end );


##
InstallMethod( TurnAbelianCategoryToExactCategory, 
                     [ IsCapCategory ], 
                     
   function( category )
   
   TURN_ABELIAN_CATEGORY_TO_EXACT_CATEGORY( category );
   
   end );
