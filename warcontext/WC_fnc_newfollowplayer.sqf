	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - radio marker
	// -----------------------------------------------
	private ["_arrayofplayer", "_radio", "_markersize", "_position", "_markerradio", "_marker", "_marker2", "_arrayofmarker", "_side", "_trg", "_list", "_countscream"];

	_trg = createTrigger["EmptyDetector", position player]; 
	_trg setTriggerArea[ 2000 , 2000,0,false];
	_trg setTriggerActivation["Any","PRESENT", true];
	_trg setTriggerStatements["this", "", ""];

	_arrayofmarker = [];
	_countscream = 0;

	while {true} do {
		_trg setpos (position player);
		{deletemarkerlocal _x;}foreach _arrayofmarker;
		_arrayofmarker = [];
		_list = list _trg;
		if (count _list > 0) then {
			{	
				if ((isplayer _x) or (_x in units(group player))) then {	
						if(format ["%1", _x getvariable "deadmarker"] == "true") then {
							_marker = [(name _x), 0.4, position _x, 'ColorRed', 'ICON', 'FDIAGONAL', 'mil_triangle', 0, (name _x), true] call WC_fnc_createmarkerlocal;
						} else {
							if (typeOf vehicle _x in wcmedicclass) then {
								_marker = [(name _x), 0.4, position _x, 'ColorGreen', 'ICON', 'FDIAGONAL', 'defend', 0, (name _x), true] call WC_fnc_createmarkerlocal;
							} else {
								if (typeOf vehicle _x in wcengineerclass) then {
									_marker = [(name _x), 0.4, position _x, 'ColorBlack', 'ICON', 'FDIAGONAL', 'defend', 0, (name _x), true] call WC_fnc_createmarkerlocal;
								} else {
									if(vehicle _x != _x) then {
										_marker = [(name (driver(vehicle _x))), 0.4, position _x, 'ColorBlue', 'ICON', 'FDIAGONAL', 'attack', 0, (name (driver(vehicle _x))), true] call WC_fnc_createmarkerlocal;
									} else {
										_marker = [(name _x), 0.4, position _x, 'ColorBlue', 'ICON', 'FDIAGONAL', 'attack', 0, (name _x), true] call WC_fnc_createmarkerlocal;
									};
								};
							};
						};
						_arrayofmarker = _arrayofmarker + [_marker];
				} else {
					if(_x getvariable "wchostage") then {
						_countscream = _countscream + 1;
						if(_countscream > 20) then {
							_countscream = 0;
							if(_x distance player < 20) then {
								playsound "help1";
							} else {
								if(_x distance player < 60) then {
									playsound "help2";
								} else {
									if(_x distance player < 100) then {
										playsound "help3";
									};
								};
							};
						};
					};
				};
			}foreach _list;
		};
		sleep 0.5;
	};