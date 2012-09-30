	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - create propagander in towns

	if (!isServer) exitWith{};

	private [
		"_conversion", 
		"_group", 
		"_men", 
		"_missioncomplete", 
		"_needpropagander",
		"_position",
		"_positions",
		"_unit"
	];

	_unit = _this select 0;
	_needpropagander = true;

	{
		if(_x distance _unit < 500) then {
			_needpropagander = false;
		};
		if(isnull _x) then { wcpropagander = wcpropagander - [_x]; };
	}foreach wcpropagander;

	if (!_needpropagander) exitWith{};

	_men = nearestObjects[_unit,["Man"], 400];
	if(count _men == 0) exitwith {};

	wcpropagander = wcpropagander + [_unit];

	diag_log format["WARCONTEXT: BUILD 1 PROPAGANDER - fame: %1", wcfame];

	_position = (position _unit) findEmptyPosition [8, 100];
	if(count _position == 0) then {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR PROPAGAND CIVILIAN";
	} else {
		_unit setpos _position;
	};

	_unit setvariable ["wcprotected", true];
	_unit stop true;
	_unit disableAI "MOVE";

	_conversion = 0;
	_missioncomplete = false;

	while {((alive _unit) and (_conversion < 1000) and (!_missioncomplete))} do {
		_men = nearestObjects[_unit,["Man"], 400];
		_men = _men - [_unit];
		if(count _men > 1) then {
			_positions = [position _unit, 5, 360, getdir _unit, 5] call WC_fnc_createcircleposition;
			_unit stop true;
			{
				if(side _x == civilian) then {
					if(_x distance _unit > 7) then {
						_position = _positions call BIS_fnc_selectRandom;
						_x stop false;
						_x domove _position;
						_x setvariable ["destination", _position, false];
						_x setvariable ["civilrole", "converting", true];
					} else {
						_x dowatch _unit;
						_x setUnitPos "Up";
						_x setvariable ["civilrole", "converted", true];
						_x stop true;
						_conversion = _conversion + 1;
					};
					_unit setvariable ["convertingrate", _conversion, false];
				} else {
					_men = _men - [_x];
				};
				if(isplayer _x) then {
					_men = _men - [_x];
				};
			}foreach _men;		
		};
		if((getmarkerpos "jail") distance _unit < 50) then {
			wcmessageW = ["Propagand", "A prisonner is in jail"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; };
			_unit setpos getmarkerpos "jail";
			[_unit] joinSilent group prisoner;
			_unit allowdammage false;
			_unit setUnitPos "Up"; 
			_unit playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
			_unit stop true;
			_unit disableAI "MOVE";
			_unit disableAI "ANIM";
			wcfame = wcfame + 0.1;
			_missioncomplete = true;
			_conversion = 0;
		};
		sleep 0.5;
	};

	// if converted success
	// create a resistance group with weapons
	if(!(_missioncomplete) and (alive _unit)) then {
		_unit stop false;
		_unit setvariable ["civilrole", "converted", true];

		_group = creategroup east;
		_men = nearestObjects [_unit,["Man"], 30];

		{
			if((_x getvariable "civilrole" == "converted") and !(isplayer _x)) then {
				if!((typeof _x) in wccivilwithoutweapons) then {
					_x stop false;
					removeallweapons _x;
					_x addEventHandler ['Fired', '(_this select 0) setvehicleammo 1;'];
					_x removeAllEventHandlers "killed";
					_x removeAllEventHandlers "FiredNear";
					_x addweapon "AKS_74";
					_x addmagazine "30Rnd_545x39_AK";
				} else {
					_civilrole = ["bomberman","propagander","altercation","saboter","builder","healer"] call BIS_fnc_selectRandom;
					_x setvariable ["civilrole", _civilrole, true];
					_men = _men - [_x];
				};
			} else {
				_men = _men - [_x];
			};
		} foreach _men;

		_men joinSilent _group;
		wcgarbage = [_group] spawn WC_fnc_grouphandler;
		wcgarbage = [_group, 300] spawn WC_fnc_patrol;
	};