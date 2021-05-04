


#######################################
##
## Representations
##
#######################################


DeclareRepresentation( "IsCapCategoryShortSequenceRep",
                        IsCapCategoryShortSequence and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryShortExactSequenceRep",

                        IsCapCategoryShortExactSequence and IsAttributeStoringRep,
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

BindGlobal( "CapCategoryShortExactSequencesFamily",
  NewFamily( "CapCategoryShortExactSequencesFamily", IsCapCategoryShortSequence ) );

BindGlobal( "CapCategoryConflationsFamily",
  NewFamily( "CapCategoryConflationsFamily", IsCapCategoryConflation ) );

BindGlobal( "CapCategoryMorphismsOfShortSequencesFamily",
  NewFamily( "CapCategoryMorphismsOfShortSequencesFamily", IsObject ) );

BindGlobal( "TheTypeCapCategoryShortSequence",
  NewType( CapCategoryShortSequencesFamily,
                      IsCapCategoryShortSequenceRep ) );

BindGlobal( "TheTypeCapCategoryShortExactSequence",
  NewType( CapCategoryShortExactSequencesFamily,
                      IsCapCategoryShortExactSequenceRep ) );

BindGlobal( "TheTypeCapCategoryConflation",
  NewType( CapCategoryConflationsFamily,
                      IsCapCategoryConflationRep ) );

BindGlobal( "TheTypeCapCategoryMorphismOfShortSequences",
  NewType( CapCategoryMorphismsOfShortSequencesFamily,
                      IsCapCategoryMorphismOfShortSequencesRep ) );

###############################
##
##  Records and methods
##
###############################

InstallValue( CAP_INTERNAL_FROBENIUS_CATEGORIES_BASIC_OPERATIONS, rec( ) );

InstallValue( FROBENIUS_CATEGORIES_METHOD_NAME_RECORD, rec(

IsConflationPair := rec(
installation_name := "IsConflationPair",
filter_list := [ "category", "morphism", "morphism" ],
cache_name := "IsConflationPair",
return_type := "bool" ),

CompleteInflationToConflation := rec(
installation_name := "CompleteInflationToConflation",
filter_list := [ "category", "morphism" ],
cache_name := "CompleteInflationToConflation",
return_type := "morphism" ),

CompleteDeflationToConflation := rec(
installation_name := "CompleteDeflationToConflation",
filter_list := [ "category", "morphism" ],
cache_name := "CompleteDeflationToConflation",
return_type := "morphism" ),

LiftAlongInflation := rec(
installation_name := "LiftAlongInflation",
filter_list := [ "category", "morphism", "morphism" ],
cache_name := "LiftAlongInflation",
return_type := "morphism" ),

ColiftAlongDeflation := rec(
installation_name := "ColiftAlongDeflation",
filter_list := [ "category", "morphism", "morphism" ],
cache_name := "ColiftAlongDeflation",
return_type := "morphism" ),

ExactFiberProduct:= rec(
installation_name := "ExactFiberProduct",
filter_list := [ "category", "morphism" , "morphism" ],
cache_name := "ExactFiberProduct",
return_type := "object" ),

ProjectionInFactorOfExactFiberProduct := rec(

installation_name := "ProjectionInFactorOfExactFiberProduct",
filter_list := [ "category", "morphism", "morphism", IsInt ],
cache_name := "ProjectionInFactorOfExactFiberProduct",
return_type := "morphism" ),

UniversalMorphismIntoExactFiberProduct:= rec(

installation_name := "UniversalMorphismIntoExactFiberProduct",
filter_list := [ "category", "morphism", "morphism", "morphism", "morphism" ],
cache_name := "UniversalMorphismIntoExactFiberProduct",
return_type := "morphism" ),

ExactPushout:= rec(

installation_name := "ExactPushout",
filter_list := [ "category", "morphism", "morphism" ],
cache_name := "ExactPushout",
return_type := "object" ),


InjectionOfCofactorOfExactPushout := rec(

installation_name := "InjectionOfCofactorOfExactPushout",
filter_list := [ "category", "morphism", "morphism", IsInt ],
cache_name := "InjectionOfCofactorOfExactPushout",
return_type := "morphism" ),

UniversalMorphismFromExactPushout:= rec(

installation_name := "UniversalMorphismFromExactPushout",
filter_list := [ "category", "morphism", "morphism", "morphism", "morphism" ],
cache_name := "UniversalMorphismFromExactPushout",
return_type := "morphism" ),

IsExactProjectiveObject := rec(

installation_name := "IsExactProjectiveObject",
filter_list := [ "category", "object" ],
cache_name := "IsExactProjectiveObject",
return_type := "bool" ),

IsExactInjectiveObject := rec(

installation_name := "IsExactInjectiveObject",
filter_list := [ "category", "object" ],
cache_name := "IsExactInjectiveObject",
return_type := "bool" ),

DeflationFromSomeExactProjectiveObject := rec(

installation_name := "DeflationFromSomeExactProjectiveObject",
filter_list := [ "category", "object" ],
cache_name := "DeflationFromSomeExactProjectiveObject",
return_type := "morphism" ),

InflationIntoSomeExactInjectiveObject := rec(

installation_name := "InflationIntoSomeExactInjectiveObject",
filter_list := [ "category", "object" ],
cache_name := "InflationIntoSomeExactInjectiveObject",
return_type := "morphism" ),

ExactProjectiveLift := rec(

installation_name := "ExactProjectiveLift",
filter_list := [ "category", "morphism", "morphism" ],
cache_name := "ExactProjectiveLift",
return_type := "morphism" ),

ExactInjectiveColift := rec(

installation_name := "ExactInjectiveColift",
filter_list := [ "category", "morphism", "morphism" ],
cache_name := "ExactInjectiveColift",
return_type := "morphism" ),

IsColiftableAlongInflationIntoSomeExactInjectiveObject := rec(

installation_name := "IsColiftableAlongInflationIntoSomeExactInjectiveObject",
filter_list := [ "category", "morphism" ],
cache_name := "IsColiftableAlongInflationIntoSomeExactInjectiveObject",
return_type := "bool" ),

IsLiftableAlongDeflationFromSomeExactProjectiveObject := rec(

installation_name := "IsLiftableAlongDeflationFromSomeExactProjectiveObject",
filter_list := [ "category", "morphism" ],
cache_name := "IsLiftableAlongDeflationFromSomeExactProjectiveObject",
return_type := "bool" ),

##
ColiftAlongInflationIntoSomeExactInjectiveObject := rec(

installation_name := "ColiftAlongInflationIntoSomeExactInjectiveObject",
filter_list := [ "category", "morphism" ],
cache_name := "ColiftAlongInflationIntoSomeExactInjectiveObject",
return_type := "morphism" ),

##
LiftAlongDeflationFromSomeExactProjectiveObject := rec(

installation_name := "LiftAlongDeflationFromSomeExactProjectiveObject",
filter_list := [ "category", "morphism" ],
cache_name := "LiftAlongDeflationFromSomeExactProjectiveObject",
return_type := "morphism" )

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( FROBENIUS_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( FROBENIUS_CATEGORIES_METHOD_NAME_RECORD );

########################################
##
## Properties logic
##
########################################

InstallTrueMethod( IsExactCategory, IsFrobeniusCategory );

InstallTrueMethod( IsAdditiveCategory, IsExactCategory );

########################################
##
##  Constructors
##
########################################

InstallMethod( CategoryOfShortSequences,
                [ IsCapCategory ],
  function( category )
  local name, cat;

  name := Concatenation( "Category of short sequences of the ", Name( category ) );

  cat := CreateCapCategory( name );

  AddIsWellDefinedForObjects( cat,

  function( S )
  local alpha, beta;

  alpha := S^0;

  beta := S^1;

    if not IsZeroForMorphisms( PreCompose( alpha, beta ) ) then

      return false;

    fi;

  return true;

  end );

  AddIsEqualForObjects( cat,
      function( S1, S2 )
      return IsEqualForObjects( ObjectAt( S1, 0 ), ObjectAt( S2, 0 ) ) and
              IsEqualForObjects( ObjectAt( S1, 1 ), ObjectAt( S2, 1 ) ) and
               IsEqualForObjects( ObjectAt( S1, 2 ), ObjectAt( S2, 2 ) ) and
                IsEqualForMorphisms( MorphismAt( S1, 0 ), MorphismAt( S2, 0 ) ) and
                 IsEqualForMorphisms( MorphismAt( S1, 1 ), MorphismAt( S2, 1 ) );
      end );

  Finalize( cat );

  return cat;

end );

InstallMethod( CreateShortSequence,

               [ IsCapCategoryMorphism, IsCapCategoryMorphism ],

   function( alpha, beta )
   local s;

   if not IsEqualForObjects( Range( alpha ), Source( beta ) ) then

     Error( "Range of the first morphism should equal the Source of the second morphism" );

   fi;

   s := rec( o0:= Source( alpha ),

             m0:= alpha,

             o1 := Range( alpha ),

             m1 := beta,

             o2 := Range( beta ) );

    ObjectifyWithAttributes( s, TheTypeCapCategoryShortSequence );

    AddObject( CategoryOfShortSequences( CapCategory( alpha ) ), s );
    return s;

end );



InstallMethodWithCache( CreateShortExactSequence,

              [ IsCapCategoryMorphism, IsCapCategoryMorphism ],

  function( alpha, beta )
  local s;

  s := CreateShortSequence( alpha, beta );

  SetFilterObj( s, IsCapCategoryShortExactSequence );

  return s;

end );

##
InstallMethodWithCache( CreateConflation,
                       [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
    function( alpha, beta )
    local s;

    s := CreateShortExactSequence( alpha, beta );

    SetFilterObj( s, IsCapCategoryConflation );

    return s;

end );

##
InstallMethod( ObjectAtOp, [ IsCapCategoryShortSequence, IsInt ],
  function( seq, i )
  if i = 0 then
    return seq!.o0;
  elif i = 1 then
    return seq!.o1;
  elif i = 2 then
    return seq!.o2;
  else
    Error( "The integer must be 0, 1 or 2" );
  fi;
end );

##
InstallMethod( \[\], [ IsCapCategoryShortSequence, IsInt ],
  function( seq, i )
  return ObjectAt( seq, i );
end );

##
InstallMethod( MorphismAtOp, [ IsCapCategoryShortSequence, IsInt ],
  function( seq, i )
  if i = 0 then
    return seq!.m0;
  elif i = 1 then
    return seq!.m1;
  else
    Error( "The integer must be 0 or 1" );
  fi;
end );

##
InstallMethod( \^, [ IsCapCategoryShortSequence, IsInt ],
  function( seq, i )
  return MorphismAt( seq, i );
end );

##############################
##
## View
##
##############################

InstallMethod( ViewObj,

               [ IsCapCategoryShortSequence ],

  function( seq )

    if IsCapCategoryConflation( seq ) then

       Print( "<A Conflation in ", CapCategory( seq ), ">" );

    elif IsCapCategoryShortExactSequence( seq ) then

       Print( "<A short exact sequence in ", CapCategory( seq ), ">" );

    else

       Print( "<A short sequence in ", CapCategory( seq ), ">" );

    fi;

end );

#################################
##
## Display
##
#################################

InstallMethod( Display,

              [ IsCapCategoryShortSequence ],

    function( seq )

    if IsCapCategoryConflation( seq ) then

       Print( "A Conflation in ", CapCategory( seq ), " given by:\n" );

    elif IsCapCategoryShortExactSequence( seq ) then

       Print( "A short exact sequence in ", CapCategory( seq ), " given by:\n" );

    else

       Print( "A short sequence in ", CapCategory( seq ), " given by :\n" );

    fi;

    Print( "\n     m0          m1     " );
    Print( "\no0 ------> o1 ------> o2\n\n" );

    Print( "\no0 is\n\n" ); Display( seq[ 0 ] );
    Print( "\n------------------------------------\n" );
    Print( "\nm0 is\n\n" ); Display( seq^0 );
    Print( "\n------------------------------------\n" );
    Print( "\no1 is\n\n" ); Display( seq[ 1 ] );
    Print( "\n------------------------------------\n" );
    Print( "\nm1 is\n\n" ); Display( seq^1 );
    Print( "\n------------------------------------\n" );
    Print( "\no2 is\n\n" ); Display( seq[ 2 ] );

end );

#####################################
##
## Operations
##
#####################################

#           f1        g1
#        A ----> I1 -----> B1
#
#
#        A ----> I2 -----> B2
#           f2        g2
#
#        SchanuelsIsomorphism : I2 𐌈 B1 ----> I1 𐌈 B2
# In the stable category,  B1 ------> I2 𐌈 B1 -------> I1 𐌈 B2 -------> B2 is also supposed to be isomorphism.

##
InstallMethodWithCache( SchanuelsIsomorphism,
            [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsString ],

    function( inf_1, def_1, inf_2, def_2, string )
      local I1, B1, I2, B2, phi_1, phi_2, h1, h2, i_phi_1, i_phi_2, alpha, beta;

      if not string = "left" then
        TryNextMethod();
      fi;
      
      I1 := Source( def_1 );

      B1 := Range( def_1 );

      I2 := Source( def_2 );

      B2 := Range( def_2 );

      phi_1 := InjectionOfCofactorOfExactPushout( inf_1, inf_2, 1 );

      phi_2 := InjectionOfCofactorOfExactPushout( inf_1, inf_2, 2 );

      h1 := UniversalMorphismFromExactPushout( inf_1, inf_2, def_1, ZeroMorphism( I2, B1  ) );

      h2 := UniversalMorphismFromExactPushout( inf_1, inf_2, ZeroMorphism( I1, B2  ), def_2 );

      i_phi_1 := ExactInjectiveColift( phi_1, IdentityMorphism( I1 ) );

      i_phi_2 := ExactInjectiveColift( phi_2, IdentityMorphism( I2 ) );

      alpha := MorphismBetweenDirectSums(
        [
          [ i_phi_2, h1  ]
        ] );

      beta := MorphismBetweenDirectSums(
        [
          [ i_phi_1, h2  ]
        ] );

      return PreCompose( InverseForMorphisms( alpha ), beta );

end );


#           inf_1        def_1
#        A1 ------> P1 ------------> B
#
#
#        A2 ------> P2 ------------> B
#           inf_2        def_2
#
#        SchanuelsIsomorphism : A1 𐌈 P2 ----> A2 𐌈 P1
# In the stable category,  A1 ------> A1 𐌈 P2 ----> A2 𐌈 P1 -------> A2 is also supposed to be isomorphism.

InstallMethod( SchanuelsIsomorphism,
          [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsString ],

    function( inf_1, def_1, inf_2, def_2, string )
      local A1, P1, A2, P2, phi_1, phi_2, h1, h2, i_phi_1, i_phi_2, alpha, beta;

      if not string = "right" then
        TryNextMethod();
      fi;
      
      A1 := Source( inf_1 );

      P1 := Range( inf_1 );

      A2 := Source( inf_2 );

      P2 := Range( inf_2 );

      phi_1 := ProjectionInFactorOfExactFiberProduct( def_1, def_2, 1 );

      phi_2 := ProjectionInFactorOfExactFiberProduct( def_1, def_2, 2 );

      h1 := UniversalMorphismIntoExactFiberProduct( def_1, def_2, inf_1, ZeroMorphism( A1, P2  ) );

      h2 := UniversalMorphismIntoExactFiberProduct( def_1, def_2, ZeroMorphism( A2, P1 ), inf_2 );

      i_phi_1 := ExactProjectiveLift( IdentityMorphism( P1 ), phi_1 );

      i_phi_2 := ExactProjectiveLift( IdentityMorphism( P2 ), phi_2 );

      alpha := MorphismBetweenDirectSums(
        [
          [ h1 ],
          [ i_phi_2 ]
        ] );

      beta := MorphismBetweenDirectSums(
        [
          [ h2 ],
          [ i_phi_1 ]
        ] );

      return PreCompose( alpha, InverseForMorphisms( beta ) );
end );



#####################################
##
## Immediate Methods and Attributes
##
#####################################

InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS_FOR_EXACT_CATEGORY,
               IsCapCategory and IsExactCategory,
               0,

   function( category )

   AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "FrobeniusCategories", "LogicForExactAndFrobeniusCategories" ),
        "PredicateImplicationsForExactCategories.tex" ) );

   TryNextMethod( );

end );

InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS_FOR_FROBENIUS_CATEGORY,
               IsCapCategory and IsFrobeniusCategory,
               0,

   function( category )

   SetIsExactCategory( category, true );
   SetIsExactCategoryWithEnoughExactProjectives( category, true );
   SetIsExactCategoryWithEnoughExactInjectives( category, true );

   AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "FrobeniusCategories", "LogicForExactAndFrobeniusCategories" ),
        "PredicateImplicationsForFrobeniusCategories.tex" ) );

   TryNextMethod( );

end );
