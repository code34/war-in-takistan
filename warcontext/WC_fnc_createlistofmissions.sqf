	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: compute all missions
	// locality: server side

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
		"_rain", 
		"_overcast", 
		"_fog", 
		"_month", 
		"_day", 
		"_hour", 
		"_minute",
		"_objects",
		"_vehicle",
		"_thislist",
		"_thisblacklist",
		"_counter",
		"_maxnumberofmission"
	];

	_thislist = [];

	switch (wcopposingforce) do {
		case 1: {
			wclevelmaxincity = 2;
		};

		case 2: {
			wclevelmaxincity = 4;
		};
		
		case 3: {
			wclevelmaxincity = 6;
		};

		case 4: {
			wclevelmaxincity = 8;
		};

		case 5: {
			wclevelmaxincity = 10;
		};
	};

	_maxnumberofmission = 75;

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

		// defend mission
		if((_missionnumber == 55) or (_missionnumber == 56)) then {_numberofgroup = 0; _numberofvehicle = 0;};

		if(_missionnumber == 56) then {
			_vehicle = (nearestObjects [getmarkerpos "respawn_west", ["Land_Mil_Barracks_i_EP1"], 20000]) call BIS_fnc_selectRandom;
			_position = position _vehicle;
		};

		if((_missionnumber == 58) or (_missionnumber == 59) or (_missionnumber == 60) or (_missionnumber == 61) or (_missionnumber == 62) or (_missionnumber == 71)) then {
			_vehicle = (nearestObjects [getmarkerpos "respawn_west", ["Land_Mil_hangar_EP1"], 20000]) call BIS_fnc_selectRandom;
			_position = position _vehicle;
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
					_vehicle = (nearestObjects [getmarkerpos "respawn_west", ["Land_Mil_hangar_EP1"], 20000]) call BIS_fnc_selectRandom;
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

		if((_missionnumber == 63) or (_missionnumber == 72)) then {
			_vehicle = (nearestObjects [getmarkerpos "respawn_west", ["Land_Ind_Oil_Pump_EP1"], 20000]) call BIS_fnc_selectRandom;
			_position = position _vehicle;
		};

		if(_missionnumber == 65) then {
			_vehicle = (nearestObjects [getmarkerpos "respawn_west", ["Land_Ind_FuelStation_Feed_EP1"], 20000]) call BIS_fnc_selectRandom;
			_position = position _vehicle;
		};

		if(_missionnumber == 100) then { _numberofgroup = 16; _numberofvehicle = 10; };

		_name = [] call WC_fnc_missionname;
		_objective = call compile format['localize "STR_WC_MISSION%1"', _missionnumber];

		// always compute a mission vehicle for debug purpose
		wcmissionvehicle = wcvehicleslistEmission call BIS_fnc_selectRandom;

		if(_missionnumber in [51,52,53]) then {
			wcvehicleslistEmission = wcvehicleslistEmission - [_vehicle];
			switch (_missionnumber) do {
				case 51: {
					_objective = format[localize "STR_WC_MISSION51", getText (configFile >> "CfgVehicles" >> wcmissionvehicle >> "DisplayName")];
				};
				case 52: {
					_objective = format[localize "STR_WC_MISSION52", getText (configFile >> "CfgVehicles" >> wcmissionvehicle >> "DisplayName")];
				};
				case 53: {
					_objective = format[localize "STR_WC_MISSION53", getText (configFile >> "CfgVehicles" >> wcmissionvehicle >> "DisplayName")];
				};
			};
		};

		_month = (date select 1);
		_day = (date select 2);
		_hour = floor(random 23);
		_minute = floor(random 59);

		if(_hour < (date select 3)) then { 
			if(_day < 31) then {
				_day = (date select 2) + 1;
			} else {
				_day = 1;
				_month = _month + 1;
			};
		} else {
			_day = (date select 2);
		};
		_time = [2011, _month, _day, _hour, _minute];

		_rain = random 0.65;
		if((_hour > 3) and (_hour <5)) then {
			_fog = 0.7 + random (0.3);
		} else {
			if((_hour > 4) and (_hour <6)) then {
				_fog = 0.5 + random (0.2);
			}else{
				_fog  = random 0.6;
			};
		};
		_overcast = random 1;	

		_city = text (nearestLocation [_position, "NameCity"]);

		wclistofmissions = wclistofmissions + [[_missionnumber, _name, _objective, _city, _numberofgroup, _numberofvehicle, _position, _time, _rain, _fog, _overcast]];
		diag_log format ["WARCONTEXT: MISSION LIST: %1", _missionnumber];
	};

	if(wckindofserver != 3) then {
		if(wcwithhq == 1) then {
			["wclistofmissions", "client"] call WC_fnc_publicvariable;
		} else {
			wccurrentmission = wclistofmissions call BIS_fnc_selectRandom;
		};
	} else {
		wccurrentmission = wclistofmissions call BIS_fnc_selectRandom;
	};