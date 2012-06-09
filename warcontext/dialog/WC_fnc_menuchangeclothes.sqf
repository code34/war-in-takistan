	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - change clothes ingame
	// locality : client side

	private [
		"_array",
		"_count",
		"_lastbody",
		"_missionnumber", 
		"_name", 
		"_textbox", 
		"_index", 
		"_rank",
		"_type",
		"_maxsize",
		"_unit",
		"_group"
	];

	if(wcoriginalclothes != typeof player) exitwith {
		_lastbody = player;
		[_lastbody] spawn WC_fnc_garbagecollector;
		_lastbody removeAllEventHandlers "killed";
		_lastbody setpos [0,0,0];
		wcbackupbody setpos wcbackupposition;
		selectplayer wcbackupbody;
		_lastbody setdamage 1;
		ppEffectDestroy wccameffect;
		wccam cameraEffect ["terminate","back"];
		camDestroy wccam;
		wccam = objNull;
		closedialog 0;
		menuaction = -1;
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

	disableSerialization;
	_textbox = (uiNamespace getVariable 'wcdisplay') displayCtrl 5001;

	_array = [];
	
	_civil = wcchangeclothes;
	{
		_name = gettext (configfile >> "cfgVehicles" >> _x >> "Displayname");
		_index = lbAdd [5002, _name];
		_array set [_index, _x];
	}foreach _civil;

	lbSetCurSel [5002, 0];

	ctrlSetText [5005, "Change clothes"];

	while {alive player && dialog} do {
		_index = lbCurSel 5002;
		_type = _array select _index;
		if(menuaction == 1) then {
			ppEffectDestroy wccameffect;
			wccam cameraEffect ["terminate","back"];
			camDestroy wccam;
			wccam = objNull;
			closedialog 0;
			menuaction = -1;

			[] call WC_fnc_saveloadout;

			if(_type in wcchangeclothescivil) then {
				_group = creategroup civilian;
			};

			if(_type in wcchangeclotheswest) then {
				_group = creategroup west;
			};

			if(_type in wcchangeclotheseast) then {
				_group = creategroup east;
			};

			_unit = _group createUnit [_type, position player, [], 0, "FORM"];
			_unit disableAI "AUTOTARGET";
			_unit disableAI "TARGET";
			_unit disableAI "MOVE";	
			_unit disableAI "ANIM";	

			wcbackupbody = player;
			wcbackupposition = position player;
			wcbackupbody setpos [0,0,0];

			_unit addeventhandler ['killed', {
				_this spawn WC_fnc_garbagecollector;
				wcbackupbody setpos wcbackupposition;
				selectplayer wcbackupbody;

				if(rank player == "Private") then {
					wcplayeraddscore = [player, -7];
					["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
				};
				if(rank player == "Corporal") then {
					wcplayeraddscore = [player, -6];
					["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
				};
				if(rank player == "Sergeant") then {
					wcplayeraddscore = [player, -5];
					["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
				};
				if(rank player == "Lieutenant") then {
					wcplayeraddscore = [player, -4];
					["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
				};
				if(rank player == "Captain") then {
					wcplayeraddscore = [player, -3];
					["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
				};
				if(rank player == "Major") then {
					wcplayeraddscore = [player, -2];
					["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
				};
				if(rank player == "Colonel") then {
					wcplayeraddscore = [player, -1];
					["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
				};
				wcaddscore = -1;
				["wcaddscore", "server"] call WC_fnc_publicvariable;
			}];
			selectPlayer _unit;

			wcgarbage = [] spawn WC_fnc_playerhandler;

			wcgarbage = [] spawn WC_fnc_restoreactionmenu;

			wcgarbage = [] spawn WC_fnc_restoreloadout;

			if(count (units (group player)) > 0) then {
				_count = 0;
				{
					if(isplayer _x) then {
						_count = _count + 1;
					};
				}foreach (units (group player));
				if(_count == 1) then {
					group player selectLeader player; 
				};
			};
		};
		sleep 1;
	};

	ppEffectDestroy wccameffect;
	wccam cameraEffect ["terminate","back"];
	camDestroy wccam;
	wccam = objNull;

	if!(isnil "_unit") then {
		_detected = false;
		while { ((alive _unit) and !(_detected)) } do {
			_enemys = nearestObjects[_unit,["Man"], 10];
			{		
				if((side _x) in wcenemyside) then {
					_detected = true;
				};
			}foreach _enemys;
			sleep 2;
		};
			
		if((_detected) and (alive _unit)) then {
			_group = creategroup west;
			[player] joinsilent _group;
			hintsilent localize "STR_WC_MESSAGEABEENDETECTED";
		};
	};