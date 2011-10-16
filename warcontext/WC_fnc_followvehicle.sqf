	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - follow vehicle on map which have a name

	private [
		"_arrayofmarker",
		"_arrayofvehicle", 
		"_arrayofvehicle2",
		"_x", 
		"_marker",
		"_markername", 
		"_position", 
		"_counter"
	];

	_arrayofmarker = [];

	WC_fnc_refreshvehiclelist = {
		private [
			"_arrayofvehicle", 
			"_arrayofvehicle2", 
			"_varname"
		];

		_arrayofvehicle2 = [];
		_arrayofvehicle = nearestObjects[position player,["Air", "LandVehicle"], 20000];
		{
			if!( _x iskindof "StaticWeapon") then {
				_varname = vehiclevarname _x;
				if!(_varname == "") then {
					_name = getText (configFile >> "CfgVehicles" >> (typeOf (_x)) >> "DisplayName");
					_arrayofvehicle2 = _arrayofvehicle2 + [[_x, _varname, _name]];
				};
			};
		}foreach _arrayofvehicle;
		_arrayofvehicle2;
	};

	_arrayofvehicle = [] call WC_fnc_refreshvehiclelist;
	{
		_marker = [(_x select 1), 2, [0,0,0], 'ColorGreen', 'ICON', 'FDIAGONAL', 'Vehicle', 0, '', true] call WC_fnc_createmarkerlocal;
		_arrayofmarker = _arrayofmarker + [_marker];
	}foreach _arrayofvehicle;

	_counter = 0;
	while {true} do {
		{
			if (alive (_x select 0)) then {
				_markername = _x select 1;
				_position = getpos (_x select 0);
				_markername setmarkerposlocal _position;
				_markername setmarkertextlocal (_x select 2);
				_markername setMarkerColorLocal "ColorGREEN";
				_markername setmarkertype "Vehicle";
			}else{
				_markername = _x select 1;
				_position = getpos (_x select 0);
				_markername setmarkerposlocal _position;
				_markername setmarkertextlocal (_x select 2);
				_markername setMarkerColorLocal "ColorRED";
				_markername setmarkertype "DestroyedVehicle";
			};
		}foreach _arrayofvehicle;
		_counter = _counter + 1;
		if(_counter > 60) then {
			_arrayofvehicle = [] call WC_fnc_refreshvehiclelist;
			{
				deletemarkerlocal _x;
			} foreach _arrayofmarker;
			_arrayofmarker = [];
			{
				_marker = [(_x select 1), 2, [0,0,0], 'ColorGreen', 'ICON', 'FDIAGONAL', 'Vehicle', 0, '', true] call WC_fnc_createmarkerlocal;
				_arrayofmarker = _arrayofmarker + [_marker];
			}foreach _arrayofvehicle;
			_counter = 0;
		};
		sleep 0.5;
	};