	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: compute list of missions of operation plan

	if (!isServer) exitWith{};

	private [
		"_count",
		"_countofmission",
		"_missionnumber", 
		"_name", 
		"_location", 
		"_city", 
		"_percent", 
		"_numberofgroup", 
		"_numberofvehicle", 
		"_position", 
		"_time", 
		"_month", 
		"_day", 
		"_hour", 
		"_minute",
		"_objects",
		"_vehicle",
		"_thislist",
		"_thisblacklist",
		"_counter",
		"_maxnumberofmission",
		"_year"
	];

	_thislist = [];

	_maxnumberofmission = 78;

	if(wclevel < 10) then {
		_countofmission = 1 + ceil(random 10);
	} else {
		_countofmission = 1;
	};

	for "_x" from 1 to _countofmission step 1 do {
		_thisblacklist = [];

		if(wckindofserver != 3) then {
			_numberofgroup = ceil (random (wclevelmaxincity));
			_numberofvehicle = ceil (random(wclevelmaxincity/2));
		} else {
			_numberofgroup = 20;
			_numberofvehicle = 10;
		};

		if(wcwithenemyvehicle == 0) then {
			_numberofvehicle = 0;
		};

		_position = position (wctownlocations call BIS_fnc_selectRandom);
		_position = [_position] call WC_fnc_relocateposition;
		while { ((_position distance getmarkerpos "respawn_west" < 1000) or (wclastmissionposition distance _position < 1500))} do {
			_position = position (wctownlocations call BIS_fnc_selectRandom);
			_count = count (nearestObjects [_position, ["House"] , 150]);
			if(_count > 0) then {
				_position = [_position] call WC_fnc_relocateposition;
			};
			sleep 0.05;
		};		

		// blacklist some missions if they are not in town
		_buildings = nearestObjects [_position, ["house"] , wcdistance];
		if (count _buildings < 20) then {
			_thisblacklist = [1,2,6,8,9,10,11,14,16,17,18,19,20,23,28,30,31,35,39,40,41,42,47,50,54,64,66,67,69,70];
		};

		if(wclevel < (wclevelmax - 1)) then {
			_missionnumber = floor(random _maxnumberofmission);
			while { ((_missionnumber in wcmissiondone) or (_missionnumber in _thislist) or (_missionnumber in _thisblacklist)) } do {
				_missionnumber = floor(random _maxnumberofmission);
			};
		} else {
			_missionnumber = 100;
		};
		_thislist = _thislist + [_missionnumber];

		// Compute name of mission
		_name = [] call WC_fnc_missionname;
		_objective = call compile format['localize "STR_WC_MISSION%1"', _missionnumber];

		// Compute a type vehicle for debug purpose
		wcmissionvehicle = wcvehicleslistEmission call BIS_fnc_selectRandom;

		switch (_missionnumber) do {	
			case 12: {
				_vehicle = wcallhangars call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 43: {
				_vehicle = wcallhangars call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 44: {
				_vehicle = wcallhangars call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 46: {
				_vehicle = wcallhangars call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 49: {
				_vehicle = wcallhangars call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 51: {

				_objective = format[localize "STR_WC_MISSION51", getText (configFile >> "CfgVehicles" >> wcmissionvehicle >> "DisplayName")];
				wcvehicleslistEmission = wcvehicleslistEmission - [_vehicle];
			};

			case 52: {
				_objective = format[localize "STR_WC_MISSION52", getText (configFile >> "CfgVehicles" >> wcmissionvehicle >> "DisplayName")];
				wcvehicleslistEmission = wcvehicleslistEmission - [_vehicle];
			};

			case 53: {
				_objective = format[localize "STR_WC_MISSION53", getText (configFile >> "CfgVehicles" >> wcmissionvehicle >> "DisplayName")];
				wcvehicleslistEmission = wcvehicleslistEmission - [_vehicle];
			};

			case 55: {
				_numberofgroup = 0; 
				_numberofvehicle = 0;
			};

			case 56: {
				_numberofgroup = 0; 
				_numberofvehicle = 0;
				_vehicle = wcallbaracks call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 58: {
				_vehicle = wcallhangars call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 59: {
				_vehicle = wcallhangars call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 60: {
				_vehicle = wcallhangars call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 61: {
				_vehicle = wcallhangars call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 62: {
				_vehicle = wcallhangars call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 63: {
				_numberofgroup = 0; 
				_numberofvehicle = 0;
				_vehicle = wcalloilpumps call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 65: {
				_vehicle = wcallfuelstations call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 71: {
				_vehicle = wcallhangars call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 72: {
				_vehicle = wcalloilpumps call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 77: {
				_numberofgroup = 0; 
				_numberofvehicle = 0;
				_vehicle = wcallcontroltowers call BIS_fnc_selectRandom;
				_position = position _vehicle;
			};

			case 100: {
				_numberofgroup = 16; 
				_numberofvehicle = 10;
			};
		};


		// To add before to check 
		// If mission can be done with SAFE ZONE
		if((_missionnumber == 58) or (_missionnumber == 59) or (_missionnumber == 60) or (_missionnumber == 61) or (_missionnumber == 62) or (_missionnumber == 71)) then {
			_done = true;
			_counter = 0;
			while { _done } do {
				_done = false;
				{
					if(_x distance _position < 1000) then {
						_done = true;
					};
				}foreach wcsecurezone;
				if(_done) then {
					_vehicle = wckindofhangars call BIS_fnc_selectRandom;
					_position = position _vehicle;
					_counter = _counter + 1;
					if(_counter > 10) then {
						_done = false;
						_missionnumber = floor(random _maxnumberofmission);
					};
				};
				sleep 0.1;
			};
		};

		// generate the mission date
		_time = [] call WC_fnc_newdate;

		_city = text (nearestLocation [_position, "NameCity"]);

		wclistofmissions = wclistofmissions + [[_missionnumber, _name, _objective, _city, _numberofgroup, _numberofvehicle, _position, _time]];
		diag_log format ["WARCONTEXT: MISSION LIST: %1", _missionnumber];
	};

	if(wckindofserver != 3) then {
		if(wcwithhq == 1) then {
			// players choose the mission
			["wclistofmissions", "client"] call WC_fnc_publicvariable;
		} else {
			// random mission pick
			wccurrentmission = wclistofmissions call BIS_fnc_selectRandom;
		};
	} else {
		wccurrentmission = wclistofmissions call BIS_fnc_selectRandom;
	};