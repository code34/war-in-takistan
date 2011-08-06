	// Terrain following radar
	// Simple version build 006 (1 scan point ahead)
	if (!isServer) exitWith{};
	
	private ["_vehicle","_lolimit","_scanner","_tfrlevel","_mydir","_myspeed","_mylevel"];
	
	_vehicle = _this select 0;
	_lowlimit = 60;
	_scanner = "HeliHEmpty" createvehicle (getpos _vehicle);

	_vehicle addEventHandler ["Gear", "
		if (_this select 1) then {
			(_this select 0) setVariable ['wclanding', true, false];
		} else {
			(_this select 0) setVariable ['wclanding', false, false];
		};
	"];

	
	while { canmove _vehicle && getdammage _vehicle < 0.9} do {
		if (isPlayer (driver _vehicle)) then { waituntil{!isPlayer (driver _vehicle)}; };
		if (_vehicle getVariable "wclanding") then { waituntil{!(_vehicle getVariable "wclanding")}; };
		if (abs(speed _vehicle) > 30) then {
			_mylevel = (getposATL _vehicle) select 2;
			_mydir = getdir _vehicle;
			_myspeed = speed _vehicle;
			_scanner setpos [(getpos _vehicle select 0) + (sin _mydir * _myspeed), (getpos _vehicle select 1) + (cos _mydir * _myspeed),_mylevel];
			_tfrlevel = (getposATL _scanner) select 2;
			IF (_tfrlevel < _lowlimit) then {_vehicle setVelocity [velocity _vehicle select 0, velocity _vehicle select 1, (velocity _vehicle select 2) + (_lowlimit - _tfrlevel)]};
		};
		sleep 0.5;
	};
	deleteVehicle _scanner;

	true;