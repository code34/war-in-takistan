	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  call BIS HINT SYSTEM
	// -----------------------------------------------	

	private [
		"_title", 
		"_instruction", 
		"_duration"
		];

	_title 		= _this select 0;
	_instruction 	= _this select 1;
	_information	= _this select 2;
	_duration 	= _this select 3;

	[] call bis_fnc_hints;
	[] call BIS_AdvHints_setDefaults;
	BIS_AdvHints_THeader = _title;
	if(format["%1", _information] != "") then {
		BIS_AdvHints_TInfo = _information;
	} else {
		BIS_AdvHints_TInfo = "";
	};
	BIS_AdvHints_TImp = "";
	BIS_AdvHints_TAction = format["<t color='#e0e0e0'>%1</t>", _instruction];
	BIS_AdvHints_TBinds = "";
	BIS_AdvHints_Text = call BIS_AdvHints_formatText;
	BIS_AdvHints_Duration = _duration;
	BIS_AdvHints_HideCode = "hintSilent '';";
	call BIS_AdvHints_showHint;