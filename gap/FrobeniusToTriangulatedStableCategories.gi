

BindGlobal( "COMPUTE_TRIANGULATED_STRUCTURE_OF_A_STABLE_CATEGORY_OF_A_FROBENIUS_CATEGORY", 

    function( stable_category )
    
    # Here we start computing the triangulated structure
    
    # Adding the shift of objects method 
    
    # We fit the object obj into a conflation using injective object:   obj --------> I --------> M
    # Then we define ShiftOfObject( obj ) := M
   
    AddShiftOfObject( stable_category, function( obj )
                                       local underlying_obj, conf;
                                       
                                       underlying_obj := UnderlyingObjectOfTheStableObject( obj );
                                       
                                       conf := FitIntoConflationUsingInjectiveObject( underlying_obj );
                                       
                                       return AsStableCategoryObject( stable_category, conf!.object3 );
                                       
                                       end );
   
   # Adding the shift of morphisms method
   
   # Remember : That I is injective object when every morphism f : X → I factors through every mono X → Y.
   # the complement morphism is InjectiveColift( mono, f ).
   
   # mor0: A -----> B
   
   #  conf_A:     A -------> I(A) ------> T(A)
   #              |           |             |
   #         mor0 |      mor1 |             | mor2
   #              V           V             V
   #  conf_B:     B -------> I(B) ------> T(B)
   
   AddShiftOfMorphism( stable_category, function( mor )
                                        local A, B, conf_A, conf_B, mor0, mor1, mor2;
                                        
                                        mor0 := UnderlyingMorphismOfTheStableMorphism( mor );
                                        
                                        A := Source( mor0 );
                                        
                                        B := Range( mor0 );
                                        
                                        conf_A := FitIntoConflationUsingInjectiveObject( A );
                                        
                                        conf_B := FitIntoConflationUsingInjectiveObject( B );
                                        
                                        mor1 := InjectiveColift( conf_A!.morphism1 , PreCompose( mor0, conf_B!.morphism1 ) );
                                        
                                        mor2 :=  CokernelColift( conf_A!.morphism1, PreCompose( mor1, conf_B!.morphism2 ) );
                                        
                                        return AsStableCategoryMorphism( stable_category, mor2 );
                                        
                                        end );
                                     
   
    # Adding the reverse shift of objects method 
    
    # We fit the given object obj into a conflation using projective object:  M --------> P --------> obj.
    # Then we define ReverseShiftOfObject( obj ) := M
   
   AddReverseShiftOfObject( stable_category, function( obj )
                                             local underlying_obj, conf;
                                             
                                             underlying_obj := UnderlyingObjectOfTheStableObject( obj );
                                             
                                             conf := FitIntoConflationUsingProjectiveObject( underlying_obj );
                                             
                                             return AsStableCategoryObject( stable_category, conf!.object1 );
                                             
                                             end );
                                             
   
   # Adding the  reverse shift of morphisms method
   
   # Remember : That P is projective object when every morphism f : P → X factors through every epi Y → X.
   # the complement morphism is ProjectiveLift( f, epi ).
   
   # mor0: A -----> B
   
   #  conf_A:    S(A) -------> P(A) --------> A
   #              |             |             |
   #         mor2 |        mor1 |             | mor0
   #              V             V             V
   #  conf_B:    S(B) -------> P(B) --------> B
   
   AddReverseShiftOfMorphism( stable_category, function( mor )
                                        local A, B, conf_A, conf_B, mor0, mor1, mor2;
                                        
                                        mor0 := UnderlyingMorphismOfTheStableMorphism( mor );
                                        
                                        A := Source( mor0 );
                                        
                                        B := Range( mor0 );
                                        
                                        conf_A := FitIntoConflationUsingProjectiveObject( A );
                                        
                                        conf_B := FitIntoConflationUsingProjectiveObject( B );
                                        
                                        mor1 := ProjectiveLift( PreCompose( conf_A!.morphism2, mor0 ), conf_B!.morphism2 );
                                        
                                        mor2 :=  KernelLift( PreCompose( conf_A!.morphism1, mor1 ), conf_B!.morphism2 );
                                        
                                        return AsStableCategoryMorphism( stable_category, mor2 );
                                        
                                        end );
                                        
  # Standard triangles are of the form  
  #       A -------> B -------> C ----------> T( A )
  # where  C = PushoutObject( B, I ) where A ----> I ----> T( A ) is a conflation.
  
  # Adding TR1, 
  # It states that every morphism f: A ---> B can be completed to an exact triangle.
  
  
   AddTR1( stable_category, function( mor )
                            local underlying_mor, A, B, conf_A, resulted_conf, fr;
                            
                            underlying_mor := UnderlyingMorphismOfTheStableMorphism( mor );
                            
                            A := Source( underlying_mor );
                            
                            B := Range( underlying_mor );
                            
                            conf_A := FitIntoConflationUsingInjectiveObject( A );
                            
                            g := FR6( conf_A, underlying_mor )[ 1 ]!.morphism1;
                            
                            u := UniversalMorphismFromPushoutByFR6( [ conf_A, underlying_mor ], 
                                                                    [ conf_A!.morphism2, ZeroMorphism( B, Range( conf_A!.morphism2 ) ) ] );
                            
                            return [ AsStableCategoryMorphism( stable_category, g ),
                                     AsStableCategoryObject( stable_category, Range( g ) ),
                                     AsStableCategoryMorphism( stable_category, u ) ];
                            
                            end );
   
  # Adding TR3
  # Input is two triangles tr_f, tr_g and two morphisms u, v such that vf1 = g1u.
  #
  #             f1          f2              f3
  # tr_f:  A ---------> B ----------> C ------------> A[ 1 ]
  #        |            |             |                |
  #      u |          v |             | ?              | u[ 1 ]
  #        V            V             V                V
  # tr_g:  A' --------> B'----------> C'------------> A'[ 1 ]
  #              g1            g2            g3
  #
  # Output is w: C ---> C' such that the diagram is commutative

    AddTR3( stable_category, function( tr_f, tr_g, u, v )
                             local 
                             
                             f1 := tr_f!.morphism1;
                             
                             g1 := tr_g!.morphism1;
                             
                             standard_tr_f := CompleteMorphismToExactTriangleByTR1( f1 );
                             
                             Standard_tr_g := CompleteMorphismToExactTriangleByTR1( g1 );
                             
                             
                            
   
    return stable_category;
    
end );
   