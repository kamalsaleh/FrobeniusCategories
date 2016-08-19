###################################################################################
##                                                                               ##
## Giving rational vector spaces category a structure of a triangulated category ##
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


#################
##
## Demos
##
#################

# ReadPackage( "FrobeniusCategoriesForCAP", "examples/VectorSpacesFrobeniusCategory.gi" );

## FR5
#
# f := QVectorSpaceMorphism( [ [  2,  4 ], [  3,  5 ], [  1,  6 ], [  2,  7 ], [  3,  8 ], [  1,  9 ] ] );
# g := QVectorSpaceMorphism( [ [  22,   4 ], [   3,  52 ], [  13,  62 ], [   2,  73 ], [   3,  84 ], [   1,  91 ], [  10,   0 ] ] );
#
# conf := CreateConflation( KernelEmbedding( f ), f );
# Display( conf );
#
# fr:= FR5( conf, g ); 
# Display( fr[ 1 ] );
# Display( fr[ 2 ] );
#
# F := FiberProductByFR5( conf, g );
# P := ProjectionsOfFiberProductByFR5( conf, g );
# Display( P[ 1 ] );
# Display( P[ 2 ] );
# t1 := QVectorSpaceMorphism( 13*P[ 1 ]!.morphism );
# t2 := QVectorSpaceMorphism( 13*P[ 2 ]!.morphism );
# u  := UniversalMorphismIntoFiberProductByFR5( [ conf, g ], [ t1, t2 ] );
# Display( u );
# t3 := QVectorSpaceMorphism( 5*P[ 2 ]!.morphism );
# UniversalMorphismIntoFiberProductByFR5( [ conf, g ], [ t1, t3 ] );









