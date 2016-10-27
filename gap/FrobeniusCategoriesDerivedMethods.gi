
AddDerivationToCAP( IsInflation, 
            [ [ IsConflation, 1 ], [ CokernelProjection, 1 ] ], 
            
      function( mor )
      
      local cokernel_projection, seq;
      
      cokernel_projection := CokernelProjection( mor );
      
      seq := CreateShortSequence( mor, cokernel_projection );
      
      return IsConflation( seq );
      
      end : Description := "returns if the given morphism is inflation regarding the frobenius structure" );
      
AddDerivationToCAP( IsDeflation, 
            [ [ IsConflation, 1 ], [ KernelEmbedding, 1 ] ], 
            
      function( mor )
      
      local kernel_embedding, seq;
      
      kernel_embedding := KernelEmbedding( mor );
      
      seq := CreateShortSequence( kernel_embedding, mor );
      
      return IsConflation( seq );
      
      end : Description := "returns if the given morphism is deflation regarding the frobenius structure" );
      


















