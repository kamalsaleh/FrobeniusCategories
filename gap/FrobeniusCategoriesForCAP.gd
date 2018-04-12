#################################
##
##  Declarations
##
#################################

DeclareGlobalVariable( "CAP_INTERNAL_FROBENIUS_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "FROBENIUS_CATEGORIES_METHOD_NAME_RECORD" );

DeclareCategory( "IsCapCategoryShortSequence", IsCapCategoryObject );

DeclareCategory( "IsCapCategoryMorphismOfShortSequences", IsCapCategoryMorphism );

DeclareCategory( "IsCapCategoryShortExactSequence", IsCapCategoryShortSequence );

DeclareCategory( "IsCapCategoryConflation", IsCapCategoryShortExactSequence );

DeclareCategory( "IsCapCategoryInflation", IsCapCategoryMorphism );

DeclareCategory( "IsCapCategoryDeflation", IsCapCategoryMorphism );

#################################
##
##  Saving time for declarations 
##
#################################


# DeclareOperation( "DoDeclarationStuff", [ IsString ] );
# InstallMethod( DoDeclarationStuff, 
#                 [ IsString ], 
# function( name_of_the_function )
# Print( "DeclareOperation( ", Concatenation( "\"Add", name_of_the_function ), "\",\n" );
# Print( "                  [ IsCapCategory, IsFunction ] );\n" );
# Print( "\nDeclareOperation( ",Concatenation( "\"Add", name_of_the_function ), "\",\n" );
# Print( "                  [ IsCapCategory, IsFunction, IsInt ] );\n" );
# Print( "DeclareOperation( ", Concatenation( "\"Add", name_of_the_function ), "\",\n" );
# Print( "                  [ IsCapCategory, IsList, IsInt ] );\n" );
#                 
# Print( "DeclareOperation( ", Concatenation( "\"Add", name_of_the_function ), "\",\n" );
# Print( "                  [ IsCapCategory, IsList ] );\n" );
# end );

####################################
##
##  Methods Declarations in Records
##
####################################

 
DeclareProperty( "IsConflation", IsCapCategoryShortSequence );

DeclareOperation( "AddIsConflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsConflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsConflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsConflation",
                  [ IsCapCategory, IsList ] );

DeclareProperty( "IsInflation", IsCapCategoryMorphism );

DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsInflation",
                  [ IsCapCategory, IsList ] );

 DeclareProperty( "IsDeflation", IsCapCategoryMorphism );
 
 DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsDeflation",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "ExactKernelObject", IsCapCategoryMorphism );

DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelObject",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "ExactKernelEmbedding", IsCapCategoryMorphism );

DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelEmbedding",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactKernelEmbeddingWithGivenExactKernelObject", [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelEmbeddingWithGivenExactKernelObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactKernelLift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactKernelLift",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "ExactCokernelObject", IsCapCategoryMorphism );

DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactCokernelProjectionWithGivenExactCokernelObject", [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelProjectionWithGivenExactCokernelObject",
                  [ IsCapCategory, IsList ] );
                  
DeclareAttribute( "ExactCokernelProjection", IsCapCategoryMorphism );

DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelProjection",
                  [ IsCapCategory, IsList ] );

##
DeclareOperation( "ExactCokernelColift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactCokernelColift",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "ConflationOfInflation", IsCapCategoryMorphism );

DeclareOperation( "AddConflationOfInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddConflationOfInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddConflationOfInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddConflationOfInflation",
                  [ IsCapCategory, IsList ] );

DeclareAttribute( "ConflationOfDeflation", IsCapCategoryMorphism );

DeclareOperation( "AddConflationOfDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddConflationOfDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddConflationOfDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddConflationOfDeflation",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactFiberProduct", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ProjectionInFactorOfExactFiberProduct", [ IsList, IsInt ] );

DeclareOperation( "AddProjectionInFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddProjectionInFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddProjectionInFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "UniversalMorphismIntoExactFiberProduct", [ IsList, IsList ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactPushout", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "InjectionOfCofactorOfExactPushout", [ IsList, IsInt ] );

DeclareOperation( "AddInjectionOfCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInjectionOfCofactorOfExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInjectionOfCofactorOfExactPushout",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "UniversalMorphismFromExactPushout", [ IsList, IsList ] );

DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "FitIntoConflationUsingExactInjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddFitIntoConflationUsingExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddFitIntoConflationUsingExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddFitIntoConflationUsingExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddFitIntoConflationUsingExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "FitIntoConflationUsingExactProjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddFitIntoConflationUsingExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddFitIntoConflationUsingExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddFitIntoConflationUsingExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddFitIntoConflationUsingExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareProperty( "IsExactProjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareProperty( "IsExactInjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "DeflationFromSomeExactProjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "InflationIntoSomeExactInjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactProjectiveLift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsList ] );

DeclareOperation( "ExactInjectiveColift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsList ] );

##
DeclareProperty( "CanBeFactoredThroughExactProjective", IsCapCategoryMorphism );

DeclareOperation( "AddCanBeFactoredThroughExactProjective",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCanBeFactoredThroughExactProjective",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddCanBeFactoredThroughExactProjective",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddCanBeFactoredThroughExactProjective",
                  [ IsCapCategory, IsList ] );

##
DeclareProperty( "CanBeFactoredThroughExactInjective", IsCapCategoryMorphism );

DeclareOperation( "AddCanBeFactoredThroughExactInjective",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCanBeFactoredThroughExactInjective",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddCanBeFactoredThroughExactInjective",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddCanBeFactoredThroughExactInjective",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "FactorizationThroughExactProjective", IsCapCategoryMorphism );

DeclareOperation( "AddFactorizationThroughExactProjective",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddFactorizationThroughExactProjective",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddFactorizationThroughExactProjective",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddFactorizationThroughExactProjective",
                  [ IsCapCategory, IsList ] );

##
DeclareAttribute( "FactorizationThroughExactInjective", IsCapCategoryMorphism );

DeclareOperation( "AddFactorizationThroughExactInjective",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddFactorizationThroughExactInjective",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddFactorizationThroughExactInjective",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddFactorizationThroughExactInjective",
                  [ IsCapCategory, IsList ] );

#################################
##
## Methods 
##
#################################

DeclareAttribute( "CategoryOfShortSequences", IsCapCategory );

DeclareOperation( "CreateShortSequence", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "CreateShortExactSequence", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
           
DeclareOperation( "CreateConflation", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SchanuelsIsomorphism", [ IsCapCategoryConflation, IsCapCategoryConflation, IsString ] );

DeclareAttribute( "IsShortExactSequence_", IsCapCategoryShortSequence );
#################################
##
##  Attributes
##
#################################

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_FROBENIUS_CATEGORY", IsCapCategory );
DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_EXACT_CATEGORY", IsCapCategory );

DeclareAttribute( "SetFilterOnInflations", IsCapCategoryMorphism );

DeclareAttribute( "SetFilterOnDeflations", IsCapCategoryMorphism );
DeclareAttribute( "SetFilterOnConflations", IsCapCategoryShortSequence );
        
#################################
##
## Properties
##
#################################

DeclareProperty( "IsExactCategory", IsCapCategory );
DeclareProperty( "IsExactCategoryWithEnoughExactProjectives", IsCapCategory );
DeclareProperty( "IsExactCategoryWithEnoughExactInjectives", IsCapCategory );

DeclareProperty( "IsFrobeniusCategory", IsCapCategory );

KeyDependentOperation( "MorphismAt", IsCapCategoryShortSequence, IsInt, ReturnTrue );
DeclareOperation( "\^", [ IsCapCategoryShortSequence, IsInt ] );

KeyDependentOperation( "ObjectAt", IsCapCategoryShortSequence, IsInt, ReturnTrue );
#DeclareOperation( "\[\]", [ IsCapCategoryShortSequence, IsInt ] );

