#################################
##
##  Declarations
##
#################################

DeclareGlobalVariable( "CAP_INTERNAL_FROBENIUS_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "FROBENIUS_CATEGORIES_METHOD_NAME_RECORD" );

DeclareCategory( "IsCapCategoryShortSequence", IsObject );

DeclareCategory( "IsCapCategoryShortExactSequence", IsCapCategoryShortSequence );

DeclareCategory( "IsCapCategoryInflation", IsCapCategoryMorphism );

DeclareCategory( "IsCapCategoryDeflation", IsCapCategoryMorphism );

DeclareCategory( "IsCapCategoryConflation", IsCapCategoryShortExactSequence );

DeclareCategory( "IsCapCategoryMorphismOfShortSequences", IsObject );

#################################
##
##  Saving time for declarations 
##
#################################


if not IsPackageMarkedForLoading( "TriangulatedCategoriesForCAP", ">0.1" ) then

##
 DeclareOperation( "DoDeclarationStuff", [ IsString ] );
 
## 
 InstallMethod( DoDeclarationStuff, 
                [ IsString ], 
 function( name_of_the_function )

 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsFunction, IsInt ] );
                   
 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsFunction ] );


 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsList, IsInt ] );
                   
 DeclareOperation( Concatenation( "Add", name_of_the_function ),
                   [ IsCapCategory, IsList ] );
 end );
 
fi;
####################################
##
##  Methods Declarations in Records
##
####################################

 
 DeclareOperationWithCache( "IsConflation", [ IsCapCategoryShortSequence ] );
 DoDeclarationStuff( "IsConflation" );

 DeclareProperty( "IsInflation", IsCapCategoryMorphism );
 DoDeclarationStuff( "IsInflation" );

 DeclareProperty( "IsDeflation", IsCapCategoryMorphism );
 DoDeclarationStuff( "IsDeflation" );

 DeclareOperationWithCache( "FiberProductObjectInducedByStructureOfExactCategory", [ IsCapCategoryDeflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "FiberProductObjectInducedByStructureOfExactCategory" );

 DeclareOperationWithCache( "ProjectionsOfFiberProductInducedByStructureOfExactCategory", [ IsCapCategoryDeflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "ProjectionsOfFiberProductInducedByStructureOfExactCategory" );
 
 DeclareOperationWithCache( "UniversalMorphismIntoFiberProductInducedByStructureOfExactCategory", [ IsList, IsList ] );
 DoDeclarationStuff( "UniversalMorphismIntoFiberProductInducedByStructureOfExactCategory" );

 DeclareOperationWithCache( "PushoutObjectInducedByStructureOfExactCategory", [ IsCapCategoryInflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "PushoutObjectInducedByStructureOfExactCategory" );
 
 DeclareOperationWithCache( "InjectionsOfPushoutInducedByStructureOfExactCategory", [ IsCapCategoryInflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "InjectionsOfPushoutInducedByStructureOfExactCategory" );

 DeclareOperationWithCache( "UniversalMorphismFromPushoutInducedByStructureOfExactCategory", [ IsList, IsList ] );
 DoDeclarationStuff( "UniversalMorphismFromPushoutInducedByStructureOfExactCategory" );
 
 DeclareOperationWithCache( "FitIntoConflationUsingInjectiveObject", [ IsCapCategoryObject ] );
 DoDeclarationStuff( "FitIntoConflationUsingInjectiveObject" );

 DeclareOperationWithCache( "FitIntoConflationUsingProjectiveObject", [ IsCapCategoryObject ] );
 DoDeclarationStuff( "FitIntoConflationUsingProjectiveObject" );
 
 DeclareOperationWithCache( "InjectiveColift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "InjectiveColift" );
 
 DeclareOperationWithCache( "ProjectiveLift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "ProjectiveLift" );
 
#################################
##
## Methods 
##
#################################

DeclareOperation( "CreateShortSequence", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "CreateShortExactSequence", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "CreateConflation", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#################################
##
##  Attributes
##
#################################

DeclareAttribute( "CapCategory", IsCapCategoryShortSequence );

DeclareAttribute( "AsInflation", IsCapCategoryMorphism );

DeclareAttribute( "AsDeflation", IsCapCategoryMorphism );

DeclareAttribute( "ConflationOfInflation", IsCapCategoryInflation );

DeclareAttribute( "ConflationOfDeflation", IsCapCategoryDeflation );

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_FROBENIUS_CATEGORY",
                  IsCapCategory );
                  
#################################
##
## Properties
##
#################################

DeclareProperty( "IsExactCategory", IsCapCategory );

DeclareProperty( "IsFrobeniusCategory", IsCapCategory );

