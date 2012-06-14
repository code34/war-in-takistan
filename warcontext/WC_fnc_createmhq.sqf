	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  Create a Mobil HQ near zone
	
	private [
		"_position",
		"_marker",
		"_locationsneartarget",
		"_location"
	];

	_position = _this select 0;

	_locationsneartarget = nearestLocations [_position, ["NameCityCapital", "NameCity","NameVillage", "Name", "Hill", "Mount"], 700];

	sleep 1;
	
	_location = _locationsneartarget  call BIS_fnc_selectRandom;
	while { _location distance _position < 500 } do {
		_location = _locationsneartarget  call BIS_fnc_selectRandom;
		sleep 0.5;
	};
	_position = (position _location) findemptyposition [10, 200];

	deletevehicle wcteleport;
	wcteleport = "M1130_HQ_unfolded_Base_EP1" createVehicle _position;
	wcteleport setvehicleinit "this allowdammage false; this setfuel 0; wcobject = this addAction ['Teleport to base', 'warcontext\WC_fnc_returntobase.sqf',[],-1,false]; wcplayerbox = this addAction ['Drop an Ammobox', 'warcontext\actions\WC_fnc_docreateammobox.sqf',[],-1,false]; wcobject2 = this addAction ['Build a vehicle', 'warcontext\dialog\WC_fnc_createmenubuildvehicles.sqf',[],-1,false]; ";
	processInitCommands;

	["wcteleport", "client"] call WC_fnc_publicvariable;

	wchintW = localize "STR_WC_MESSAGEMHQDEPLOYED";
	["wchintW", "client"] call WC_fnc_publicvariable;

	deletemarker "teleporthq";	
	_marker = ['teleporthq', 0.5, _position, 'ColorGreen', 'ICON', 'FDIAGONAL', 'Headquarters', 0, '', false] call WC_fnc_createmarker;

	