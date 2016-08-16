


#######################################
##
## Representations
##
#######################################


DeclareRepresentation( "IsCapCategorySequenceRep",
                        IsCapCategorySequence and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryExactSequenceRep",

                        IsCapCategoryExactSequence and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryMorphismOfSequencesRep",

                        IsCapCategoryMorphismOfSequences and IsAttributeStoringRep, 
                        [ ] );


##############################
##
## Family and type 
##
##############################

BindGlobal( "CapCategorySequencesFamily",
  NewFamily( "CapCategorySequencesFamily", IsObject ) );

BindGlobal( "CapCategoryExactSequencesFamily",
  NewFamily( "CapCategoryExactSequencesFamily", IsCapCategorySequence ) );

BindGlobal( "CapCategoryMorphismsOfSequencesFamily",
  NewFamily( "CapCategoryMorphismsOfSequencesFamily", IsObject ) );
  
BindGlobal( "TheTypeCapCategorySequence", 
  NewType( CapCategorySequencesFamily, 
                      IsCapCategorySequenceRep ) );
                      
BindGlobal( "TheTypeCapCategoryExactSequence", 
  NewType( CapCategoryExactSequencesFamily, 
                      IsCapCategoryExactSequenceRep ) );
                      
BindGlobal( "TheTypeCapCategoryMorphismOfSequences", 
  NewType( CapCategoryMorphismsOfSequencesFamily, 
                      IsCapCategoryMorphismOfSequencesRep ) );
       
                        
########################################
##
##  Constructors 
##
########################################

InstallMethod( CreateSequence, 
               
               [ IsCapCategoryMorphism, IsCapCategoryMorphism ], 
               
   function( alpha, beta )
   local s;
   
   s := rec( object1:= Source( alpha ), 
             
             morphism1:= alpha,
             
             object2 := Range( alpha ),
             
             morphism2 := beta,
             
             object1 := Range( beta ) );
             
    ObjectifyWithAttributes( s, TheTypeCapCategorySequence,
    
                             CapCategory, CapCategory( alpha ) );
                             
    return s;
    
end );

