

BindGlobal( "COMPUTE_TRIANGULATED_STRUCTURE_OF_A_STABLE_CATEGORY_OF_A_FROBENIUS_CATEGORY", 

    function( stable_category )
    
    # Here we start computing the triangulated structure
    
    # Adding the shift of objects method 
    
    AddShiftOfObject( stable_category, function( obj )
                                       local underlying_obj, conf;
                                       
                                       underlying_obj := UnderlyingObjectOfTheStableObject( obj );
                                       
                                       conf := FitIntoConflationUsingInjectiveObject( underlying_obj );
                                       
                                       return AsStableCategoryObject( stable_category, conf!.object3 );
                                       
                                       end );
   
   # Adding the shift of morphisms method
   
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
                                        
                                        return AsStableCategoryMorphism( mor2 );
                                        
                                        end );
                                     
   return stable_category;
    
   end );
