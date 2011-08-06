	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description: Do random weather 
	// locality: server side
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private ["_rain", "_fog", "_overcast", "_datestamp"];

	while {true} do {
		_rain = random 0.65;
		if((date select 3 > 2) and (date select 3 < 5)) then {
			_fog = 0.9 + random (0.3);
		} else {
			if((date select 3 > 3) and (date select 3 <6)) then {
				_fog = 0.8 + random (0.3);
			}else{
				_fog  = random 0.6;
			};
		};
		_overcast = random 1;
		wcweather = [_rain, _fog, _overcast];
		["wcweather", "client"] call WC_fnc_publicvariable;
		600 setRain (wcweather select 0);
		600 setfog (wcweather select 1);
		600 setOvercast (wcweather select 2);
		sleep 600;
	};