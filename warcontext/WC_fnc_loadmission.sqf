	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - create a mission dialog box
	// locality : client side

	private [
		"_missionnumber", 
		"_name", 
		"_textbox", 
		"_index", 
		"_text", 
		"_objective", 
		"_city", 
		"_numberofgroup", 
		"_numberofvehicle", 
		"_map", 
		"_position", 
		"_wccurrentmission", 
		"_marker", 
		"_count", 
		"_player", 
		"_score", 
		"_time", 
		"_day", 
		"_rain", 
		"_fog", 
		"_overcast"
	];

	waituntil {isnull wccam};
	wccam = "camera" camCreate [0,0,1000];
	wccam cameraEffect ["internal","back"];

	ShowCinemaBorder false;
	wccam camsettarget board;
	wccam camsetrelpos [-1, -3, 0.5];
	wccam CamCommit 0;
	wccameffect = PPEffectCreate ["ColorCorrections", 1999];
	wccameffect PPEffectEnable true;
	wccameffect PPEffectAdjust [0.5, 0.7, 0.0, [1.0, 1.0, 1.0, 0.0], [1.0, 1.0, 1.0, 0.0], [1.0, 1.0, 1.0, 1.0]];
	wccameffect PPEffectCommit 0;

	_score = score player;
	_count = 0;
	{
		if(isplayer _x) then {
			if(score _x > _score) then {
				_count = _count + 1;
			};
		};
	}foreach allunits;

	disableSerialization;
	_textbox = (uiNamespace getVariable 'wcdisplay') displayCtrl 1100;
	_map = (uiNamespace getVariable 'wcdisplay') displayCtrl 1307;

	_missionnumber = [];
	_name = [];
	_objective = [];
	_city = [];
	_numberofgroup = [];
	_numberofvehicle = [];
	_position = [];
	_time = [];
	_rain = [];
	_fog = [];
	_overcast = [];

	{
		_missionnumber = _missionnumber + [_x select 0];
		_name = _name + [_x select 1];
		lbAdd [1500, (_x select 1)];
		_objective = _objective + [_x select 2];
		_city = _city + [_x select 3];
		_numberofgroup = _numberofgroup + [_x select 4];
		_numberofvehicle = _numberofvehicle + [_x select 5];
		_position = _position + [_x select 6];
		_time = _time + [_x select 7];
		_rain = _rain + [_x select 8];
		_fog = _fog + [_x select 9];
		_overcast = _overcast + [_x select 10];
	}foreach wclistofmissions;
	lbSetCurSel [1500, 0];

	_marker = ['choosemission', 200, [0,0,0], 'ColorGREEN', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarkerlocal;

	if!((_count < 4) and (name player in wcinteam)) then {
		ctrlSetText [1600, localize "STR_ACGUI_MM_BTN_CLOSE"];
	};

	if!(wcadmin) then {
		ctrlShow [1601, false];
	};

	while {alive player && dialog} do {
		_index = lbCurSel 1500;
		_text = lbText [1500, _index];

		_hour = ((_time select _index) select 3);
		if(_hour < 10) then { _hour = format ["0%1", _hour];} else {_hour = format["%1", _hour];};
		_minute =  ((_time select _index) select 4);
		if(_minute < 10) then { _minute = format ["0%1", _minute];} else {_minute = format["%1", _minute];};
		_clock = format["%1:%2", _hour, _minute];

		if( ((_time select _index) select 3) < (date select 3)) then {_day= wcday + 1; } else {_day=wcday;};
		if( ((_time select _index) select 3) == (date select 3)) then { 
			if ( ((_time select _index) select 4) < (date select 4)) then { 
				_day = wcday + 1;
			} else { 
				_day = wcday;
			};
		};

		_text = _text + "\n\n" + format["\nDay: %1 Time: %2\n", _day, _clock] + format["Near: %1\n\n", (_city select _index)] + (_objective select _index) + format["\n\nOpposition forces:\n %1 groups \n %2 vehicles",(_numberofgroup select _index), (_numberofvehicle select _index)];

		ctrlSetText [1100, format["%1", _text]];
		//_textbox ctrlSetStructuredText parseText _text;
		_wccurrentmission = (_missionnumber select _index);
		_map ctrlMapAnimAdd [1, 0.5, (_position select _index)];
		_marker setmarkerposlocal (_position select _index);
		ctrlMapAnimCommit _map;
		sleep 0.5;
		ctrlMapAnimClear _map;

		if!(wcchoosemission) then {
			closedialog 0;
			menuaction = -1;
			deletemarkerlocal _marker;
			ppEffectDestroy wccameffect;
			wccam cameraEffect ["terminate","back"];
			camDestroy wccam;
			wccam = objNull;
		};

		if(menuaction == 1) then {
			deletemarkerlocal _marker;
			ppEffectDestroy wccameffect;
			wccam cameraEffect ["terminate","back"];
			camDestroy wccam;
			wccam = objNull;
			closedialog 0;
			menuaction = -1;
			if((_count < 4) and (name player in wcinteam)) then {
				["Headquarter radio", "Sending informations to headquarter...", "Wait during mission computation", 3] spawn WC_fnc_playerhint;
				sleep 3;
				wcaskformission = [player,_wccurrentmission];
				["wcaskformission", "server"] call WC_fnc_publicvariable;

				if(isserver) then {
					player removeaction wcchoosemissionmenu;
					wcchoosemissionmenu = nil;
				};
			} else {
				["Headquarter radio", "You can not talk with headquarter", "Be one of the three best team members to talk with headquarter", 10] spawn WC_fnc_playerhint;
			};
		};

		if(menuaction == 2) then {
			menuaction = -1;
			closedialog 0;
			wcrecomputemission = true;
			["wcrecomputemission", "server"] call WC_fnc_publicvariable;
		};
	};

	menuaction = -1;
	deletemarkerlocal _marker;
	ppEffectDestroy wccameffect;
	wccam cameraEffect ["terminate","back"];
	camDestroy wccam;
	wccam = objNull;