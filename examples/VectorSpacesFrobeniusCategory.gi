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

Q := HomalgFieldOfRationalsInSingular( );
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

AddFitIntoConflationUsingInjectiveObject( category, function( obj )
                                                    
                                                       return ConflationOfInflation( AsInflation( IdentityMorphism( obj ) ) );
                                                    
                                                    end );

AddFitIntoConflationUsingProjectiveObject( category, function( obj )
                                                    
                                                       return ConflationOfDeflation( AsDeflation( IdentityMorphism( obj ) ) );
                                                    
                                                    end );

AddInjectiveColift( category, function( mono, morphism )
                              local mono_matrix, mor_matrix, matrix_of_colift;
                              
                              mono_matrix := UnderlyingMatrix( mono );
                              
                              mor_matrix := UnderlyingMatrix( morphism );
                              
                              matrix_of_colift := LeftDivide( mono_matrix, mor_matrix );
                              
                              return VectorSpaceMorphism( Range( mono ), matrix_of_colift, Range( morphism ) );
                              
                              end );
                              
AddProjectiveLift( category, function( morphism, epi )
                              local mor_matrix, epi_matrix, matrix_of_lift;
                              
                              mor_matrix := UnderlyingMatrix( morphism );
                              
                              epi_matrix := UnderlyingMatrix( epi );
                              
                              matrix_of_lift := RightDivide( mor_matrix, epi_matrix );
                              
                              return VectorSpaceMorphism( Source( morphism ), matrix_of_lift, Source( epi ) );
                              
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
#! <A 6 x 2 matrix over an external ring>
f := VectorSpaceMorphism( Q6, F, Q2 );
#! <A morphism in Category of matrices over Q>
Q7 := VectorSpaceObject( 7, Q );
#! <A vector space object over Q of dimension 7>
G := HomalgMatrix( [ [  22,   4 ], [   3,  52 ], [  13,  62 ], [   2,  73 ], [   3,  84 ], [   1,  91 ], [  10,   0 ] ], 7, 2, Q );
#! <A 7 x 2 matrix over an external ring>
g := VectorSpaceMorphism( Q7, G, Q2 );
#! <A morphism in Category of matrices over Q>
IsDeflation( f );
#! true
IsCapCategoryDeflation( f );
#! true
conf := ConflationOfDeflation( f );
#! <A Conflation in Category of matrices over Q>
Display( conf );
#!            morphism1                  morphism2
#! object1 ----------------> object2 -----------------> object3
#! 
#! object1 is
#! An object in Category of matrices over Q.
#! 
#! 
#! morphism1 is
#! -13,8,2,0,0,0,
#! -11,6,0,2,0,0,
#! -9, 4,0,0,2,0,
#! -11,7,0,0,0,1 
#! 
#! A split monomorphism in Category of matrices over Q
#! 
#! object2 is
#! An object in Category of matrices over Q.
#! 
#! 
#! morphism2 is
#! 2,4,
#! 3,5,
#! 1,6,
#! 2,7,
#! 3,8,
#! 1,9 
#! 
#! A split epimorphism in Category of matrices over Q
#! 
#! object3 is
#! An object in Category of matrices over Q.
Fiber := FiberProductObjectInducedByStructureOfExactCategory( f, g );
#! <A vector space object over Q of dimension 11>
projections := ProjectionsOfFiberProductInducedByStructureOfExactCategory( f, g );
#! [ <A morphism in Category of matrices over Q>, <A split epimorphism in Category of matrices over Q> ]
IsDeflation( projections[ 2 ] );
#! true
Display( ConflationOfDeflation( projections[ 2 ] ) );
#!            morphism1                  morphism2
#! object1 ----------------> object2 -----------------> object3
#! 
#! object1 is
#! An object in Category of matrices over Q.
#! 
#! 
#! 
#! morphism1 is
#! 1,0,0,0,0,0,0,0,0,0,0,
#! 0,1,0,0,0,0,0,0,0,0,0,
#! 0,0,1,0,0,0,0,0,0,0,0,
#! 0,0,0,1,0,0,0,0,0,0,0 
#! 
#! A split monomorphism in Category of matrices over Q
#! 
#! object2 is
#! An object in Category of matrices over Q.
#! 
#! 
#! morphism2 is
#! 0,0,0,0,0,0,0,
#! 0,0,0,0,0,0,0,
#! 0,0,0,0,0,0,0,
#! 0,0,0,0,0,0,0,
#! 1,0,0,0,0,0,0,
#! 0,2,0,0,0,0,0,
#! 0,0,2,0,0,0,0,
#! 0,0,0,2,0,0,0,
#! 0,0,0,0,2,0,0,
#! 0,0,0,0,0,1,0,
#! 0,0,0,0,0,0,1 
#! 
#! A split epimorphism in Category of matrices over Q
#! 
#! object3 is
#! An object in Category of matrices over Q.
p1 := 13*projections[ 1 ];
#! <A morphism in Category of matrices over Q>
p2 := 13*projections[ 2 ];
#! <A morphism in Category of matrices over Q>
u:= UniversalMorphismIntoFiberProductInducedByStructureOfExactCategory( [ f, g ], [ p1, p2 ] );
#! <A morphism in Category of matrices over Q>
Display( u );
#! 13,0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
#! 0, 13,0, 0, 0, 0, 0, 0, 0, 0, 0,
#! 0, 0, 13,0, 0, 0, 0, 0, 0, 0, 0,
#! 0, 0, 0, 13,0, 0, 0, 0, 0, 0, 0,
#! 0, 0, 0, 0, 13,0, 0, 0, 0, 0, 0,
#! 0, 0, 0, 0, 0, 13,0, 0, 0, 0, 0,
#! 0, 0, 0, 0, 0, 0, 13,0, 0, 0, 0,
#! 0, 0, 0, 0, 0, 0, 0, 13,0, 0, 0,
#! 0, 0, 0, 0, 0, 0, 0, 0, 13,0, 0,
#! 0, 0, 0, 0, 0, 0, 0, 0, 0, 13,0,
#! 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13
#! 
#! A morphism in Category of matrices over Q

##
##                     s:= [ [ 3 ] ]           [  ]
##                 Q >-----------------> Q ----------->> 0
##                 ¦                     ¦ 
##   t = [ [ 4 ] ] ¦                     ¦ ?
##                 ¦                     ¦
##                 ꓦ                     ꓦ
##                 Q >-----------------> ? ----------->> ?
##                            ?                 ?

Q1 := VectorSpaceObject( 1, Q );
#! <A vector space object over Q of dimension 1>
s := VectorSpaceMorphism( Q1, HomalgMatrix( [ [ 3 ] ], 1, 1, Q ), Q1 );
#! <A morphism in Category of matrices over Q>
t := VectorSpaceMorphism( Q1, HomalgMatrix( [ [ 4 ] ], 1, 1, Q ), Q1 );
#! <A morphism in Category of matrices over Q>
pushout := PushoutObjectInducedByStructureOfExactCategory( AsInflation( s ), t );
#! <A vector space object over Q of dimension 1>
injections := InjectionsOfPushoutInducedByStructureOfExactCategory( s, t );
#! [ <A morphism in Category of matrices over Q>, <A split monomorphism in Category of matrices over Q> ]
Display( injections[ 1 ] );
#! 4
#!
#! A morphism in Category of matrices over Q
Display( injections[ 2 ] );
#! 3
#! 
#! A split monomorphism in Category of matrices over Q
i1 := VectorSpaceMorphism( Q1, HomalgMatrix( [ [ 8 ] ], 1, 1, Q ), Q1 );                   
#! <A morphism in Category of matrices over Q>
i2 := VectorSpaceMorphism( Q1, HomalgMatrix( [ [ 6 ] ], 1, 1, Q ), Q1 );
#! <A morphism in Category of matrices over Q>
v := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ s, t ], [ i1, i2 ] );
#! <A morphism in Category of matrices over Q>
Display( v );
#! 2
#! 
#! A morphism in Category of matrices over Q
Display( FitIntoConflationUsingInjectiveObject( Q6 ) );
#!           morphism1                  morphism2
#! object1 ----------------> object2 -----------------> object3
#! 
#! object1 is
#! An object in Category of matrices over Q.
#! 
#! 
#! morphism1 is
#! 1,0,0,0,0,0,
#! 0,1,0,0,0,0,
#! 0,0,1,0,0,0,
#! 0,0,0,1,0,0,
#! 0,0,0,0,1,0,
#! 0,0,0,0,0,1 
#! 
#! An identity morphism in Category of matrices over Q
#! 
#! object2 is
#! An object in Category of matrices over Q.
#! 
#! 
#! morphism2 is
#! (an empty 6 x 0 matrix)
#! 
#! A zero, split epimorphism in Category of matrices over Q
#! 
#! object3 is
#! A zero object in Category of matrices over Q.
Display( FitIntoConflationUsingProjectiveObject( Q6 ) );
#!           morphism1                  morphism2
#! object1 ----------------> object2 -----------------> object3
#! 
#! object1 is
#! A zero object in Category of matrices over Q.
#! 
#! 
#! morphism1 is
#! (an empty 0 x 6 matrix)
#! 
#! A zero, split monomorphism in Category of matrices over Q
#! 
#! object2 is
#! An object in Category of matrices over Q.
#! 
#!  
#! morphism2 is
#! 1,0,0,0,0,0,
#! 0,1,0,0,0,0,
#! 0,0,1,0,0,0,
#! 0,0,0,1,0,0,
#! 0,0,0,0,1,0,
#! 0,0,0,0,0,1 
#! 
#! An identity morphism in Category of matrices over Q
#!
#! object3 is
#! An object in Category of matrices over Q.

