LoadPackage( "Froben" );

R := KoszulDualRing( HomalgFieldOfRationalsInSingular()*"x,y,z" );

Left_Pre := LeftPresentations( R: FinalizeCategory:= false );

# Adding Frobenius structure.

#  FitIntoConflationUsingInjectiveObject 

AddFitIntoConflationUsingInjectiveObject( Left_Pre, function( M )
                                                    
                                                    end );

# cat := StableCategoryOfLeftPresentationsOverExteriorAlgebra( R );
