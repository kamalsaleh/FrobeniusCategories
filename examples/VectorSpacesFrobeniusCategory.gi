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

LoadPackage( "MatricesForHomalg" );

LoadPackage( "Gauss" );

LoadPackage( "GaussForHomalg" );

LoadPackage( "LinearAlgebraForCap" );

LoadPackage( "FrobeniusCategoriesForCap" );

########################################
##
## Declarations, Representations ...
##
########################################


DeclareRepresentation( "IsHomalgRationalVectorSpaceRep",
                        IsCapCategoryObjectRep,
                        [ ] );
                        
BindGlobal( "TheTypeOfHomalgRationalVectorSpaces",
        NewType( TheFamilyOfCapCategoryObjects,
                IsHomalgRationalVectorSpaceRep ) );

DeclareRepresentation( "IsHomalgRationalVectorSpaceMorphismRep",
                       IsCapCategoryMorphismRep,
                       [ ] );

BindGlobal( "TheTypeOfHomalgRationalVectorSpaceMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsHomalgRationalVectorSpaceMorphismRep ) );

## Attributes 


DeclareAttribute( "Dimension",
                  IsHomalgRationalVectorSpaceRep );
 
DeclareAttribute( "AsSpaceInMatrixCategory", IsHomalgRationalVectorSpaceRep ); 

DeclareAttribute( "AsMorphismInMatrixCategory", IsHomalgRationalVectorSpaceMorphismRep );


##  Methods

DeclareOperation( "QVectorSpace",
                  [ IsInt ] );
 
DeclareOperation( "QVectorSpace",
                  [ IsVectorSpaceObject ] );


DeclareOperation( "QVectorSpaceMorphism",
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ] );
                  

DeclareOperation( "QVectorSpaceMorphism",
                  [ IsObject ] );


#################################
##
## Creation of category
##
#################################
 
BindGlobal( "vecspaces", CreateCapCategory( "VectorSpaces" ) );

# SetIsAbelianCategory( vecspaces, true );

BindGlobal( "Q", HomalgFieldOfRationals( ) );

###########################################
##
## Constructors for objects and morphisms 
##
###########################################

InstallMethod( QVectorSpace,
               [ IsInt ],
               
  function( dim )
    local space;
    
    space := rec( );
    
    ObjectifyWithAttributes( space, TheTypeOfHomalgRationalVectorSpaces,
                             Dimension, dim,
                             AsSpaceInMatrixCategory, VectorSpaceObject( dim, Q )
    );
    
    Add( vecspaces, space );
    
    return space;
    
end );

InstallMethod( QVectorSpace, 
              [ IsVectorSpaceObject ], 
         
   function( space )
   
    return QVectorSpace( Dimension( space ) );
    
end );

InstallMethod( QVectorSpaceMorphism,
                  [ IsHomalgRationalVectorSpaceRep, IsObject, IsHomalgRationalVectorSpaceRep ],
                  
  function( source, matrix, range )
    local morphism, homalg_matrix;

    if not IsHomalgMatrix( matrix ) then
    
      homalg_matrix := HomalgMatrix( matrix, Dimension( source ), Dimension( range ), Q );

    else

      homalg_matrix := matrix;

    fi;

    if NrRows( homalg_matrix ) <> Dimension( source ) or NrColumns( homalg_matrix ) <> Dimension( range ) then 
                             
      Error( "The inputs are not compatible" );
    
    fi;
    
    morphism := rec( morphism := homalg_matrix );
    
    ObjectifyWithAttributes( morphism, TheTypeOfHomalgRationalVectorSpaceMorphism,
                      Source, source,
                      Range, range,
                      AsMorphismInMatrixCategory, VectorSpaceMorphism(  AsSpaceInMatrixCategory( source ), homalg_matrix, AsSpaceInMatrixCategory( range ) )
    );

    Add( vecspaces, morphism );
    
    return morphism;
    
end );

InstallMethod( QVectorSpaceMorphism,
               [ IsVectorSpaceMorphism ], 
               
 function( morphism )
 
 return QVectorSpaceMorphism( QVectorSpace( Source( morphism ) ), morphism!.UnderlyingMatrix, QVectorSpace( Range( morphism ) ) );
              
end );

InstallMethod( QVectorSpaceMorphism, 
                 [ IsObject ],
                 
  function( matrix )
  local mor;
  
  if IsVectorSpaceMorphism( matrix ) then 
   
     mor := matrix;
     
     return QVectorSpaceMorphism( QVectorSpace( Source( mor ) ), mor!.UnderlyingMatrix, QVectorSpace( Range( mor ) ) );
 
  fi;
  
  if not IsHomalgMatrix( matrix ) then 
  
     mor := HomalgMatrix( matrix, Q );
     
  else 
  
     mor := matrix;
     
  fi;
  
  
  return QVectorSpaceMorphism( QVectorSpace( NrRows( mor ) ), mor, QVectorSpace( NrColumns( mor ) ) );
  
end );

#################################
##
## View
##
#################################

InstallMethod( ViewObj,
               [ IsHomalgRationalVectorSpaceRep ],

  function( obj )

    Print( "<A rational vector space of dimension ", 
    String( Dimension( obj ) )," as an object in ",vecspaces, ">" );

end );

InstallMethod( ViewObj,
               [ IsHomalgRationalVectorSpaceMorphismRep ],

  function( obj )

    Print( "<A rational vector space homomorphism in the category ", vecspaces, ">" );
  
end );

##################################
##
##  Display
##
##################################

InstallMethod( Display,
               [ IsHomalgRationalVectorSpaceRep ],

  function( obj )

    Print( "Q^(1 X ", String( Dimension( obj ) ),") as an object in ",vecspaces );

end );

InstallMethod( Display,
               [ IsHomalgRationalVectorSpaceMorphismRep ],

  function( mor )

    
    Print( "A rational vector space homomorphism ",
    "Q^(1 X ", String( Dimension( Source( mor ) ) ), ") --> ",
    "Q^(1 X ", String( Dimension( Range( mor ) ) ),
    
    ") with matrix: \n" );
  
    Display( mor!.morphism );

end );

########################################
##
## Adding additive methods
##
########################################

##
identity_morphism := function( obj )

    return QVectorSpaceMorphism( obj, HomalgIdentityMatrix( Dimension( obj ), Q ), obj );
    
end;

AddIdentityMorphism( vecspaces, identity_morphism );

##
pre_compose := function( mor_left, mor_right )
    local composition;

    composition := mor_left!.morphism * mor_right!.morphism;

    return QVectorSpaceMorphism( Source( mor_left ), composition, Range( mor_right ) );

end;

AddPreCompose( vecspaces, pre_compose );

##
is_equal_for_objects := function( vecspace_1, vecspace_2 )
    
    return Dimension( vecspace_1 ) = Dimension( vecspace_2 );
    
end;

AddIsEqualForObjects( vecspaces, is_equal_for_objects );

##
is_equal_for_morphisms := function( a, b )
  
    return a!.morphism = b!.morphism;
  
end;

AddIsEqualForMorphisms( vecspaces, is_equal_for_morphisms );

is_zero_for_obj := function( obj )

return Dimension( obj )=0;
end;

AddIsZeroForObjects( vecspaces, is_zero_for_obj );


is_zero_for_mors := function( mor )

return IsZero( EntriesOfHomalgMatrixAsListList( mor!.morphism ) );

end;

AddIsZeroForMorphisms( vecspaces, is_zero_for_mors );

zero_morphism := function( obj1, obj2 )
                 local O;
                 O := HomalgZeroMatrix( Dimension( obj1 ), Dimension( obj2 ), Q );
                 return QVectorSpaceMorphism( O );
                 end;

AddZeroMorphism( vecspaces, zero_morphism );

kernel_embedding := function( mor )
                    return QVectorSpaceMorphism( KernelEmbedding( AsMorphismInMatrixCategory( mor ) ) );
end;

AddKernelEmbedding( vecspaces, kernel_embedding );


cokernel_projection := function( mor )
                    return QVectorSpaceMorphism( CokernelProjection( AsMorphismInMatrixCategory( mor ) ) );
end;

AddCokernelProjection( vecspaces, cokernel_projection );


ker_lift := function( f, tau )

return QVectorSpaceMorphism( KernelLift( AsMorphismInMatrixCategory( f ), AsMorphismInMatrixCategory( tau )  ) );
end;

AddKernelLift( vecspaces, ker_lift );



coker_colift := function( f, tau )
return QVectorSpaceMorphism( CokernelColift( AsMorphismInMatrixCategory( f ), AsMorphismInMatrixCategory( tau )  ) );
end;

AddCokernelColift( vecspaces, coker_colift );

is_isomorphism := function( f )

return IsIsomorphism( AsMorphismInMatrixCategory( f ) );
end;

AddIsIsomorphism( vecspaces, is_isomorphism );

is_monomorphism := function( f )

return IsMonomorphism( AsMorphismInMatrixCategory( f ) );
end;

AddIsMonomorphism( vecspaces, is_monomorphism );

is_epimorphism := function( f )

return IsEpimorphism( AsMorphismInMatrixCategory( f ) );
end;

AddIsEpimorphism( vecspaces, is_epimorphism );

additive_inverse_for_morphisms := 

function( mor )
local matrix;

matrix := EntriesOfHomalgMatrixAsListList( mor!.morphism );

matrix := -1*matrix;

return QVectorSpaceMorphism( Source( mor ) , matrix,  Range( mor )  );

end;

AddAdditiveInverseForMorphisms( vecspaces, additive_inverse_for_morphisms );


#################################
##
## Adding Frobenius methods
##
#################################


fr3 := function( conf1, conf2 )
       local alpha, beta;
       
       beta := PreCompose( conf1!.morphism2, conf2!.morphism2 );
       
       alpha := KernelEmbedding( beta );
       
       return CreateConflation( alpha, beta );
       
end;

AddFR3( vecspaces, fr3 );

fr4 := function( conf1, conf2 )
       local alpha, beta;
       
        alpha := PreCompose( conf1!.morphism1, conf2!.morphism1 );
       
        beta := CokernelProjection( alpha );
       
        return CreateConflation( alpha, beta );
       
end;

AddFR4( vecspaces, fr4 );

fr5 := function( conf, mor )
       local f,g, gamma, beta;
       
       f:= conf!.morphism2;
       g:= mor;
       
       f := AsMorphismInMatrixCategory( f );
       g := AsMorphismInMatrixCategory( g );
       
       
       gamma := ProjectionInFactorOfFiberProduct( [ f, g ], 1 );

       # It can be proved theoriticaly that beta is epi, hence deflation.
       beta  := ProjectionInFactorOfFiberProduct( [ f, g ], 2 );

       gamma := QVectorSpaceMorphism( gamma );
       
       beta  := QVectorSpaceMorphism( beta  );
       
       return [ CreateConflation( KernelEmbedding( beta ), beta ), gamma ];
       
end;


AddFR5( vecspaces, fr5 );


universal_morphism_into_Fiber_product_by_FR5 := 
        
        function( D, tau )
        local D1, tau1, universal_morphism;
        
        D1 := [ AsMorphismInMatrixCategory( D[ 1 ]!.morphism2 ), AsMorphismInMatrixCategory( D[ 2 ] ) ];
        
        tau1 := [ AsMorphismInMatrixCategory( tau[ 1 ] ), AsMorphismInMatrixCategory( tau[ 2 ] ) ];
        
        
        universal_morphism := UniversalMorphismIntoFiberProduct( D1, tau1 );
        
        return QVectorSpaceMorphism( universal_morphism );
        
end;

AddUniversalMorphismIntoFiberProductByFR5( vecspaces, universal_morphism_into_Fiber_product_by_FR5 );


fr6 := function( conf, mor )
       local f,g, gamma, beta;
       
       f:= conf!.morphism1;
       g:= mor;
       
       f := AsMorphismInMatrixCategory( f );
       g := AsMorphismInMatrixCategory( g );
       
       
       gamma := InjectionOfCofactorOfPushout( [ f, g ], 1 );

       beta  := InjectionOfCofactorOfPushout( [ f, g ], 2 );

       gamma := QVectorSpaceMorphism( gamma );
       
       beta  := QVectorSpaceMorphism( beta  );
       
       return [ CreateConflation( beta, CokernelProjection( beta ) ), gamma ];
       
end;

AddFR6( vecspaces, fr6 );


universal_morphism_from_pushout_by_FR6 := 

        function( D, tau )
        local D1, tau1, universal_morphism;
        
        D1 := [ AsMorphismInMatrixCategory( D[ 1 ]!.morphism1 ), AsMorphismInMatrixCategory( D[ 2 ] ) ];
        
        tau1 := [ AsMorphismInMatrixCategory( tau[ 1 ] ), AsMorphismInMatrixCategory( tau[ 2 ] ) ];
        
        
        universal_morphism := UniversalMorphismFromPushout( D1, tau1 );
        
        return QVectorSpaceMorphism( universal_morphism );
        
end;


AddUniversalMorphismFromPushoutByFR6( vecspaces, universal_morphism_from_pushout_by_FR6 );

fit_into_conflation_using_injective_object := function( obj )
      local id;
      
      id:= IdentityMorphism( obj );
      
      return CreateConflation( id, CokernelProjection( id ) );
end;

AddFitIntoConflationUsingInjectiveObject( vecspaces, fit_into_conflation_using_injective_object );

fit_into_conflation_using_projective_object := function( obj )
      local id;
      
      id:= IdentityMorphism( obj );
      
      return CreateConflation( KernelEmbedding( id ), id );
end;

AddFitIntoConflationUsingProjectiveObject( vecspaces, fit_into_conflation_using_projective_object );


injective_colift := function( mor1, mor2 )
                    local A, B, matrix_of_colift;
                    
                    A := mor1!.morphism;
                    B := mor2!.morphism;
                    
                    matrix_of_colift := LeftDivide( A, B );
                    
                    return QVectorSpaceMorphism( matrix_of_colift );
                    
                    end;

AddInjectiveColift( vecspaces, injective_colift );

projective_lift := function( mor1, mor2 )
                    local A, B, matrix_of_lift;
                    
                    A := mor1!.morphism;
                    B := mor2!.morphism;
                    
                    matrix_of_lift := RightDivide( A, B );
                    
                    return QVectorSpaceMorphism( matrix_of_lift );
                    
                    end;

AddProjectiveLift( vecspaces, projective_lift );

#################
##
## Demos
##
#################

# ReadPackage( "FrobeniusCategoriesForCAP", "examples/VectorSpacesFrobeniusCategory.gi" );

### FR5
##                       ?                    ? 
##            ? >------------------> ? ------------>> Q^7
##                                   ¦                 ¦ 
##                                 ? ¦                 ¦ g
##                                   ¦                 ¦
##                                   ꓦ                 ꓦ
##   conf:= Q^4 >-----------------> Q^6 ----------->> Q^2
##                  kernel( f )               f


# f := QVectorSpaceMorphism( [ [  2,  4 ], [  3,  5 ], [  1,  6 ], [  2,  7 ], [  3,  8 ], [  1,  9 ] ] );                           
#! <A rational vector space homomorphism in the category VectorSpaces>
# g := QVectorSpaceMorphism( [ [  22,   4 ], [   3,  52 ], [  13,  62 ], [   2,  73 ], [   3,  84 ], [   1,  91 ], [  10,   0 ] ] ); 
#! <A rational vector space homomorphism in the category VectorSpaces>
# conf := CreateConflation( KernelEmbedding( f ), f ); 
#! <A Conflation in VectorSpaces>
# Display( conf ); 
#! object1 --(morphism1)--> object2 --(morphism2)--> object3
#! 
#! object1 is
#! Q^(1 X 4) as an object in VectorSpaces
#! 
#! morphism1 is
#! A rational vector space homomorphism Q^(1 X 4) --> Q^(1 X 6) with matrix: 
#! [ [  -13/2,      4,      1,      0,      0,      0 ],
#!   [  -11/2,      3,      0,      1,      0,      0 ],
#!   [   -9/2,      2,      0,      0,      1,      0 ],
#!   [    -11,      7,      0,      0,      0,      1 ] ]
#! 
#! 
#! object2 is
#! Q^(1 X 6) as an object in VectorSpaces
#! 
#! morphism2 is
#! A rational vector space homomorphism Q^(1 X 6) --> Q^(1 X 2) with matrix: 
#! [ [  2,  4 ],
#!   [  3,  5 ],
#!   [  1,  6 ],
#!   [  2,  7 ],
#!   [  3,  8 ],
#!   [  1,  9 ] ]
#! 
#! 
#! object3 is
#! Q^(1 X 2) as an object in VectorSpaces
# fr:= FR5( conf, g ); 
#! [ <A Conflation in VectorSpaces>, <A rational vector space homomorphism in the category VectorSpaces> ]
# Display( fr[ 1 ] ); 
#! object1 --(morphism1)--> object2 --(morphism2)--> object3
#! 
#! object1 is
#! Q^(1 X 4) as an object in VectorSpaces
#! 
#! morphism1 is
#! A rational vector space homomorphism Q^(1 X 4) --> Q^(1 X 11) with matrix: 
#! [ [  1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  1,  0,  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  1,  0,  0,  0,  0,  0,  0,  0 ] ]
#! 
#! 
#! object2 is
#! Q^(1 X 11) as an object in VectorSpaces
#! 
#! morphism2 is
#! A rational vector space homomorphism Q^(1 X 11) --> Q^(1 X 7) with matrix: 
#! [ [  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  0 ],
#!   [  1,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  1,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  1,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  1,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  1,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  1,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  1 ] ]
#! 
#! 
#! object3 is
#! Q^(1 X 7) as an object in VectorSpaces
# Display( fr[ 2 ] ); 
#! A rational vector space homomorphism Q^(1 X 11) --> Q^(1 X 6) with matrix: 
#! [ [  -13/2,      4,      1,      0,      0,      0 ],
#!   [  -11/2,      3,      0,      1,      0,      0 ],
#!   [   -9/2,      2,      0,      0,      1,      0 ],
#!   [    -11,      7,      0,      0,      0,      1 ],
#!   [    -49,     40,      0,      0,      0,      0 ],
#!   [  141/2,    -46,      0,      0,      0,      0 ],
#!   [  121/2,    -36,      0,      0,      0,      0 ],
#!   [  209/2,    -69,      0,      0,      0,      0 ],
#!   [  237/2,    -78,      0,      0,      0,      0 ],
#!   [    134,    -89,      0,      0,      0,      0 ],
#!   [    -25,     20,      0,      0,      0,      0 ] ]
# F := FiberProductByFR5( conf, g ); 
#! <A rational vector space of dimension 11 as an object in VectorSpaces>
# P := ProjectionsOfFiberProductByFR5( conf, g ); 
#! [ <A rational vector space homomorphism in the category VectorSpaces>, <A rational vector space homomorphism in the category VectorSpaces> ]
# Display( P[ 1 ] ); 
#! A rational vector space homomorphism Q^(1 X 11) --> Q^(1 X 6) with matrix: 
#! [ [  -13/2,      4,      1,      0,      0,      0 ],
#!   [  -11/2,      3,      0,      1,      0,      0 ],
#!   [   -9/2,      2,      0,      0,      1,      0 ],
#!   [    -11,      7,      0,      0,      0,      1 ],
#!   [    -49,     40,      0,      0,      0,      0 ],
#!   [  141/2,    -46,      0,      0,      0,      0 ],
#!   [  121/2,    -36,      0,      0,      0,      0 ],
#!   [  209/2,    -69,      0,      0,      0,      0 ],
#!   [  237/2,    -78,      0,      0,      0,      0 ],
#!   [    134,    -89,      0,      0,      0,      0 ],
#!   [    -25,     20,      0,      0,      0,      0 ] ]
# Display( P[ 2 ] ); 
#! A rational vector space homomorphism Q^(1 X 11) --> Q^(1 X 7) with matrix: 
#! [ [  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  0 ],
#!   [  1,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  1,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  1,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  1,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  1,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  1,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  1 ] ]
# t1 := QVectorSpaceMorphism( 13*P[ 1 ]!.morphism ); 
#! <A rational vector space homomorphism in the category VectorSpaces>
# t2 := QVectorSpaceMorphism( 13*P[ 2 ]!.morphism ); 
#! <A rational vector space homomorphism in the category VectorSpaces>
# u  := UniversalMorphismIntoFiberProductByFR5( [ conf, g ], [ t1, t2 ] ); 
#! <A rational vector space homomorphism in the category VectorSpaces>
# Display( u ); 
#! A rational vector space homomorphism Q^(1 X 11) --> Q^(1 X 11) with matrix: 
#! [ [  13,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
#!   [   0,  13,   0,   0,   0,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,  13,   0,   0,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   0,  13,   0,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,  13,   0,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   0,  13,   0,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   0,   0,  13,   0,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   0,   0,   0,  13,   0,   0,   0 ],
#!   [   0,   0,   0,   0,   0,   0,   0,   0,  13,   0,   0 ],
#!   [   0,   0,   0,   0,   0,   0,   0,   0,   0,  13,   0 ],
#!   [   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  13 ] ]
# t3 := QVectorSpaceMorphism( 5*P[ 2 ]!.morphism ); 
#! <A rational vector space homomorphism in the category VectorSpaces>
# gap>  UniversalMorphismIntoFiberProductByFR5( [ conf, g ], [ t1, t3 ] ); 
# Error, in function UniversalMorphismIntoFiberProductByFR5
#        of category VectorSpaces:
#        The resulted diagram by the inputs is not commutative
#  called from
# CallFuncList( func, arg ) at /usr/local/lib/gap4r8/local/pkg/homalg_project/ToolsForHomalg/gap/CachingObjects.gi:862 called from
# <function "unknown">( <arguments> )
#  called from read-eval loop at line 40 of *stdin*
# you can 'quit;' to quit to outer loop, or
# you can 'return;' to continue
# brk>


### FR6 
##
##                     f:= [ [ 3 ] ]           [  ]
##                 Q >-----------------> Q ----------->> 0
##                 ¦                     ¦ 
##   g = [ [ 4 ] ] ¦                     ¦ ?
##                 ¦                     ¦
##                 ꓦ                     ꓦ
##                 Q >-----------------> ? ----------->> ?
##                            ?                 ?
# 
# f := QVectorSpaceMorphism( [ [ 3 ] ] );                            
#! <A rational vector space homomorphism in the category VectorSpaces>
# conf := CreateConflation( f, CokernelProjection( f ) ); 
#! <A Conflation in VectorSpaces>
# g := QVectorSpaceMorphism( [ [ 4 ] ] );                
#! <A rational vector space homomorphism in the category VectorSpaces>
# fr := FR6( conf, g ); 
#! [ <A Conflation in VectorSpaces>, <A rational vector space homomorphism in the category VectorSpaces> ]
# Display( fr[ 1 ] ); 
#! object1 --(morphism1)--> object2 --(morphism2)--> object3
#! 
#! object1 is
#! Q^(1 X 1) as an object in VectorSpaces
#! 
#! morphism1 is
#! A rational vector space homomorphism Q^(1 X 1) --> Q^(1 X 1) with matrix: 
#! [ [  1 ] ]
#! 
#! 
#! object2 is
#! Q^(1 X 1) as an object in VectorSpaces
#! 
#! morphism2 is
#! A rational vector space homomorphism Q^(1 X 1) --> Q^(1 X 0) with matrix: 
#! (an empty 1 x 0 matrix)
#! 
#! 
#! object3 is
#! Q^(1 X 0) as an object in VectorSpaces
# Display( fr[ 2 ] ); 
#! A rational vector space homomorphism Q^(1 X 1) --> Q^(1 X 1) with matrix: 
#! [ [  4/3 ] ]
# P:= PushoutByFR6( conf, g ); 
#! <A rational vector space of dimension 1 as an object in VectorSpaces>
# Display( P ); 
#! Q^(1 X 1) as an object in VectorSpaces
# I := InjectionsOfPushoutByFR6( conf, g ); 
#! [ <A rational vector space homomorphism in the category VectorSpaces>, <A rational vector space homomorphism in the category VectorSpaces> ]
# Display( I[ 1 ] ); 
#! A rational vector space homomorphism Q^(1 X 1) --> Q^(1 X 1) with matrix: 
#! [ [  4/3 ] ]
# Display( I[ 2 ] ); 
#! A rational vector space homomorphism Q^(1 X 1) --> Q^(1 X 1) with matrix: 
#! [ [  1 ] ]
# t1 := QVectorSpaceMorphism( [ [ 8 ] ] ); 
#! <A rational vector space homomorphism in the category VectorSpaces>
# t2 := QVectorSpaceMorphism( [ [ 6 ] ] ); 
#! <A rational vector space homomorphism in the category VectorSpaces>
# u:= UniversalMorphismFromPushoutByFR6( [ conf, g ], [ t1, t2 ]  ); 
#! <A rational vector space homomorphism in the category VectorSpaces>
# Display( u ); 
#! A rational vector space homomorphism Q^(1 X 1) --> Q^(1 X 1) with matrix: 
#! [ [  6 ] ]

# gap>  UniversalMorphismFromPushoutByFR6( [ conf, g ], [ t2, t1 ]  ); 
# Error, in function UniversalMorphismFromPushoutByFR6
#        of category VectorSpaces:
#        The resulted diagram by the inputs is not commutative
#  called from
# CallFuncList( func, arg ) at /usr/local/lib/gap4r8/local/pkg/homalg_project/ToolsForHomalg/gap/CachingObjects.gi:862 called from
# <function "unknown">( <arguments> )
#  called from read-eval loop at line 75 of *stdin*
# you can 'quit;' to quit to outer loop, or
# you can 'return;' to continue
# brk>


### FitIntoConflationUsingInjectiveObject & FitIntoConflationUsingProjectiveObject 
#  A:= QVectorSpace( 8 );
#! <A rational vector space of dimension 8 as an object in VectorSpaces>
# FitIntoConflationUsingInjectiveObject( A );
#! <A Conflation in VectorSpaces>
# gap> Display( last );
#! object1 --(morphism1)--> object2 --(morphism2)--> object3
#! 
#! object1 is
#! Q^(1 X 8) as an object in VectorSpaces
#! 
#! morphism1 is
#! A rational vector space homomorphism Q^(1 X 8) --> Q^(1 X 8) with matrix: 
#! [ [  1,  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  1,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  1,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  1,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  1,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  1,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  1,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  0,  1 ] ]
#! 
#! 
#! object2 is
#! Q^(1 X 8) as an object in VectorSpaces
#! 
#! morphism2 is
#! A rational vector space homomorphism Q^(1 X 8) --> Q^(1 X 0) with matrix: 
#! (an empty 8 x 0 matrix)
#! 
#! 
#! object3 is
#! Q^(1 X 0) as an object in VectorSpaces
#  FitIntoConflationUsingProjectiveObject( A );       
#! <A Conflation in VectorSpaces>
#
#! Display( last );
#! object1 --(morphism1)--> object2 --(morphism2)--> object3
#! 
#! object1 is
#! Q^(1 X 0) as an object in VectorSpaces
#! 
#! morphism1 is
#! A rational vector space homomorphism Q^(1 X 0) --> Q^(1 X 8) with matrix: 
#! (an empty 0 x 8 matrix)
#! 
#! 
#! object2 is
#! Q^(1 X 8) as an object in VectorSpaces
#! 
#! morphism2 is
#! A rational vector space homomorphism Q^(1 X 8) --> Q^(1 X 8) with matrix: 
#! [ [  1,  0,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  1,  0,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  1,  0,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  1,  0,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  1,  0,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  1,  0,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  1,  0 ],
#!   [  0,  0,  0,  0,  0,  0,  0,  1 ] ]
#! 
#! 
#! object3 is
#! Q^(1 X 8) as an object in VectorSpaces


# LoadPackage( "ModulePresentationsForCAP" );
# LoadPackage( "IntrinsicCategories" );
# LoadPackage( "HomologicalAlgebraForCAP" );
# LoadPackage( "RingsForHomalg" );

# QQ := HomalgFieldOfRationalsInSingular( );;
# R := QQ * "x,y";
# R_gmod := LeftPresentations( R );
# category := IntrinsicCategory( R_gmod );
# Id_in_R_gmod := IdentityFunctor( R_gmod );
# M_in_R_mod := AsLeftPresentation( HomalgMatrix( [ [ 1, 1 ], [ 1, 2 ] ], R ) );
# ApplyFunctor( Id_in_R_gmod, M_in_R_mod );






