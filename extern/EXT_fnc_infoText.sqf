	/*
		File: infoText.sqf
		Author: Karel Moricky
	
		Description:
		Info with some ffect.
	
		Parameter(s):
		_this: Array containing lines of text (String)
	*/
	
	waituntil {wccanwriteinfotext};
	wccanwriteinfotext = false;
	
	3100 cutrsc ["rscInfoText","plain"];
	
	//--- Separate lines
	_text = _this;
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
			//_emptyArray = _emptyArray + [_line call bis_fnc_selectrandom]; //--- Shuffled text
			//_emptyArray = _emptyArray + [str floor random 2]; //--- Binary Solo
			//_emptyArray = _emptyArray + [""]; //--- Rolling text
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
	_textControl ctrlcommit 0.01;
	sleep 1;
	
	{
		_finalArray set [_x,_textArray select _x];
		_text = composetext _finalArray;
		_textControl ctrlsettext str _text;
		_textControl ctrlcommit 0.01;
		//playsound "counter";
		//if (random 1 > 0.9) then {sleep 0.1};
		sleep 0.01;
	} foreach _nArray;
	
	sleep 6;
	
	
	//--- Fade away
	{
		_finalArray set [_x," "];
		_text = composetext _finalArray;
		_textControl ctrlsettext str _text;
		_textControl ctrlcommit 0.01;
		//playsound "counter";
		//if (random 1 > 0.9) then {sleep 0.2};
		sleep 0.01;
	} foreach _nArray;
	
	
	3100 cuttext ["","plain"];
	
	wccanwriteinfotext = true;