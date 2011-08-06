	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - create propagander in towns
	// propagander give weapons to civilians
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private [
		"_positions", 
		"_unit", 
		"_circle", 
		"_conversion", 
		"_count", 
		"_group", 
		"_limitofsizeofgroup",
		"_men", 
		"_missioncomplete", 
		"_position", 
		"_counter", 
		"_maxconversion", 
		"_needpropagander"
	];

	_unit = _this select 0;
	_needpropagander = true;

	// Limit the number of civilians around civilians
	_limitofsizeofgroup = ceil (random 10);

	{
		if(_x distance _unit < 5000) then {
			_needpropagander = false;
		};
		if(isnull _x) then { wcpropagander = wcpropagander - [_x]; };
	}foreach wcpropagander;

	if (!_needpropagander) exitWith{};

	diag_log format["WARCONTEXT: BUILD 1 PROPAGANDER - fame: %1", wcfame];

	wcpropagander = wcpropagander + [_unit];

	_unit allowfleeing 0;
	_position = (position _unit) findEmptyPosition [8, 100];
	_unit setpos _position;
	_unit setvariable ["wcprotected", true];
	_unit setVehicleInit "this disableAI ""MOVE"";this addAction ['<t color=''#ff4500''>Follow me</t>', 'warcontext\WC_fnc_followme.sqf',[],-1,false, true];";
	processInitCommands;

	_circle = 100;
	_conversion = 0;
	_missioncomplete = false;
	_counter = 0;
	_maxconversion = 150 + (wcfame * 100);

	while { ((_conversion < _maxconversion) and (alive _unit))} do {
		_maxconversion = 150 + (wcfame * 100);
		_counter = _counter + 1;
		if(_counter > 30) then {
			_men = nearestObjects[_unit,["Man"], 10];
			if(count _men < _limitofsizeofgroup) then {
				_counter = 0;			
				_men = nearestObjects[_unit,["Man"], _circle];
				_circle = 100;
				if(count _men > 1) then {
					_positions = [position _unit, 5, 360, getdir _unit, 5] call WC_fnc_docircle;
					dostop _unit;
					{
						if(format["%1", _x getvariable "wchostage"] == "<null>") then {
							if(side _x == civilian) then {
								_circle = _circle + 5;
								if(_x distance _unit > 5) then {
									_x domove (_positions call BIS_fnc_selectRandom);
								} else {
									dostop _x;
									_x dowatch _unit;
									_X setUnitPos "Up";
								};
							} else {
								_men = _men - [_x];
							};
							if(isplayer _x) then {
								_men = _men - [_x];
							};
						};
					}foreach _men;
					_count = count _men;		
					_conversion = _conversion + _count;
				};
			};
		};
		if((getmarkerpos "respawn_west") distance _unit < 100) then {
			wcmessageW = ["Propagand", "A prisonner is in jail"];
			if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; };
			_unit setpos getmarkerpos "jail";
			[_unit] joinSilent group prisoner;
			_unit allowdammage false;
			_unit setUnitPos "Up"; 
			dostop _unit;
			_unit playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
			_unit disableAI "MOVE";
			_unit disableAI "ANIM";
			wcfame = wcfame + 0.1;
			_missioncomplete = true;
			_conversion = 300;
		};
		sleep 1;
	};

	wcpropagander = wcpropagander - [_unit];

	if!(_missioncomplete) then {
		_unit setVehicleInit "this enableAI ""Move"";";
		processInitCommands;

		wcfame = wcfame - 0.1;
		_group = creategroup east;
		{
			if(format["%1", _x getvariable "wchostage"] == "<null>") then {
				if!((typeof _x) in wccivilwithoutweapons) then {
					removeallweapons _x;
					_x addEventHandler ['Fired', '(_this select 0) setvehicleammo 1;'];
					_x removeAllEventHandlers "killed";
					_x addeventhandler ['killed', {
						_this spawn WC_fnc_garbagecollector;
						wcnumberofkilledofmissionC = wcnumberofkilledofmissionC + 1;
						wccivilkilled =  wccivilkilled + 1;
						["wccivilkilled", "client"] call WC_fnc_publicvariable;
					}];
					if(primaryWeapon _x != "") then {
						_x addweapon "AKS_74";
						_x addmagazine "30Rnd_545x39_AK";
					} else {
						_men = _men - [_x];
					};
				};
			};
		} foreach _men;
		_men joinSilent _group;

		wcindexpropagande = wcindexpropagande + 1;
		_marker = [format['propag%1', wcindexpropagande], 400, (position (leader _group)), 'ColorRED', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarkerlocal;
		_marker setmarkerpos position (leader _group);

		_scriptinit = format["wcgarbage = [this, '%1'] execVM 'extern\upsmon.sqf';", _marker];
		(leader _group) setVehicleInit _scriptinit;
		processInitCommands;

		waituntil {count (units _group) < 1};
		deletemarkerlocal _marker;
	};