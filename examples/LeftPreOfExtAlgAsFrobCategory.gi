



## ReadPackage( "FrobeniusCategoriesForCAP", "examples/LeftPreOfExtAlgAsFrobCategory.gi" );


LoadPackage( "ModulePresentations" );
LoadPackage( "FrobeniusCategoriesForCap" );

R := KoszulDualRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );

category := LeftPresentations( R:FinalizeCategory := false );

TurnAbelianCategoryToExactCategory( category );

############################################
##
## Giving the category Frobenius structure
##
###########################################

SetIsFrobeniusCategory( category, true );

AddFitIntoConflationUsingProjectiveObject( category, function( obj )
                                                     
                                                         return ConflationOfDeflation( AsDeflation( CoverByFreeModule( obj ) ) );
                                                         
                                                     end );

AddFitIntoConflationUsingInjectiveObject( category, function( obj )
                                                    local ring, dual, nat, dual_obj, free_cover, dual_free_cover, obj_to_double_dual_obj, embedding;
                                                    
                                                    ring := UnderlyingHomalgRing( obj );
                                                    
                                                    dual := FunctorDualForLeftPresentations( ring );
                                                    
                                                    nat  := NaturalTransformationFromIdentityToDoubleDualForLeftPresentations( ring );
                                                    
                                                    dual_obj := ApplyFunctor( dual, obj );
                                                    
                                                    free_cover := CoverByFreeModule( dual_obj );
                                                    
                                                    dual_free_cover := ApplyFunctor( dual, free_cover );
                                                    
                                                    obj_to_double_dual_obj := ApplyNaturalTransformation( nat, obj );
                                                    
                                                    embedding := PreCompose( obj_to_double_dual_obj, dual_free_cover );
                                                    
                                                    return ConflationOfInflation( AsInflation( embedding ) );
                                                    
                                                    end );

# InjectiveColift can be derived from Colift, hence I will only add a method for Colift.

AddColift( category, 

    function( mono, morphism )
    local N, M, A, B, I, B_over_M, zero_mat, A_over_zero, sol, XX;
    #                 rxs
    #                I
    #                ꓥ
    #         vxs    | nxs 
    #       ?X      (A) 
    #                |
    #                |
    #    uxv    nxv   mxn
    #   M <----(B)-- N
    #
    #
    # We need to solve the system
    #     B*X + Y*I = A
    #     M*X + Z*I = 0
    # i.e.,
    #        [ B ]            [ Y ]        [ A ]
    #        [   ] * X   +    [   ] * I =  [   ]
    #        [ M ]            [ Z ]        [ 0 ]
    #
    # the function is supposed to return X as a ( well defined ) morphism from M to I.
    
    I := UnderlyingMatrix( Range( morphism ) );
    
    N := UnderlyingMatrix( Source( mono ) );
    
    M := UnderlyingMatrix( Range( mono ) );
    
    B := UnderlyingMatrix( mono );
    
    A := UnderlyingMatrix( morphism );
    
    B_over_M := UnionOfRows( B, M );
    
    zero_mat := HomalgZeroMatrix( NrRows( M ), NrColumns( I ), R );
    
    A_over_zero := UnionOfRows( A, zero_mat );

    sol := SolveTwoSidedEquationOverExteriorAlgebra( B_over_M, A_over_zero );
    
    if sol= fail then 
    
       return fail;
       
    else 
    
       return PresentationMorphism( Range( mono ), sol[ 1 ], Range( morphism ) );
       
    fi;
    
    end );
    
# AddIsProjective( category, function( obj )
#                            local cover, lift; 
#                            
#                            cover := CoverByFreeModule( obj );
#                            
#                            lift := Lift( IdentityMorphism( obj ), cover );
#                            
#                            if lift = fail then 
#                            
#                               return false;
#                               
#                            else 
#                            
#                               return true;
#                               
#                            fi;
#                            
#                            end );
# 
# AddIsInjective( category, function( obj )
#                           
#                           return IsProjective( obj );
#                           
#                           end );

# AddProjectiveLift( category,  function( morphism, epi )
#                               local mat;
#                               
#                               mat := UnderlyingMatrix( Source( morphism ) );
#                               
#                               if not NrRows( mat ) = 0 then
#                               
#                                  return fail;
#                                  
#                               fi;
#                              
#                               return Lift( morphism, epi );
#                               
#                               end );

Finalize( category );