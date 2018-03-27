


AddDerivationToCAP( IsInflation, 
            [ [ IsConflation, 1 ], [ CokernelProjection, 1 ] ], 
            
      function( mor )
      local cokernel_projection, seq;
      
      cokernel_projection := CokernelProjection( mor );
      
      seq := CreateShortSequence( mor, cokernel_projection );
      
      return IsConflation( seq );
      
end : Description := "returns whether the given morphism is inflation w.r.t the exact structure" );
      
AddDerivationToCAP( IsDeflation, 
            [ [ IsConflation, 1 ], [ KernelEmbedding, 1 ] ], 
            
      function( mor )
      local kernel_embedding, seq;
      
      kernel_embedding := KernelEmbedding( mor );
      
      seq := CreateShortSequence( kernel_embedding, mor );
      
      return IsConflation( seq );
      
end : Description := "returns whether the given morphism is deflation w.r.t the exact structure" );

AddDerivationToCAP( ExactProjectiveLift, 
            [ [ Lift, 1 ] ], 
            
      function( alpha, beta )

      return Lift( alpha, beta );

end : Description := "return the exact projective lift" );

AddDerivationToCAP( ExactInjectiveColift, 
            [ [ Colift, 1 ] ], 
            
      function( alpha, beta )

      return Colift( alpha, beta );

end : Description := "return the exact injective colift" );

AddDerivationToCAP( FitIntoConflationUsingExactInjectiveObject,
                  [ [ InflationIntoSomeExactInjectiveObject, 1 ], [ ConflationOfInflation, 1 ] ],
      function( obj )
      return ConflationOfInflation( InflationIntoSomeExactInjectiveObject( obj ) );
end  );

AddDerivationToCAP( FitIntoConflationUsingExactProjectiveObject,
                  [ [ DeflationFromSomeExactProjectiveObject, 1 ], [ ConflationOfDeflation, 1 ] ],
      function( obj )
      return ConflationOfDeflation( DeflationFromSomeExactProjectiveObject( obj ) );
end  );

