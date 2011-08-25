	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// create an US ammobox on local client side
	// -----------------------------------------------

	#include "common.hpp"

	 private [
		"_base",
		"_crate",
		"_position",
		"_amountWeapon",
		"_amountAmmo",
		"_listofweapons",
		"_refreshTime",
		"_magazines",
		"_weapons",
		"_autoload"
	];

	_position = _this select 0;
	_autoload = _this select 1;

	_crate = "TKVehicleBox_EP1" createVehiclelocal _position;

	clearweaponcargo 	_crate;
	clearmagazinecargo 	_crate;
	_crate setpos _position;
	wcammoboxindex = wcammoboxindex  + 1;
	wcgarbage = [format['wcammobox%1', wcammoboxindex], 0.5, _position, 'ColorYellow', 'ICON', 'FDIAGONAL', 'Select', 0, 'Ammobox', true] call WC_fnc_createmarkerlocal;

	_weapons = [];
	_magazines = [];

	_amountweapon = 2;
	_amountammo = 20;

	_refreshtime = 1800; 
	_crate allowDamage false;

	while {true} do {
		clearweaponcargo 	_crate;
		clearmagazinecargo 	_crate;	

		{_crate addWeaponCargo [_x, _amountweapon];} forEach wclistofweapons;

		switch (_autoload) do {
			case "addons": {
				_magazines = [wclistofweapons] call WC_fnc_enummagazines;
			};

			default {
				_magazines = [wclistofweapons + ["Throw", "Put"]] call WC_fnc_enummagazines;
			};
		};

		{ _crate addMagazineCargo [_x, _amountammo];} foreach _magazines;
		
		sleep _refreshtime;
	};