Unit GINIE;

// GINIE Is Not Ini Either

Interface

Uses
   SysUtils, FGL;
   
Type 
	GINIE_StringMap = specialize TFPGMap<string,string>;
	GINIE_StringArr = specialize TFPGMap<integer,string>;
	GINIE_ValMap    = specialize TFPGMap<string,GINIE_StringMap>;
	GINIE_LstMap    = specialize TFPGMap<string,GINIE_StringArr>;
	TGINIE = Object
		Private
			_Values:GINIE_ValMap;
			_Lists:GINIE_LstMap;
		Public
			Constructor Create;
	End;

Procedure CheckGINIELoaded; // Only used to test the compiler

Implementation

Procedure CheckGINIELoaded; Begin WriteLn('GINIE has been loaded') End;

Constructor TGINIE.Create;
Begin
	_Values := GINIE_ValMap.Create;
	_Lists  := GINIE_LstMap.Create;
End;


End.