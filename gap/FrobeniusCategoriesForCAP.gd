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

 DeclareOperationWithCache( "IsInflation", [ IsCapCategoryMorphism ] );
 DoDeclarationStuff( "IsInflation" );

 DeclareOperationWithCache( "IsDeflation", [ IsCapCategoryMorphism ] );
 DoDeclarationStuff( "IsDeflation" );

 DeclareOperationWithCache( "FR3", [ IsCapCategoryConflation, IsCapCategoryConflation ] );
 DoDeclarationStuff( "FR3" );

 DeclareOperationWithCache( "FR4", [ IsCapCategoryConflation, IsCapCategoryConflation ] );
 DoDeclarationStuff( "FR4" );

 DeclareOperationWithCache( "FR5", [ IsCapCategoryConflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "FR5" );

 DeclareOperationWithCache( "FiberProductByFR5", [ IsCapCategoryConflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "FiberProductByFR5" );

 DeclareOperationWithCache( "ProjectionsOfFiberProductByFR5", [ IsCapCategoryConflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "ProjectionsOfFiberProductByFR5" );
 
 DeclareOperationWithCache( "UniversalMorphismIntoFiberProductByFR5", [ IsList, IsList ] );
 DoDeclarationStuff( "UniversalMorphismIntoFiberProductByFR5" );
 
 DeclareOperationWithCache( "FR6", [ IsCapCategoryConflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "FR6" );

 DeclareOperationWithCache( "PushoutByFR6", [ IsCapCategoryConflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "PushoutByFR6" );
 
 DeclareOperationWithCache( "InjectionsOfPushoutByFR6", [ IsCapCategoryConflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "InjectionsOfPushoutByFR6" );

 DeclareOperationWithCache( "UniversalMorphismFromPushoutByFR6", [ IsList, IsList ] );
 DoDeclarationStuff( "UniversalMorphismFromPushoutByFR6" );
 
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

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_FROBENIUS_CATEGORY",
                  IsCapCategory );

#################################
##
## Properties
##
#################################

DeclareProperty( "IsFrobeniusCategory", IsCapCategory );

