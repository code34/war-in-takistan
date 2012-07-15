	//	File: infoText.sqf
	//	Author: Karel Moricky - reworked by code34 for warcontext
	// 	Description: Info with some effects.

	private [
		"_count",
		"_line",
		"_logs",
		"_text"
	];

	// Array of info text
	_text = _this;

	waituntil {wccanwriteinfotext};
	wccanwriteinfotext = false;

	3100 cutrsc ["rscInfoText","plain"];

	// add info text to warcontext logs
	_logs = "";
	_count = (count wcclientlogs) - 1;
	{ 
		if(wcclientlogs select (_count) != format ["%1", _x]) then {
			_logs = _logs + " " + format ["%1", _x];
		};
	}foreach _text;
	wcclientlogs = wcclientlogs + [_logs];

	_textArrayUnicode = [];
	{_textArrayUnicode = _textArrayUnicode + [toarray _x]} foreach _text;
	
	
	//--- Separate letters
	_textArrayLines = [];
	for "_i" from 0 to (count _textArrayUnicode - 1) do {
		_line = _textArrayUnicode select _i;
		_textArrayTemp = [];
		{_textArrayTemp = _textArrayTemp + [tostring [_x]]} foreach _line;
		_textArrayLines set [_i,_textArrayTemp];
	};
	
	
	//--- Merge arrays
	_textArray = [];
	_emptyArray = [];
	_nArrayTemp = [];
	_n = 0;
	{
		_line = _x;
		_textArray = _textArray + _line + ["\n"];
		{
			_emptyArray = _emptyArray + [" "]; //--- Space
			_nArrayTemp = _nArrayTemp + [_n];
			_n = _n + 1;
		} foreach _x;
		_n = _n + 1;
		_emptyArray = _emptyArray + ["\n"];
	} foreach _textArrayLines;
	_finalArray = _emptyArray;
	_text = composetext _finalArray;
	
	
	//--- Random order
	_nArray = [];
	while {count _nArrayTemp > 0} do {
		_element = _nArrayTemp select (floor random (count _nArrayTemp));
		_nArray = _nArray + [_element];
		_nArrayTemp = _nArrayTemp - [_element];
	};
	
	
	//--- Visualization
	disableserialization;
	_display = uinamespace getvariable "BIS_InfoText";
	_textControl = _display displayctrl 3101;
	
	
	_text = composetext _finalArray;
	_textControl ctrlsettext str _text;
	_textControl ctrlSetFontHeight 0.04;
	_textControl ctrlcommit 0.01;
	
	{
		_finalArray set [_x,_textArray select _x];
		_text = composetext _finalArray;
		_textControl ctrlsettext str _text;
		_textControl ctrlcommit 0.01;
		sleep 0.01;
	} foreach _nArray;
	
	sleep 6;
	
	
	//--- Fade away
	{
		_finalArray set [_x," "];
		_text = composetext _finalArray;
		_textControl ctrlsettext str _text;
		_textControl ctrlcommit 0.01;
		sleep 0.01;
	} foreach _nArray;
	
	
	3100 cuttext ["","plain"];
	
	wccanwriteinfotext = true;