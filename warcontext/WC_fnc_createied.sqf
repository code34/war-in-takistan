	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// IED - WARCONTEXT

	private [
		"_unit", 
		"_enemys", 
		"_enemy", 
		"_missioncomplete", 
		"_count"
	];

	#include "common.hpp"

	_unit = _this select 0;
	_unit setvariable ["wciedactivate", true, true];

	if(format["%1", _unit] == "any") exitWith{};

	_missioncomplete = false;
	_enemys = [];

	_unit setVehicleInit "this addAction ['<t color=''#ff4500''>Disarm IED</t>', 'warcontext\WC_fnc_disarmied.sqf',[],-1,false];";
	_unit allowFleeing 0;

	processInitCommands;

	_count = 0;
	while {!_missioncomplete} do {
		_count = _count + 1;
		if(alive _unit) then {
			_enemys = nearestObjects[_unit,["Man", "LandVehicle"], 20];
			if(count _enemys > 0) then {
				{
					_enemy = _x;
					if(((_enemy distance _unit) < 8) and ((side _enemy) in wcside) and (!(typeOf _enemy in wcengineerclass) or (_unit isKindOf "Man") or ((_enemy iskindof "LandVehicle") and (count (crew _enemy) > 0) and (side (driver _enemy) in wcside))) and !(_missioncomplete)) then {
						_position = position _unit;
						"ARTY_R_227mm_HE" createVehicle [_position select 0, _position select 1, 0];
						"Bo_GBU12_LGB" createVehicle [_position select 0, _position select 1, 0];
						if(_enemy iskindof "LandVehicle") then {
							{					
								_x setdamage 1;
							}foreach crew _enemy;
						};
						if(_unit isKindOf "Man") then {
							wcallahsound = name _enemy;
							["wcallahsound", "client"] call WC_fnc_publicvariable;
							playsound "allah";
							if(_enemy iskindof "LandVehicle") then {
								wchintW = "A bomber man has explosed near friendly vehicle";
							} else {
								wchintW = format[localize "STR_WC_MESSAGEANBOMBERMANEXPLOSION", name _enemy];						
							};
						} else {
							if(_enemy iskindof "LandVehicle") then {
								wchintW = localize "STR_WC_MESSAGEANIEDEXPLOSIONNEARVEHICLE";
							} else {
								wchintW = format[localize "STR_WC_MESSAGEANIEDEXPLOSION", name _enemy];
							};
						};
						["wchintW", "client"] call WC_fnc_publicvariable;
						hintsilent wchintW;
						_missioncomplete = true;
						_unit setvariable ["wciedactivate", false, true];
						_unit setdamage 1;
					};
				}foreach _enemys;
			};
			if(_unit isKindOf "Man") then {
				if(_count > 30) then {
					_position = position (_unit findNearestEnemy position _unit);
					if(format["%1", _position] != "[0,0,0]") then {
						_unit domove _position;
					};
					_count = 0;
				};
			};
		};
		if(isnull _unit) then {
			_missioncomplete = true;
		};
		if!(alive _unit) then {
			_missioncomplete = true;
		};
		if!(_unit getvariable "wciedactivate") then {
			_missioncomplete = true;
		};
		sleep 1;
	};