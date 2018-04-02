


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

IsInflation := rec( 

installation_name := "IsInflation", 
filter_list := [ "morphism" ],
cache_name := "IsInflation",
return_type := "bool",
post_function := function( morphism, return_value )
                 
                 if return_value = true then 
                 
                    SetFilterObj( morphism, IsCapCategoryInflation );
                    
                 fi;
                 
                 end ),

IsDeflation := rec( 

installation_name := "IsDeflation", 
filter_list := [ "morphism" ],
cache_name := "IsDeflation",
return_type := "bool",
post_function := function( morphism, return_value )
                 
                 if return_value = true then 
                 
                    SetFilterObj( morphism, IsCapCategoryDeflation );
                    
                 fi;
                 
                 end ),
                 
IsConflation := rec( 

installation_name := "IsConflation", 
filter_list := [ IsCapCategoryShortExactSequence ],
cache_name := "IsConflation",
return_type := "bool",
post_function := function( seq, return_value )
                 
                 if return_value = true then 
                 
                    SetFilterObj( seq, IsCapCategoryConflation );
                    
                 fi;
                 
                 end ),

ConflationOfInflation := rec( 

installation_name := "ConflationOfInflation", 
filter_list := [ "morphism" ],
cache_name := "ConflationOfInflation",
return_type := "IsCapCategoryConflation" ),


ConflationOfDeflation := rec( 

installation_name := "ConflationOfDeflation", 
filter_list := [ "morphism" ],
cache_name := "ConflationOfDeflation",
return_type := "IsCapCategoryConflation" ),

ExactFiberProduct:= rec( 

installation_name := "ExactFiberProduct", 
filter_list := [ IsCapCategoryDeflation , "morphism" ],
cache_name := "ExactFiberProduct",
pre_function := function( def, mor )
                local is_equal_for_objects;
                
                is_equal_for_objects := IsEqualForObjects( Range( def ), Range( mor ) );
                
                if is_equal_for_objects = fail then 
                
                    return [ false, "Cannot decide if the ranges of the both morphisms are equal" ];
                 
                elif is_equal_for_objects = false then 
                
                    return  [ false, "The ranges of both morphisms are not equal" ];
                    
                else 
                
                    return [ true ];
                    
                fi;
                
                end,
return_type := "object" ),                 


ProjectionInFactorOfExactFiberProduct := rec( 

installation_name := "ProjectionInFactorOfExactFiberProduct", 
filter_list := [ IsList, IsInt ],
cache_name := "ProjectionInFactorOfExactFiberProduct",
return_type := [ "morphism" ] ),                 

UniversalMorphismIntoExactFiberProduct:= rec( 

installation_name := "UniversalMorphismIntoExactFiberProduct", 
filter_list := [ IsList, IsList ],
cache_name := "UniversalMorphismIntoExactFiberProduct",

 pre_function:= function( D, tau )
                local def,mor, is_equal_for_morphisms;
                
                if not IsCapCategoryDeflation( D[ 1 ] ) then 
                
                   return [ false, "The first entry of the first list should be a deflation" ];
                   
                fi;
                
                if not IsCapCategoryMorphism( D[ 2 ] ) then
                  
                   return [ false, "The second entry of the first list should be a morphism" ];
                   
                fi;
                
                if not IsCapCategoryMorphism( tau[ 1 ] ) or not IsCapCategoryMorphism( tau[ 2 ] ) then
                
                   return [ false, "The second list should be list of two morphisms" ];
                   
                fi;
                
                
                def := D[ 1 ];
                mor := D[ 2 ];
                
                is_equal_for_morphisms := IsCongruentForMorphisms( PreCompose( tau[ 1 ], def ), PreCompose( tau[ 2 ], mor ) );
                
                if is_equal_for_morphisms = fail then 
                
                    return [ false, "Cannot determine if the resulted diagram is commutative" ];
                    
                elif is_equal_for_morphisms = false then 
                
                    return [ false, "The resulted diagram by the inputs is not commutative" ];
                    
                else
                
                    return [ true ];
                    
                fi;
                
                end,
return_type := "morphism" ),                 

ExactPushout:= rec( 

installation_name := "ExactPushout", 
filter_list := [ "morphism", "morphism" ],
cache_name := "ExactPushout",
return_type := "object" ),
            

InjectionOfCofactorOfExactPushout := rec( 

installation_name := "InjectionOfCofactorOfExactPushout", 
filter_list := [ IsList, IsInt ],
cache_name := "InjectionOfCofactorOfExactPushout",
return_type := [ "morphism" ] ),                 

UniversalMorphismFromExactPushout:= rec( 

installation_name := "UniversalMorphismFromExactPushout", 
filter_list := [ IsList, IsList ],
cache_name := "UniversalMorphismFromExactPushout",
return_type := "morphism" ),                 

FitIntoConflationUsingExactInjectiveObject := rec( 

installation_name := "FitIntoConflationUsingExactInjectiveObject", 
filter_list := [ "object" ],
cache_name := "FitIntoConflationUsingExactInjectiveObject",
return_type := [ IsCapCategoryConflation ] ),

FitIntoConflationUsingExactProjectiveObject := rec( 

installation_name := "FitIntoConflationUsingExactProjectiveObject", 
filter_list := [ "object" ],
cache_name := "FitIntoConflationUsingExactProjectiveObject",
return_type := [ IsCapCategoryConflation ] ),

IsExactProjectiveObject := rec( 

installation_name := "IsExactProjectiveObject", 
filter_list := [ "object" ],
cache_name := "IsExactProjectiveObject",
return_type := [ "bool" ] ),

IsExactInjectiveObject := rec( 

installation_name := "IsExactInjectiveObject", 
filter_list := [ "object" ],
cache_name := "IsExactInjectiveObject",
return_type := [ "bool" ] ),

DeflationFromSomeExactProjectiveObject := rec( 

installation_name := "DeflationFromSomeExactProjectiveObject", 
filter_list := [ "object" ],
cache_name := "DeflationFromSomeExactProjectiveObject",
return_type := [ "morphism" ] ),

InflationIntoSomeExactInjectiveObject := rec( 

installation_name := "InflationIntoSomeExactInjectiveObject", 
filter_list := [ "object" ],
cache_name := "InflationIntoSomeExactInjectiveObject",
return_type := [ "morphism" ] ),

ExactProjectiveLift := rec( 

installation_name := "ExactProjectiveLift", 
filter_list := [ "morphism", "morphism" ],
cache_name := "ExactProjectiveLift",
return_type := [ "morphism" ] ),

ExactInjectiveColift := rec( 

installation_name := "ExactInjectiveColift", 
filter_list := [ "morphism", "morphism" ],
cache_name := "ExactInjectiveColift",
return_type := [ "morphism" ] ),

CanBeFactoredThroughExactProjective := rec(

installation_name := "CanBeFactoredThroughExactProjective", 
filter_list := [ "morphism" ],
cache_name := "CanBeFactoredThroughExactProjective",
return_type := [ "bool" ] ),

CanBeFactoredThroughExactInjective := rec(

installation_name := "CanBeFactoredThroughExactInjective", 
filter_list := [ "morphism" ],
cache_name := "CanBeFactoredThroughExactInjective",
return_type := [ "bool" ] ),

##
FactorizationThroughExactInjective := rec(

installation_name := "FactorizationThroughExactInjective", 
filter_list := [ "morphism" ],
cache_name := "FactorizationThroughExactInjective",
pre_function := function( mor )
                if not CanBeFactoredThroughExactInjective( mor ) then
                    return [ fail ];
                fi;
                    return [ true ];
                end,
return_type := [ "morphism", "morphism" ],
post_function :=    function( mor, return_value )
                    if not IsExactInjectiveObject( Range( return_value[ 1 ] ) ) then
                        return [ false, "The output of your method is not compatible" ];
                    fi;
                    
                    if not IsCongruentForMorphisms( PreCompose( return_value[ 1 ], return_value[ 2 ] ), mor ) then
                        return [ false, "The composition does not equal the input morphism" ];
                    fi;
                    return [ true ];
                    end ),

##
FactorizationThroughExactProjective := rec(

installation_name := "FactorizationThroughExactProjective", 
filter_list := [ "morphism" ],
cache_name := "FactorizationThroughExactProjective",
pre_function := function( mor )
                if not CanBeFactoredThroughExactProjective( mor ) then
                    return [ false, "The given morphism can be factored through an exact projective object" ];
                fi;
                return [ true ];
                end,
return_type := [ "morphism", "morphism" ],

post_function :=    function( mor, return_value )
                    if not IsExactProjectiveObject( Range( return_value[ 1 ] ) ) then
                        return [ false, "The output of your method is not compatible" ];
                    fi;
                    
                    if not IsCongruentForMorphisms( PreCompose( return_value[ 1 ], return_value[ 2 ] ), mor ) then
                        return [ false, "The composition does not equal the input morphism" ];
                    fi;
                    return [ true ];
                    end ),

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
InstallMethod( IsShortExactSequence_, 
            [ IsCapCategoryShortSequence ], 
                
  function( seq )
  local alpha, beta, ker_beta, ker_lift, coker_alpha, coker_colift;
  
    alpha := seq^0;
  
    beta := seq^1;
  
    if not IsWellDefinedForObjects( seq ) then 
  
      return false;
     
    fi;
      
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
            [ IsCapCategoryConflation, IsCapCategoryConflation ], 
    
    function( conf1, conf2 )
    local f1, I1, g1, B1, f2, I2, g2, B2, phi1, phi2, h1, h2, inverse_phi_1, inverse_phi_2, i_I1, i_I2, i_B1, i_B2, alpha, beta;
    
    if not IsEqualForObjects( conf1[ 0 ], conf2[ 0 ] ) then 
    
       Error( "Both conflations should begin by the same object" );
       
    fi;
    
    f1 := conf1^0;
    
    I1 := Range( f1 );
    
    g1 := conf1^1;
    
    B1 := Range( g1 );
    
    f2 := conf2^0;
    
    I2 := Range( f2 );
    
    g2 := conf2^1;
    
    B2 := Range( g2 );

    phi1 := InjectionOfCofactorOfExactPushout( [ f1, f2 ], 1 );
    
    phi2 := InjectionOfCofactorOfExactPushout( [ f1, f2 ], 2 );

    h1 := UniversalMorphismFromExactPushout( [ f1, f2 ], [ g1, ZeroMorphism( I2, Range( g1 )  ) ] );
    
    h2 := UniversalMorphismFromExactPushout( [ f1, f2 ], [ ZeroMorphism( I1, Range( g2 )  ), g2 ] );
    
    inverse_phi_1 := ExactInjectiveColift( phi1, IdentityMorphism( I1 ) );
    
    inverse_phi_2 := ExactInjectiveColift( phi2, IdentityMorphism( I2 ) );
    
    # Let P denotes the exact pushout object
    #
    # from P to I2 𐌈 B1
    alpha := MorphismBetweenDirectSums( 
      [ # from P to I2 , from P to B1
        [ inverse_phi_2, h1  ]  
      ] );

    # from P to I1 𐌈 B2
    beta := MorphismBetweenDirectSums( 
      [ # from P to I1 , from P to B2
        [ inverse_phi_1, h2  ]  
      ] );

    return PreCompose( Inverse( alpha ), beta );
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
        DirectoriesPackageLibrary( "FrobeniusCategoriesForCAP", "LogicForExactAndFrobeniusCategories" ),
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
        DirectoriesPackageLibrary( "FrobeniusCategoriesForCAP", "LogicForExactAndFrobeniusCategories" ),
        "PredicateImplicationsForFrobeniusCategories.tex" ) );
        
   TryNextMethod( );
     
end );

InstallImmediateMethod( SetFilterOnInflations,
               IsCapCategoryMorphism and IsInflation, 
               0,
   function( mor )
   SetFilterObj( mor, IsCapCategoryInflation );     
   TryNextMethod( );
end );


InstallImmediateMethod( SetFilterOnDeflations,
               IsCapCategoryMorphism and IsDeflation, 
               0,
   function( mor )
   SetFilterObj( mor, IsCapCategoryDeflation );     
   TryNextMethod( );
end );

InstallImmediateMethod( SetFilterOnConflations,
               IsCapCategoryShortSequence and IsConflation, 
               0,
   function( mor )
   SetFilterObj( mor, IsCapCategoryConflation );     
   TryNextMethod( );
end );