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




















