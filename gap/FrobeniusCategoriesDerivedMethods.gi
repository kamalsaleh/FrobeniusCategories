### Hey

AddDerivationToCAP( FiberProductByFR5, 
                   
                   [ [ FR5, 1 ] ], 
                   
   function( conf, mor )
   local fr5, obj;
   
   fr5 := FR5( conf, mor );
   
   obj := fr5[ 1 ]!.object2;
   
   AddToGenesis( obj , "FiberProductDiagramByFR5", [ conf, mor ] );
   AddToGenesis( obj , "ProjectionsOfFiberProduct", [ fr5[ 2 ], fr5[ 1 ]!.morphism2 ] );
   
   return obj;
   
end: Description := "returns the FiberProduct of two morphisms by FR5" );



AddDerivationToCAP( ProjectionsOfFiberProductByFR5, 
                   
                   [ [ FR5, 1 ] ], 
                   
   function( conf, mor )
   local fr5, l;
   
   fr5 := FR5( conf, mor );
   
   l:= [ fr5[ 2 ], fr5[ 1 ]!.morphism2 ];
   
   return l;
   
end: Description := "returns the projections of the FiberProduct of two morphisms by FR5" );


AddDerivationToCAP( PushoutByFR6, 
                   
                   [ [ FR6, 1 ] ], 
                   
   function( conf, mor )
   local fr6, obj;
   
   fr6 := FR6( conf, mor );
   
   obj := fr6[ 1 ]!.object2;
   
   AddToGenesis( obj , "PushoutDiagramByFR5", [ conf, mor ] );
   AddToGenesis( obj , "InjectionsOfPushout", [ fr6[ 2 ], fr6[ 1 ]!.morphism1 ] );
   
   return obj;
   
end: Description := "returns the pushout of two morphisms by FR6" );



AddDerivationToCAP( InjectionsOfPushoutByFR6, 
                   
                   [ [ FR6, 1 ] ], 
                   
   function( conf, mor )
   local fr6, l;
   
   fr6 := FR6( conf, mor );
   
   l:= [ fr6[ 2 ], fr6[ 1 ]!.morphism1 ];
   return l;
   
end: Description := "returns the injections of the pushout of two morphisms by FR5" );


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
      


















