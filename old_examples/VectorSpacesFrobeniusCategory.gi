###################################################################################
##                                                                               ##
## Giving rational vector spaces category a structure of a Frobenius category    ##
##                                                                               ##
###################################################################################

## ReadPackage( "FrobeniusCategoriesForCAP", "examples/VectorSpacesFrobeniusCategory.gi" );

######################################
##
##  Loading needed packages
##
######################################

LoadPackage( "LinearAlgebraForCap" );

LoadPackage( "FrobeniusCategoriesForCap" );

#########################################
##
## Giving the category exact structure
##
#########################################

Q := HomalgFieldOfRationals( );
#! Q
category := MatrixCategory( Q:FinalizeCategory := false );
#! Category of matrices over Q
TurnAbelianCategoryToExactCategory( category );
#! Category of matrices over Q

#########################################
##
## Giving the category Frobenius structure
##
#########################################

AddFitIntoConflationUsingInjectiveObject( category, 
    function( obj )
    return ConflationOfInflation( IdentityMorphism( obj ) );                                                
end );

AddFitIntoConflationUsingProjectiveObject( category, 
    function( obj )
    return ConflationOfDeflation( IdentityMorphism( obj ) );
end );                              

Finalize( category );
#! true

####################################
##
##    Demo
##
####################################

##                       ?                    ? 
##            ? >------------------> ? ------------>> Q^7
##                                   ¦                 ¦ 
##                                 ? ¦                 ¦ g
##                                   ¦                 ¦
##                                   ꓦ                 ꓦ
##   conf:= Q^4 >-----------------> Q^6 ----------->> Q^2
##                  kernel( f )               f

Q6 := VectorSpaceObject( 6, Q );
#! <A vector space object over Q of dimension 6>
Q2 := VectorSpaceObject( 2, Q );
#! <A vector space object over Q of dimension 2>
F := HomalgMatrix( [ [  2,  4 ], [  3,  5 ], [  1,  6 ], [  2,  7 ], [  3,  8 ], [  1,  9 ] ], 6, 2, Q );
#! <A 6 x 2 matrix over an internal ring>
f := VectorSpaceMorphism( Q6, F, Q2 );
#! <A morphism in Category of matrices over Q>
Q7 := VectorSpaceObject( 7, Q );
#! <A vector space object over Q of dimension 7>
G := HomalgMatrix( [ [  22,   4 ], [   3,  52 ], [  13,  62 ], [   2,  73 ], [   3,  84 ], [   1,  91 ], [  10,   0 ] ], 7, 2, Q );
#! <A 7 x 2 matrix over an internal ring>
g := VectorSpaceMorphism( Q7, G, Q2 );
#! <A morphism in Category of matrices over Q>
IsDeflation( f );
#! true
IsCapCategoryDeflation( f );
#! true
conf := ConflationOfDeflation( f );
#! <A Conflation in Category of matrices over Q>
Display( conf );
#! A Conflation in Category of matrices over Q given by the sequence:
#! 
#!           mor_1                  mor_2
#! obj_1 ----------------> obj_2 -----------------> obj_3
#! 
#! obj_1 is
#! A vector space object over Q of dimension 4
#! 
#! mor_1 is
#! [ [  -13/2,      4,      1,      0,      0,      0 ],
#!   [  -11/2,      3,      0,      1,      0,      0 ],
#!   [   -9/2,      2,      0,      0,      1,      0 ],
#!   [    -11,      7,      0,      0,      0,      1 ] ]
#! 
#! A split monomorphism in Category of matrices over Q
#! 
#! 
#! obj_2 is
#! A vector space object over Q of dimension 6
#! 
#! mor_2 is
#! [ [  2,  4 ],
#!   [  3,  5 ],
#!   [  1,  6 ],
#!   [  2,  7 ],
#!   [  3,  8 ],
#!   [  1,  9 ] ]
#! 
#! A split epimorphism in Category of matrices over Q
#! 
#! 
#! obj_3 is
#! A vector space object over Q of dimension 2
Fiber := FiberProductObjectAlongDeflation( f, g );
#! <A vector space object over Q of dimension 11>
p1 := ProjectionInFactorOfFiberProductAlongDeflation( [ f, g ], 1 );
p2 := ProjectionInFactorOfFiberProductAlongDeflation( [ f, g ], 2 );
