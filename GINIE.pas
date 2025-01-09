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
			Procedure SetV(Cat,Key,Val:String); Overload;
			Procedure SetV(Cat,Key:String; Val:Integer); Overload;
			Function GetV(Cat,Key:String):String;
			Function UnParse:String;
	End;

Procedure CheckGINIELoaded; // Only used to test the compiler

Implementation

Procedure CheckGINIELoaded; Begin WriteLn('GINIE has been loaded') End;

Constructor TGINIE.Create;
Begin
	_Values := GINIE_ValMap.Create;
	_Lists  := GINIE_LstMap.Create;
End;

Procedure TGINIE.SetV(Cat,Key,Val:String);
Var C,K:String;
Begin
	C:=UpperCase(Cat);
	K:=UpperCase(Key);
	if _Values.IndexOf(C)<0 Then _Values.Add(C,GINIE_StringMap.Create);
	if _Values[C].IndexOf(K)<0 Then _Values[C].Add(K,Val) Else _Values[C][K]:=Val;	
End;

Procedure TGINIE.SetV(Cat,Key:String; Val:Integer);
Begin
	SetV(Cat,Key,IntToStr(Val))
End;

Function TGINIE.GetV(Cat,Key:String):String;
Var C,K:String;
Begin
	C:=UpperCase(Cat);
	K:=UpperCase(Key);
	If _Values.IndexOf(C)<0 Then
		Exit('')
	Else If  _Values[C].IndexOf(K)<0 Then
		Exit('')
	Else
		Exit(_Values[C][K])
End;

Function TGINIE.UnParse:String;
	Var 
		Ret:String = '# Unparsed with GINIE for Free Pascal'#10'# (c) Jeroen P. Broks'#10#10;
		ic,ik:integer;
	Begin
		For ic:=0 to _Values.Count-1 do begin
			Ret := Ret + '['+_Values.Keys[ic]+']'#10;
			For ik:=0 to _Values[_Values.Keys[ic]].Count-1 do Begin
				Ret := Ret + 
				_Values.Data[ic].Keys[ik] 
				+ '=' + _Values.Data[ic].Data[ik] 
				+ ''#10;
			End;
		End;
	Exit(Ret);
End;

End.