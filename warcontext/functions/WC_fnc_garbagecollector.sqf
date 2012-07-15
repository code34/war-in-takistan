	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - garbage collector - delete units when are die
	// -----------------------------------------------
	
	if (!isServer) exitWith{};

	private ["_unit"];

	_unit = _this select 0;

	if (_unit iskindof "Man") then {
		sleep wctimetogarbagedeadbody;
		hidebody _unit;
		sleep 3;
	} else {
		sleep wctimetorespawnvehicle;
	};

	deletevehicle _unit;
