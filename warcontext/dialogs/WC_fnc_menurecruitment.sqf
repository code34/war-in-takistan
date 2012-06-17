	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create a recruitment dialog box
	// locality : client side

	private [
		"_array",
		"_missionnumber", 
		"_name", 
		"_textbox", 
		"_index", 
		"_rank",
		"_type",
		"_maxsize",
		"_unit"
	];

	if!(isformationleader player) exitwith {
		[localize "STR_WC_MENURECRUITMENT", "You are not leader of your group", "Create a new group", 10] spawn WC_fnc_playerhint;
		closedialog 0;
	};

	if!(name player in wcinteam) exitwith {
		[localize "STR_WC_MENURECRUITMENT", "Only members of team can recruit", "Wait to be recruit as team member", 10] spawn WC_fnc_playerhint;
		closedialog 0;
	};

	if(wcrecruitberanked == 1) then {
		_rank = rank player;
		if(_rank == "Private") then { _maxsize = 1;};
		if(_rank == "Corporal") then { _maxsize = 2;};
		if(_rank == "Sergeant") then { _maxsize = 3;};
		if(_rank == "Lieutenant") then { _maxsize = 4;};
		if(_rank == "Captain") then { _maxsize = 5;};
		if(_rank == "Major") then { _maxsize = 6;};
		if(_rank == "Colonel") then { _maxsize = 7;};
	} else {
		_maxsize = 64;
	};

	disableSerialization;
	_textbox = (uiNamespace getVariable 'wcdisplay') displayCtrl 4001;

	_array = [];
	{
		if ((_x select 0) == faction player) then {
			_name = gettext (configfile >> "cfgVehicles" >> (_x select 1) >> "Displayname");
			_index = lbAdd [4002, _name];
			_array set [_index, (_x select 1)];
		};
	}foreach (wcwestside select 1);
	lbSetCurSel [4002, 0];

	ctrlSetText [4005, format["Recruitment avalaible: %1 soldiers", (_maxsize - count (units(group player)))]];

	while {alive player && dialog} do {
		_index = lbCurSel 4002;
		_type = _array select _index;
		if(menuaction == 1) then {
			if(count(units (group player)) < _maxsize) then {
				_unit = (group player) createUnit [_type, position player, [], 0, "FORM"];
				[localize "STR_WC_MENURECRUITMENT", "Manage your squad", format["%1 joined your squad", name _unit], 2] spawn WC_fnc_playerhint;
				[_unit] joinSilent (group player);
				_unit addeventhandler ['killed', {
					_this spawn WC_fnc_garbagecollector;
					wcaddkilled = _unit;
					["wcaddkilled", "server"] call WC_fnc_publicvariable;
				}];
				if(_type in wcmedicclass) then {
					wcgarbage = [_unit] spawn WC_fnc_createmedic;
				};
			} else {
				if(random 1 > 0.02) then {
					[localize "STR_WC_MENURECRUITMENT", "You are not enough ranked to give some orders", "Increase your rank by winning points", 10] spawn WC_fnc_playerhint;
				} else {
					[localize "STR_WC_MENURECRUITMENT", "Ok, recruiter give you one men because you are a friend", "Increase your rank by winning points", 10] spawn WC_fnc_playerhint;
					sleep 10;
					_unit = (group player) createUnit [_type, position player, [], 0, "FORM"]; 
					[_unit] joinSilent (group player);
					_unit addeventhandler ['killed', {
						_this spawn WC_fnc_garbagecollector;
						wcaddkilled = _unit;
						["wcaddkilled", "server"] call WC_fnc_publicvariable;
					}];
					if(_type in wcmedicclass) then {
						wcgarbage = [_unit] spawn WC_fnc_createmedic;
					};
				};
			};
			menuaction = -1;
		};
		if(menuaction == 2) then {
			ppEffectDestroy wccameffect;
			wccam cameraEffect ["terminate","back"];
			camDestroy wccam;
			wccam = objNull;
			closedialog 0;
			menuaction = -1;
		};
		sleep 0.5;
	};

	ppEffectDestroy wccameffect;
	wccam cameraEffect ["terminate","back"];
	camDestroy wccam;
	wccam = objNull;