


#######################################
##
## Representations
##
#######################################


DeclareRepresentation( "IsCapCategoryShortSequenceRep",
                        IsCapCategoryShortSequence and IsAttributeStoringRep,
                        [ ] );

DeclareRepresentation( "IsCapCategoryExactShortSequenceRep",

                        IsCapCategoryExactShortSequence and IsAttributeStoringRep,
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

BindGlobal( "CapCategoryExactShortSequencesFamily",
  NewFamily( "CapCategoryExactShortSequencesFamily", IsCapCategoryShortSequence ) );

BindGlobal( "CapCategoryMorphismsOfShortSequencesFamily",
  NewFamily( "CapCategoryMorphismsOfShortSequencesFamily", IsObject ) );
  
BindGlobal( "TheTypeCapCategoryShortSequence", 
  NewType( CapCategoryShortSequencesFamily, 
                      IsCapCategoryShortSequenceRep ) );
                      
BindGlobal( "TheTypeCapCategoryExactShortSequence", 
  NewType( CapCategoryExactShortSequencesFamily, 
                      IsCapCategoryExactShortSequenceRep ) );
                      
BindGlobal( "TheTypeCapCategoryMorphismOfShortSequences", 
  NewType( CapCategoryMorphismsOfShortSequencesFamily, 
                      IsCapCategoryMorphismOfShortSequencesRep ) );
       
                        
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
   
   if not IsZeroForMorphisms( PreCompose( alpha, beta ) ) then 
   
     Error( "The composition of the two morphisms is not Zero" );
     
   fi;
   
   s := rec( object1:= Source( alpha ), 
             
             morphism1:= alpha,
             
             object2 := Range( alpha ),
             
             morphism2 := beta,
             
             object1 := Range( beta ) );
             
    ObjectifyWithAttributes( s, TheTypeCapCategoryShortSequence,
    
                             CapCategory, CapCategory( alpha ) );
                             
    return s;
    
end );

