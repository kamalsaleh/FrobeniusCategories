#################################
##
##  Declarations
##
#################################

DeclareGlobalVariable( "CAP_INTERNAL_FROBENIUS_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "FROBENIUS_CATEGORIES_METHOD_NAME_RECORD" );

DeclareCategory( "IsCapCategoryShortSequence", IsObject );

DeclareCategory( "IsCapCategoryShortExactSequence", IsCapCategoryShortSequence );

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

 DeclareOperationWithCache( "FR3", [ IsCapCategoryConflation, IsCapCategoryConflation ] );
 DoDeclarationStuff( "FR3" );

 DeclareOperationWithCache( "FR4", [ IsCapCategoryConflation, IsCapCategoryConflation ] );
 DoDeclarationStuff( "FR4" );

 DeclareOperationWithCache( "FR5", [ IsCapCategoryConflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "FR5" );

 DeclareOperationWithCache( "FiberProductByFR5", [ IsCapCategoryConflation, IsCapCategoryMorphism ] );
 DoDeclarationStuff( "FiberProductByFR5" );

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