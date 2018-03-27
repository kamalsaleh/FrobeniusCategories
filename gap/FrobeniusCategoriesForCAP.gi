


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
return_type := [ "morphism" ] )

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

InstallMethodWithCache( CreateShortSequence, 
               
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ], 
               
   function( alpha, beta )
   local s;
   
   if not IsEqualForObjects( Range( alpha ), Source( beta ) ) then 
   
     Error( "Range of the first morphism should equal the Source of the second morphism" );
     
   fi;
   
   s := rec( object1:= Source( alpha ), 
             
             morphism1:= alpha,
             
             object2 := Range( alpha ),
             
             morphism2 := beta,
             
             object3 := Range( beta ) );
             
    ObjectifyWithAttributes( s, TheTypeCapCategoryShortSequence,
    
                             CapCategory, CapCategory( alpha ) );
                             
    return s;
    
end );

##
InstallMethod( IsWellDefinedForShortSequences, 
                [ IsCapCategoryShortSequence ], 
                
  function( seq )
  local alpha, beta;
  
  alpha := seq!.morphism1;
  
  beta := seq!.morphism2;
  
    if not IsZeroForMorphisms( PreCompose( alpha, beta ) ) then 
    
      return false;
      
    fi;
    
  return true;
  
end );


InstallMethodWithCache( CreateShortExactSequence, 
              
              [ IsCapCategoryMorphism, IsCapCategoryMorphism ], 
               
   function( alpha, beta )
   local s, coker_alpha, coker_colift, ker_beta, ker_lift;
   
   
   # the two morphisms should be composable
   
   if not IsEqualForObjects( Range( alpha ), Source( beta ) ) then 
   
       Error( "Range of the first morphism should equal the Source of the second morphism" );
     
   fi;
      
   s := rec( object1:= Source( alpha ), 
             
             morphism1:= alpha,
             
             object2 := Range( alpha ),
             
             morphism2 := beta,
             
             object3 := Range( beta ) );
             
    ObjectifyWithAttributes( s, TheTypeCapCategoryShortExactSequence,
    
                             CapCategory, CapCategory( alpha ) );
                             
    return s;
    
end );


##
InstallMethod( IsWellDefinedForShortExactSequences, 
                [ IsCapCategoryShortExactSequence ], 
                
  function( seq )
  local alpha, beta, ker_beta, ker_lift, coker_alpha, coker_colift;
  
    alpha := seq!.morphism1;
  
    beta := seq!.morphism2;
  
    if not IsWellDefinedForShortSequences( seq ) then 
  
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
    local s, coker_alpha, coker_colift, ker_beta, ker_lift;
   
   
   # the two morphisms should be composable
   
   if not IsEqualForObjects( Range( alpha ), Source( beta ) ) then 
   
       Error( "Range of the first morphism should equal the Source of the second morphism" );
     
   fi;

   s := rec( object1:= Source( alpha ), 
             
             morphism1:= alpha,
             
             object2 := Range( alpha ),
             
             morphism2 := beta,
             
             object3 := Range( beta ) );
             
    ObjectifyWithAttributes( s, TheTypeCapCategoryConflation,
    
                             CapCategory, CapCategory( alpha ) );
                             
    return s;
    
end );
    
##
InstallMethod( IsWellDefinedForConflations, 
                [ IsCapCategoryConflation ], 
                
  function( conf )
  
  return IsConflation( conf );
  
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
    
       Print( "A Conflation in ", CapCategory( seq ), " given by the sequence:\n" );
    
    elif IsCapCategoryShortExactSequence( seq ) then 
    
       Print( "A short exact sequence in ", CapCategory( seq ), " given by:\n" );
   
    else 
   
       Print( "A short sequence in ", CapCategory( seq ), " given by :\n" );
   
    fi;
    
   
   Print( "\n          mor_1                  mor_2\n" );
   Print( "obj_1 ----------------> obj_2 -----------------> obj_3\n" );
   
   Print( "\nobj_1 is\n" ); Display( seq!.object1 );
   
   Print( "\n\nmor_1 is\n" ); Display( seq!.morphism1 );
   
   Print( "\n\nobj_2 is\n" ); Display( seq!.object2 );
  
   Print( "\n\nmor_2 is\n" ); Display( seq!.morphism2 );
   
   Print( "\n\nobj_3 is\n" ); Display( seq!.object3 );
   
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
    local f1, I1, g1, B1, f2, I2, g2, B2, phi, phi1, phi2, h1, h2, inverse_phi_1, inverse_phi_2, i_I1, i_I2, i_B1, i_B2, alpha, beta;
    
    if not IsExactCategory( CapCategory( conf1 ) ) then 
      
       Error( "The category should be exact" );
       
    fi;
    
    if not IsEqualForObjects( conf1!.object1, conf2!.object1 ) then 
    
       Error( "Both conflations should begin by the same object" );
       
    fi;
    
    f1 := conf1!.morphism1;
    
    I1 := Range( f1 );
    
    g1 := conf1!.morphism2;
    
    B1 := Range( g1 );
    
    f2 := conf2!.morphism1;
    
    I2 := Range( f2 );
    
    g2 := conf2!.morphism2;
    
    B2 := Range( g2 );
    
    phi := InjectionsOfPushoutInducedByStructureOfExactCategory( f1, f2 );
    
    phi1 := phi[ 1 ];
    
    phi2 := phi[ 2 ];
    
    h1 := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ f1, f2 ], [ g1, ZeroMorphism( I2, Range( g1 )  ) ] );
    
    h2 := UniversalMorphismFromPushoutInducedByStructureOfExactCategory( [ f1, f2 ], [ ZeroMorphism( I1, Range( g2 )  ), g2 ] );
    
    inverse_phi_1 := InjectiveColift( phi1, IdentityMorphism( I1 ) );
    
    inverse_phi_2 := InjectiveColift( phi2, IdentityMorphism( I2 ) );
    
    i_I2 := InjectionOfCofactorOfDirectSum( [ I2, B1 ], 1 );
    
    i_B1 := InjectionOfCofactorOfDirectSum( [ I2, B1 ], 2 );
    
    alpha := PreCompose( inverse_phi_2, i_I2 ) + PreCompose( h1, i_B1 );
    
    i_I1 := InjectionOfCofactorOfDirectSum( [ I1, B2 ], 1 );
    
    i_B2 := InjectionOfCofactorOfDirectSum( [ I1, B2 ], 2 );
    
    beta := PreCompose( inverse_phi_1, i_I1 ) + PreCompose( h2, i_B2 );
    
    return PreCompose( Inverse( alpha ), beta );
    
    end );
    
    
    
#####################################
##
## Immediate Methods and Attributes 
##
#####################################

InstallImmediateMethod( INSTALL_LOGICAL_IMPLICATIONS_FOR_FROBENIUS_CATEGORY,
               IsCapCategory and IsFrobeniusCategory, 
               0,
               
   function( category )
   
   AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "FrobeniusCategoriesForCAP", "LogicForFrobeniusCategories" ),
        "PredicateImplicationsForGeneralFrobeniusCategories.tex" ) );
        
   TryNextMethod( );
     
end );

InstallMethod( AsInflation, 
                  [ IsCapCategoryMorphism ],
                  
    function( alpha )
    
    if IsCapCategoryInflation( alpha ) then 
    
       return alpha;
       
    elif HasIsInflation( alpha ) and IsInflation( alpha ) then 
    
       SetFilterObj( alpha, IsCapCategoryInflation );
       
    elif not CanCompute( CapCategory( alpha ), "IsInflation" ) then 
    
       Error( "There is no method to decide if the morphism is an inflation or not" );
       
    elif not IsInflation( alpha ) then 
    
       Error( "The morphism is not inflation" );
     
    else
    
       SetFilterObj( alpha, IsCapCategoryInflation );
    
    fi;
    
    return alpha;
    
end );

InstallMethod( AsDeflation, 
                  [ IsCapCategoryMorphism ],
                  
    function( alpha )
    
    if IsCapCategoryDeflation( alpha ) then 
    
       return alpha;
       
    elif HasIsDeflation( alpha ) and IsDeflation( alpha ) then 
    
      SetFilterObj( alpha, IsCapCategoryDeflation );
       
    elif not CanCompute( CapCategory( alpha ), "IsDeflation" ) then 
    
       Error( "There is no method to decide if the morphism is an deflation or not" );
       
    elif not IsDeflation( alpha ) then 
    
       Error( "The morphism is not deflation" );
     
    else
    
    SetFilterObj( alpha, IsCapCategoryDeflation );
    
    fi;
    
    return alpha;
    
end );

InstallMethod( ConflationOfInflation, 
               [ IsCapCategoryInflation ], 
   function( alpha )
   
   return CreateConflation( alpha, CokernelProjection( alpha ) );
   
end );

InstallMethod( ConflationOfDeflation, 
               [ IsCapCategoryDeflation ], 
   function( alpha )
   
   return CreateConflation( KernelEmbedding( alpha ), alpha );
   
end );
