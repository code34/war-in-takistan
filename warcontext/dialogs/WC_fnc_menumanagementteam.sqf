	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create a mission dialog box
	// locality : client side

	private [
		"_lastbody",
		"_missionnumber", 
		"_name", 
		"_textbox", 
		"_index", 
		"_rank",
		"_type",
		"_maxsize",
		"_unit",
		"_group",
		"_players",
		"_text",
		"_temp",
		"_rank",
		"_newplayers",
		"_originalteam",
		"_recruitmentlist"
	];

	_players = [];
	_temp = [];
	_newplayers = [];
	_recruitmentlist = [];
	_originalteam = wcinteam;

	// if noteam server
	if(wckindofserver == 3) exitwith {
		closedialog 0;
		wcgarbage = [localize "STR_WC_MENUTEAMMANAGEMENT", "Restart the game with team parameter ON to manage team", "There is no team", 10] spawn WC_fnc_playerhint;
	};

	waituntil {isnull wccam};
	wccam = "camera" camCreate [0,0,1000];
	wccam cameraEffect ["internal","back"];

	ShowCinemaBorder false;
	wccam camsettarget clothes;
	wccam camsetrelpos [-5, -10, 2.5];
	wccam CamCommit 0;
	wccameffect = PPEffectCreate ["ColorCorrections", 1999];
	wccameffect PPEffectEnable true;
	wccameffect PPEffectAdjust [0.5, 0.7, 0.0, [1.0, 1.0, 1.0, 0.0], [1.0, 1.0, 1.0, 0.0], [1.0, 1.0, 1.0, 1.0]];
	wccameffect PPEffectCommit 0;

	// only a trick to delete disconnect players
	{
		if(name _x in _originalteam) then {
			_temp = _temp + [name _x];
		};
	}foreach allunits;
	_originalteam = _temp;

	disableSerialization;
	_textbox = (uiNamespace getVariable 'wcdisplay') displayCtrl 6001;

	{
		if((isplayer _x) and !(name _x in _originalteam) and (side _x == west))then {
			_players = _players + [_x];
		};
	}foreach allunits;

	{
		lbAdd [6002, name _x];
	}foreach _players;
	lbSetCurSel [6002, 0];

	if!(wcadmin) then {
		ctrlShow [6004, false];
		ctrlShow [6001, false];
		ctrlShow [6002, false];
		ctrlShow [6005, false];
	};

	while {alive player && dialog} do {
		_text = format["MEMBERS OF TEAM v%1<br/>", wcversion];
		_kindofgame = if(wckindofgame == 1) then {"arcade";}else{"simulation";};
		_text = _text + localize format["STR_WC_TEAM%1", wcteamlevel] + "<br/>" + format["%1", _kindofgame] + " game" + "<br/>" + format["Day:%1 EKilled:%2 Lvl:%3 Mission:%4 Team score:%5", wcday, wcenemykilled, wclevel, wcmissioncount - wclevel, wcteamscore] + "<br/><br/>";
		_text = _text + format["Members of team: %1<br/>", count _originalteam];

		{	
			_rank = _x;
			{
				if((name _x in _originalteam) and (_rank == rank _x) and !(name _x in _recruitmentlist)) then {
					if(!(format["%1", name _x] == "") and !(format["%1", name _x] == "Error: No unit")) then {
						lbAdd [6008, name _x];
						_recruitmentlist = _recruitmentlist + [name _x];
					};
				};
			}foreach playableUnits;
		} foreach ["Colonel", "Major", "Captain", "Lieutenant", "Sergeant", "Corporal", "Private"];
	
		_ctrl = (uiNamespace getVariable 'wcdisplay') displayCtrl 6003;
		_ctrl ctrlSetStructuredText parseText _text;

		_index = lbCurSel 6002;
		_type = lbText [6002, _index];
		if(menuaction == 1) then {
			if(wcadmin) then {
				menuaction = -1;
				if (_type == "") exitwith {};
				_originalteam = _originalteam + [_type];
				_newplayers = _newplayers + [_type];
				lbClear 6002;
				_players = [];
				{
					if((isplayer _x) and !(name _x in _originalteam))then {
						_players = _players + [_x];
					};
				}foreach allunits;
			
				{
					lbAdd [6002, name _x];
				}foreach _players;
			} else {
				closedialog 0;
			};
		};

		if(menuaction == 2) then {
			if(wcadmin) then {
				menuaction = -1;
				_index = lbCurSel 6008;
				_type = lbText [6008, _index];
				lbDelete [6008, _index];
				lbAdd [6002, _type];
				if (_type == "") exitwith {};
				_originalteam = _originalteam - [_type];
				_recruitmentlist = _recruitmentlist - [_type];
			} else {
				closedialog 0;
			};
		};
		sleep 0.1;
	};

	if !(wcadmin) then {
		wcgarbage = [localize "STR_WC_MENUTEAMMANAGEMENT", "Log you as server admin", "You can not recruit team members", 10] spawn WC_fnc_playerhint;
	} else {
		wcinteam = _originalteam;
		["wcinteam", "all"] call WC_fnc_publicvariable;
		{
			wcinteamintegration = _x;
			["wcinteamintegration", "client"] call WC_fnc_publicvariable;
			sleep 1;
		}foreach _newplayers;
	};

	ppEffectDestroy wccameffect;
	wccam cameraEffect ["terminate","back"];
	camDestroy wccam;
	wccam = objNull;