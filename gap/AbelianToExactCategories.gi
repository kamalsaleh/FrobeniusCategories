##############################################################
##  AbelianToExactCategories.gd           Kamal Saleh
##
##                                        Siegen University 
##############################################################

##
InstallMethod( TurnAbelianCategoryToExactCategory, 
                     [ IsCapCategory ], 
       
function( category )

if not IsAbelianCategory( category ) then 
   
   Error( "The given category is supposed to be abelian" );
   
fi;

if HasIsFinalized( category ) then 

   Error( "The category is finalized and hence no methods can be added!\n" );

fi;

## We define the class of conflations to be the class of all short exact sequences.

AddIsConflation( category,
function( seq )
  return IsShortExactSequence( seq );
end );

# In Abelian categories every mono is the kernel mono of its cokernel epi;

AddIsInflation( category, 
    function( mor )
    return IsMonomorphism( mor );
end );

## I Abelian categories every epi is the cokernel epi of its kernel mono;
                          
AddIsDeflation( category, 
    function( mor )
    return IsEpimorphism( mor );   
end );

AddConflationOfDeflation( category,
    function( mor )
    if not IsDeflation(mor) then
        Error( "The given morphism is not deflation" );
    fi;
    return CreateConflation( KernelEmbedding(mor), mor );    
end );

AddConflationOfInflation( category,
    function( mor )
    if not IsInflation(mor) then
        Error( "The given morphism is not inflation" );
    fi;
    return CreateConflation( mor, CokernelProjection( mor ) );    
end );

AddExactFiberProduct( category, 
    function( mor1, mor2 )              
    return FiberProduct( mor1, mor2 );
  end );

AddProjectionInFactorOfExactFiberProduct( category,
    function( D, i )
    return ProjectionInFactorOfFiberProduct( D, i );
end );
                                
AddUniversalMorphismIntoExactFiberProduct( category, 
    function( D, tau )                                                 
    return UniversalMorphismIntoFiberProduct( D, tau );
end );

AddExactPushout( category, 
    function( mor1, mor2 )                              
    return Pushout( mor1, mor2 );
end );

AddInjectionOfCofactorOfExactPushout( category,
    function( D, i )
    return InjectionOfCofactorOfPushout(D,i);
end );

AddUniversalMorphismFromExactPushout( category, 
    function( D, tau )                                            
    return UniversalMorphismFromPushout( D, tau );
end );

if HasIsAbelianCategoryWithEnoughProjectives( category ) and
        IsAbelianCategoryWithEnoughProjectives( category ) then

    SetIsExactCategoryWithEnoughExactProjectives( category, true );

    AddIsExactProjectiveObject( category, IsProjective );
    AddDeflationFromSomeExactProjectiveObject( category, EpimorphismFromSomeProjectiveObject );
    AddExactProjectiveLift( category, ProjectiveLift );

fi;

if HasIsAbelianCategoryWithEnoughInjectives( category ) and 
        IsAbelianCategoryWithEnoughInjectives( category ) then 

    SetIsExactCategoryWithEnoughExactInjectives( category, true );

    AddIsExactInjectiveObject( category, IsInjective );
    AddInflationIntoSomeExactInjectiveObject( category, MonomorphismIntoSomeInjectiveObject );
    AddExactInjectiveColift( category, InjectiveColift );

fi;

SetIsExactCategory( category, true );
                                                
return category;

end );
