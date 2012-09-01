		// -----------------------------------------------
		// Author: team  code34 nicolas_boiteux@yahoo.fr
		// WARCONTEXT - Description: Handler for all enemy units
		// -----------------------------------------------	

		private ["_group", "_mags"];

		_group = _this select 0;
		{
			wcgarbage = [_x, wcskill] spawn WC_fnc_setskill;

			_x setVehicleInit "this addAction ['<t color=''#ff4500''>Hands up</t>', 'warcontext\actions\WC_fnc_dohandsup.sqf',[],-1,false, true];";
			_x setVehicleInit "this addAction ['<t color=''#ff4500''>Follow me</t>', 'warcontext\actions\WC_fnc_dofollowme.sqf',[],-1,false, true];";

			if(vehicle _x == _x) then {
				wcunits = wcunits + [_x];
				_mags = [primaryweapon _x] call WC_fnc_weaponcanflare;
				if(_mags select 0) then {
					wcgarbage = [_x, _mags] spawn WC_fnc_fireflare;
				};
			} else {
				wcblinde = wcblinde + [_x];
			};
			
			_x addeventhandler ['killed', {
				private ["_name", "_increase"];
				_name = currentMagazine (_this select 1);
				_name = getText (configFile >> "CfgMagazines" >> _name >> "displayNameShort");
				_increase = ceil(random (5));
				if!(_name == "SD") then {
					if((wcalert + _increase) < 101) then {
						wcalert = wcalert + _increase;
					} else {
						wcalert = 100;
					};
				};
				wcgarbage = _this spawn WC_fnc_garbagecollector;
				wcnumberofkilledofmissionE = wcnumberofkilledofmissionE + 1;
				wcenemykilled =  wcenemykilled + 1;
				["wcenemykilled", "client"] call WC_fnc_publicvariable;
				_marker = [format["dead%1", wcenemykilled], 0.1, position (_this select 0), 'ColorRED', 'ICON', 'FDIAGONAL', 'Camp', 0, 'dead', false] call WC_fnc_createmarkerlocal;
				wcambiantmarker = wcambiantmarker + [_marker];
			}];
			_x addEventHandler ['Fired', '
				private ["_name", "_increase"];
				_name = currentMagazine (_this select 0);
				_name = getText (configFile >> "CfgMagazines" >> _name >> "displayNameShort");
				_increase = ceil(random (5));
				if!(_name == "SD") then {
					if((wcalert + _increase) < 101) then {
						wcalert = wcalert + _increase;
					} else {
						wcalert = 100;
					};
				};
			'];

			_x addEventHandler ['HandleDamage', {
				if(side(_this select 3) in [west, civilian]) then {
					private ["_name"];
					_name = currentMagazine (_this select 3);
					_name = getText (configFile >> "CfgMagazines" >> _name >> "displayNameShort");
					(_this select 0) removeAllEventHandlers "HandleDamage";
					if!(_name == "SD") then {
						(_this select 0) doTarget (_this select 3);
						(_this select 0) doFire (_this select 3);
						(_this select 0) reveal (_this select 3);
					};
					(_this select 0) setdamage (0.5 + (random 0.5));
				};
			}];

			_x addeventhandler ['FiredNear', {
				if(side(_this select 1) in [west, civilian]) then {
					private ["_name"];
					_name = currentMagazine (_this select 1);
					_name = getText (configFile >> "CfgMagazines" >> _name >> "displayNameShort");
					if!(_name == "SD") then {
						(_this select 0) doTarget (_this select 1);
						(_this select 0) reveal (_this select 1);
						(_this select 0) doFire (_this select 1);
						(_this select 0) setmimic "Agresive";
					};
				};
			}];
			sleep 0.1;
		} foreach (units _group);

		processInitCommands;