	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext : unlock vehicle for engineer
	// -----------------------------------------------
	 private [
		"_position", 
		"_object", 
		"_typeof", 
		"_list", 
		"_dir", 
		"_mydir", 
		"_dammage", 
		"_name",
		"_text"
	];

	_mydir = getdir player;
	_list = nearestObjects [position player, ["LandVehicle", "Air", "Tank", "Car"], 8];

	if(count _list == 0) exitwith {hintsilent localize "STR_WC_MESSAGENOVEHICLENEARYOU";};

	_object = _list select 0;

	if(locked _object) then {
		_name= getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "DisplayName");
		_text = format[localize "STR_WC_MESSAGEUNLOCKING", _name];

		wcgarbage = [format["Unlock Vehicle: %1", _name], _text, "", 8] spawn WC_fnc_playerhint;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 8;

		if!(alive player) exitwith {};
		_text = format[localize "STR_WC_MESSAGEISUNLOCKED", _name];
		wcgarbage = [format["Unlock Vehicle: %1", _name], _text, "", 3] spawn WC_fnc_playerhint;
		_object setVehicleInit "this lock false;";
		processInitCommands;
	} else {
		_name= getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "DisplayName");
		_text = format[localize "STR_WC_MESSAGELOCKING", _name];

		wcgarbage = [format["Lock Vehicle: %1", _name], _text, "", 8] spawn WC_fnc_playerhint;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 8;

		if!(alive player) exitwith {};
		_text = format[localize "STR_WC_MESSAGEISLOCKED", _name];
		wcgarbage = [format["Lock Vehicle: %1", _name], _text, "", 3] spawn WC_fnc_playerhint;
		_object setVehicleInit "this lock true;";
		processInitCommands;
	};
