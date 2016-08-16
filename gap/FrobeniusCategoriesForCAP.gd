#################################
##
##  Declarations
##
#################################

DeclareGlobalVariable( "CAP_INTERNAL_FROBENIUS_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "FROBENIUS_CATEGORIES_METHOD_NAME_RECORD" );

DeclareCategory( "IsCapCategorySequence", IsObject );

DeclareCategory( "IsCapCategoryExactSequence", IsCapCategorySequence );

DeclareCategory( "IsCapCategoryMorphismOfSequences", IsObject );

#################################
##
##  Saving time for declarations 
##
#################################

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
 
 
#################################
##
## Methods 
##
#################################

DeclareOperation( "CreateSequence", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );


#################################
##
##  Attributes
##
#################################

DeclareAttribute( "CapCategory", IsCapCategorySequence );