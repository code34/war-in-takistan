	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext : repair vehicle for engineer
	// -----------------------------------------------

	 private [
		"_position", 
		"_object", 
		"_typeof", 
		"_list", 
		"_dir", 
		"_mydir", 
		"_dammage", 
		"_name"
	];

	_mydir = getdir player;
	_list = nearestObjects [position player, ["LandVehicle", "Air", "Tank", "Car"], 8];

	if(count _list == 0) exitwith {
		[localize "STR_WC_MENUREPAIRVEHICLE2", localize "STR_WC_MESSAGENOVEHICLENEARYOU", localize "STR_WC_MESSAGEGOCLOSERREPAIR", 3] spawn WC_fnc_playerhint;
	};

	player playMove "AinvPknlMstpSlayWrflDnon_medic";

	_object = _list select 0;

	if (getdammage _object > 0.90) then {
		[localize "STR_WC_MENUREPAIRVEHICLE2", localize "STR_WC_MESSAGECANNOTREPAIR", "", 3] spawn WC_fnc_playerhint;
	} else {
		_name= getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "DisplayName");
		[format[localize "STR_WC_MENUREPAIRVEHICLE2", _name], "You are repairing vehicle", "", 6] spawn WC_fnc_playerhint;
		sleep 6;
		if!(alive player) exitwith {};
		_object setdamage (getdammage _object - 0.1);
		_text = format["Still %1 of dammage.", format["%1", ceil ((getdammage _object)*100)]+"%"];
		[format[localize "STR_WC_MENUREPAIRVEHICLE2", _name], _text, "", 3] spawn WC_fnc_playerhint;
	};

	true;
