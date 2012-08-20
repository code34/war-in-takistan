	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// -----------------------------------------------

	if (!isServer) exitWith{};

	diag_log "WARCONTEXT: INITIALIZING MISSION";

	// Init global variables
	wcgarbage = [] call WC_fnc_serverinitconfig;

	// UPSMON INIT
	call compile preprocessFileLineNumbers "extern\Init_UPSMON.sqf";

	// Init Debugger
	wcgarbage = [] spawn WC_fnc_debug;

	// Grab all WC_fnc_publicvariable events
	if(isdedicated) then {
		wcgarbage = [] spawn WC_fnc_eventhandler;
	};
	wcgarbage = [] spawn WC_fnc_serverhandler;

	// add halo jump option at flag
	if(wcwithhalojump == 1) then {
		flagusa setvehicleinit 'this addAction ["Halo Jump", "warcontext\actions\WC_fnc_dohalojump.sqf",[],-1,false]';
	};

	// Init Weather
	if(wcwithweather == 1) then {
		wcgarbage = [wcrainrate] spawn WC_fnc_weather;
	};

	if(wcairopposingforce > 0) then {
		[] spawn {
			waituntil { format["%1", wcselectedzone] != "[0,0,0]"};
			wcgarbage = [wcselectedzone, wcairpatroltype, wcairopposingforce] spawn WC_fnc_initairpatrol;
		};
	};

	if(wcwithseapatrol == 1) then {
		wcgarbage = [wcseainitpos] spawn WC_fnc_createseapatrol;
	};

	if(wcwithteleporttent == 1) then {
		flagusa setvehicleinit 'this addAction ["Teleport to TENT", "warcontext\actions\WC_fnc_doteleporttotent.sqf",[],-1,false]'; 
	};

	if(wcwithmhq == 1) then {
		flagusa setvehicleinit 'this addAction ["Teleport to MHQ", "warcontext\actions\WC_fnc_doteleporttomhq.sqf",[],-1,false]';
	};
	processinitcommands;


	// create mortuary
	wcgarbage = [] spawn WC_fnc_createmortuary;

	// put light around chopper landing zone
	if!(isnull tower2) then {
		_positions = [position tower2, 7, 360, getdir tower2, 7] call WC_fnc_createcircleposition;
		{
			_light = "Land_runway_edgelight" createVehicle _x;
			_light setpos _x;
			_light setVehicleInit "this allowdammage false;";
			processInitCommands;
			sleep 0.01;
		}foreach _positions;
	};

	if!(isnull tower3) then {	
		_positions = [position tower3, 7, 360, getdir tower3, 7] call WC_fnc_createcircleposition;
		{
			_light = "Land_runway_edgelight" createVehicle _x;
			_light setpos _x;
			_light setVehicleInit "this allowdammage false;";
			processInitCommands;
			sleep 0.01;
		}foreach _positions;
	};
	
	if!(isnull tower4) then {
		_positions = [position tower4, 7, 360, getdir tower3, 7] call WC_fnc_createcircleposition;
		{
			_light = "Land_runway_edgelight" createVehicle _x;
			_light setpos _x;
			_light setVehicleInit "this allowdammage false;";
			processInitCommands;
			sleep 0.01;
		}foreach _positions;
	};

	_positions = [getmarkerpos "repair", 7, 360, getdir tower3, 7] call WC_fnc_createcircleposition;
	{
		_light = "Land_runway_edgelight" createVehicle _x;
		_light setpos _x;
		_light setVehicleInit "this allowdammage false;";
		processInitCommands;
		sleep 0.01;
	}foreach _positions;

	// static weapons at takistan BASE
	if(tolower(worldname) == "takistan") then {
		[defender1, wcenemyside] spawn WC_fnc_sentinelle;
		[defender2, wcenemyside] spawn WC_fnc_sentinelle;
		[defender3, wcenemyside] spawn WC_fnc_sentinelle;
		[defender4, wcenemyside] spawn WC_fnc_sentinelle;
		[defender5, wcenemyside] spawn WC_fnc_sentinelle;
		[defender6, wcenemyside] spawn WC_fnc_sentinelle;
		[defender7, wcenemyside] spawn WC_fnc_sentinelle;
		[defender8, wcenemyside] spawn WC_fnc_sentinelle;
	};

	{
		wcgarbage = [_x, 120] spawn WC_fnc_respawnvehicle;
		sleep 0.01;
	}foreach wcrespawnablevehicles;
	wcrespawnablevehicles = [];

	{
		if(wcwithcivilian > 0) then {
			wcgarbage = [_x] spawn WC_fnc_popcivilian;
		};

		if(wcwithsheeps == 1) then {
			if(random 1> 0.9) then {
				wcgarbage = [position _x] spawn WC_fnc_createsheep;
			};
		};
	}foreach wctownlocations;

	if(wcwithcivilian > 0) then {
		wcgarbage = [] spawn WC_fnc_civilianinit;
	};


	_bunker = nearestObjects [wcmapcenter, ["Land_fortified_nest_small_EP1"], 20000];
	{
		if(random 1 < wcstaticinbunkerprobability) then {
			_dir = getdir _x;
			_pos = getpos _x; 
			_unit = "DSHKM_TK_GUE_EP1" createvehicle _pos; 
			_unit setpos _pos; 
			_unit setdir (_dir + 180);
		};
	}foreach _bunker;


	// we must wait - async return bug of arma
	sleep 1;

	// refresh public markers
	[] spawn {
		while { true } do {
			{
				_position = getmarkerpos (_x select 0);
				(_x select 0) setMarkerPos _position;
				sleep 0.01;
			}foreach wcarraymarker;
			sleep 120;
		};
	};

	// create random nuclear fire
	if(wcwithnuclear == 1) then {
		[] spawn {
			while { true } do {
				sleep (3800 + random (3800));
				if(random 1 > wcnuclearprobability) then {
					wcgarbage = [imam, 1] spawn WC_fnc_createnuclearfire;
				};
			};
		};
	};

	// heartbeat of teamscore and detection
	[] spawn {
		private ["_lastteamscore", "_lastalert"];
		_lastteamscore = 0;
		_lastalert = 0;
		while { true } do {
			if(wcalert > 100) then { wcalert = 100;};
			if(wcfame < 0) then { wcfame = 0;};		
			if(wcteamscore != _lastteamscore) then {
				["wcteamscore", "client"] call WC_fnc_publicvariable;
				_lastteamscore = wcteamscore;
			};
			if(wcalert != _lastalert) then {
				["wcalert", "client"] call WC_fnc_publicvariable;
				_lastalert = wcalert;
			};	
			sleep 5;
		};
	};



	// decrease alert level by time
	[] spawn {
		private["_decrease", "_lastalert"];
		while { true } do {
			_decrease = ceil(random(10));
			if(wcalert > _decrease) then { 
				_enemys = nearestObjects[getmarkerpos "rescuezone",["Man"], 300];
				if((west countside _enemys) == 0) then {
					wcalert = wcalert - _decrease;
					if(wcalert < 0) then { wcalert = 0;};
					if(_lastalert != wcalert) then {
						["wcalert", "client"] call WC_fnc_publicvariable;
					};
				};
			};
			sleep 60;
		};
	};

	// Manage player score
	[] spawn {
		private ["_score", "_player", "_playername", "_point"];
		if(wckindofserver != 3) then {
			while { true } do {
				{
					_playername = _x select 0;
					_player = _x select 1;
					_point = _x select 2;
					if(score _player < 0) then {
						_score = (score _player) * -1;
						_player addscore _score;
					} else {
						if(score _player != _point) then {
							_score = _point - (score _player);
							_player addscore _score;
						};
					};
					sleep 0.01;
				}foreach wcscoreboard;
				sleep 1;
			};
		};
	};

	/////////////////////////////////////
	// create radiation on nuclear zone
	/////////////////////////////////////

	[] spawn {
		private ["_array"];
		while { true } do {
			{
				_array = _x nearEntities [["Man","Landvehicle"], 500];
				{
					if(side _x == civilian) then {
						_x setdamage (getDammage _x +  0.01);
					} else {
						_x setdamage (getDammage _x +  0.001);
					};
					{_x setdamage  (getDammage _x + 0.001); sleep 0.01;} foreach (crew _x);
					sleep 0.01;
				} forEach _array;
				sleep 0.01;
			}foreach wcnuclearzone;
			sleep 1;
		};
	};

	///////////////////////////////////////////////////////
	// For open game - insert JIP players in team members
	///////////////////////////////////////////////////////

	if(wckindofserver != 1) then {
		[] spawn {
			private ["_array", "_knownplayer", "_player", "_lastinteam"];

			// array contains known player (diff jip & player)
			_knownplayer = [];

			while { true } do {
				_array = [];
				
				{
					_player = name _x;
					if!(_player in _knownplayer) then {
						_array = _array + [_player];
						_knownplayer = _knownplayer + [_player];
					};
					sleep 0.01;
				}foreach playableUnits;
	
				_lastinteam = wcinteam + _array;
		
				if(format["%1", wcinteam] != format["%1", _lastinteam]) then {
					wcinteam = _lastinteam;
					["wcinteam", "client"] call WC_fnc_publicvariable;
				};
				sleep 60;
			};
		};
	};

	/////////////////////////////////
	// synchronize the players rank
	/////////////////////////////////

	[] spawn {
		private ["_lastranksync"];
		_lastranksync = [];
		while { true } do {
			wcranksync = [];
			{
				wcranksync = wcranksync + [[_x, rank _x]];
				sleep 0.01;
			}foreach playableunits;	
			if(format["%1", _lastranksync] != format["%1", wcranksync]) then {
				_lastranksync = wcranksync;
				["wcranksync", "client"] call WC_fnc_publicvariable;
			};
			sleep 60;
		};
	};

	onPlayerConnected "[_id, _name] spawn WC_fnc_publishmission";
	onPlayerDisconnected "wcplayerready = wcplayerready - [_name];";

	////////////////////////////////////
	// INIT GAME - MAIN LOOP
	////////////////////////////////////

	wcgarbage = [] spawn WC_fnc_mainloop;