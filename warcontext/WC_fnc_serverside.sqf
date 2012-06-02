	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// -----------------------------------------------

	private ["_civillocation"];

	if (!isServer) exitWith{};



	// Grab all WC_fnc_publicvariable events
	if(isdedicated) then {
		wcgarbage = [] spawn WC_fnc_eventhandler;
	};

	// add halo jump option at flag
	if(wcwithhalojump == 1) then {
		flagusa setvehicleinit 'this addAction ["Halo Jump", "warcontext\WC_fnc_halo.sqf",[],-1,false]';
	};

	if(wcairopposingforce > 0) then {
		wcgarbage = [] spawn WC_fnc_createairpatrol;
	};

	if(wcwithseapatrol == 1) then {
		wcgarbage = [] spawn WC_fnc_createseapatrol;
	};

	if(wcwithteleporttent == 1) then {
		flagusa setvehicleinit 'this addAction ["Teleport to TENT", "warcontext\WC_fnc_createteleporttohq.sqf",[],-1,false]'; 
	};

	if(wcwithmhq == 1) then {
		flagusa setvehicleinit 'this addAction ["Teleport to HQ", "warcontext\WC_fnc_createteleporttohq2.sqf",[],-1,false]';
	};

	processinitcommands;

	// create mortuary
	wcgarbage = [] spawn WC_fnc_createmortuary;

	// NETCODE
	// Netcode replace addpublicvariableeventhandler by WC eventhandler

	// Recieve mission choosen by player
	WC_fnc_netcode_wcaskformission = {
		private ["_count", "_player", "_score", "_wcaskformission"];
		_wcaskformission = _this select 0;
		if(isnil "wccurrentmission") then {
			_player = _wcaskformission select 0;
			_missionnumber = _wcaskformission select 1;
			_score = score _player;
			_count = 0;
			{
				if(isplayer _x) then {
					if(score _x > _score) then {
						_count = _count + 1;
					};
				};
				sleep 0.01;
			}foreach allunits;
			if(_count < 4) then {
				{
					if(_x select 0 == _missionnumber) then {
						wccurrentmission = _x;
					};
					sleep 0.01;
				}foreach wclistofmissions;
			};
		};
	};

	// promote a player
	WC_fnc_netcode_wcpromote = {
		private ["_wcpromote"];
		_wcpromote = _this select 0;
		(_wcpromote select 0) setrank (_wcpromote select 1);
		if(wckindofserver != 3) then {
			wcteamscore = wcteamscore + 1;
		};
		_name = name (_wcpromote select 0);
		_rank = _wcpromote select 1;
		diag_log format ["WARCONTEXT: %1 has been promoted to %2 rank !", _name, _rank];
	};

	// degrade a player
	WC_fnc_netcode_wcdegrade = {
		private ["_wcdegrade"];
		_wcdegrade = _this select 0;
		(_wcdegrade select 0) setrank (_wcdegrade select 1);
		if(wckindofserver != 3) then {
			wcteamscore = wcteamscore - 1;
		};
		_name = name (_wcdegrade select 0);
		_rank = _wcdegrade select 1;
		diag_log format ["WARCONTEXT: %1 has been degraded to %2 rank !", _name, _rank];
	};

	// a player respawn to tent
	WC_fnc_netcode_wcrespawntotent = {
		if(wckindofserver != 3) then {
			_respawntotent = _this select 0;
			if(_respawntotent in wcinteam) then {
				wcteamscore = wcteamscore - 1;
			};
		};
	};

	// a player respawn to hq
	WC_fnc_netcode_wcrespawntohq = {
		if(wckindofserver != 3) then {
			_respawntohq = _this select 0;
			if(_respawntohq in wcinteam) then {
				wcteamscore = wcteamscore - 1;
			};
		};
	};

	// a player respawn to base
	WC_fnc_netcode_wcrespawntobase = {
		if(wckindofserver != 3) then {
			_respawntobase = _this select 0;
			if(_respawntobase in wcinteam) then {
				wcteamscore = wcteamscore - 1;
			};
		};
	};

	// add player in ready state
	WC_fnc_netcode_wcplayerreadyadd = {
		wcplayerreadyadd = _this select 0;
		wcplayerready = wcplayerready + [wcplayerreadyadd];
	};

	// add x points to teamscore
	WC_fnc_netcode_wcaddscore = {
		wcteamscore = wcteamscore + (_this select 0);
	};

	// add x points to team bonus score
	WC_fnc_netcode_wcteambonusaddscore = {
		wcteambonus = wcteambonus + (_this select 0);
	};

	// add x points to player
	WC_fnc_netcode_wcplayeraddscore = {
		private ["_index", "_find", "_player", "_point", "_score", "_playername", "_wcplayeraddscore"];
		_wcplayeraddscore = _this select 0;

		_player = _wcplayeraddscore select 0;
		_point = _wcplayeraddscore select 1;
		_playername = name _player;

		_index = 0;
		_find = false;

		{
			if((_x select 0) == _playername) then {
				_score = (_x select 2) + _point;
				if(_score < 0) then { _score = 0};
				wcscoreboard set [_index, [_playername, _player, _score]];
				_find = true;
			};
			_index = _index + 1;
			sleep 0.01;
		}foreach wcscoreboard;

		if!(_find) then {
			if(_point < 0) then {
				wcscoreboard = wcscoreboard + [[_playername, _player, 0]];
			} else {
				wcscoreboard = wcscoreboard + [[_playername, _player, _point]];
			};
		};
	};

	// increase the detection level of x prct
	WC_fnc_netcode_wcalerttoadd = {
		wcalert = wcalert + (_this select 0);
	};

	// log blame
	WC_fnc_netcode_wctk = {
		diag_log format ["WARCONTEXT: %1 IS TEAM KILLER", _this select 0];
	};

	// unflip a vehicle
	WC_fnc_netcode_wcflip = {
		 private ["_vehicle", "_position", "_typeof", "_dir", "_dammage", "_vehiclename", "_objets_charges", "_fuel"];
		_vehicle = _this select 0;
		if(!(locked _vehicle) and (getdammage _vehicle < 0.9)) then {
			_typeof = typeof _vehicle;
			_position = (getposatl _vehicle);
			_dir = getdir _vehicle;
			_dammage = getdammage _vehicle;
			_fuel = fuel _vehicle;
			_vehiclename = vehiclevarname _vehicle;
			_objets_charges = _vehicle getvariable "R3F_LOG_objets_charges";
			deletevehicle _vehicle;
			_vehicle = _typeof createvehicle _position;
			_vehicle setvehiclevarname _vehiclename;
			//_vehicle setvehicleinit format["this setvehiclevarname '%1';", _vehiclename];
			//processinitcommands;
			_vehicle setposatl _position; 
			_vehicle setdir _dir;
			_vehicle setdamage _dammage;
			_vehicle setfuel _fuel;
			_vehicle setvariable ["R3F_LOG_objets_charges", _objets_charges, true];
		};
	};

	// bomb via c130 request by admin on a zone
	WC_fnc_netcode_wcbombingrequest = {
		if(wcbombingavalaible == 1) then {
			diag_log "WARCONTEXT: CALL 1 C130 BOMBING SUPPORT";
			wcgarbage = [] spawn WC_fnc_bomb;
			wcbombingavalaible = 0;
			["wcbombingavalaible", "client"] call WC_fnc_publicvariable;
		};
	};

	// count how many W soldier died during a mission, and complete campaign
	WC_fnc_netcode_wcaddkilled = {
		wcaddkilled = _this select 0;
		wcnumberofkilled = wcnumberofkilled + 1;
		wcnumberofkilledofmissionW = wcnumberofkilledofmissionW + 1;
		wcgrave = wcgrave + 1;
		if((name wcaddkilled) in wcinteam) then {
			if(wckindofserver != 3) then {
				wcteamscore = wcteamscore - 1;
			};
		};
	};

	// recompute the list of missions when admin asks
	WC_fnc_netcode_wcrecomputemission = {
		wcgarbage = [] spawn WC_fnc_createlistofmissions;
	};

	// insert player name died during a one life mission
	WC_fnc_netcode_wctoonelife = {
		if!((_this select 0) in wconelife) then {
			wconelife = wconelife + [(_this select 0)];		
		};
	};

	// start a defend mission
	WC_fnc_netcode_wcbegindefend = {
		wcbegindefend = _this select 0;
	};

	// cancel a mission by admin
	WC_fnc_netcode_wcmissionsuccess = {
		wcmissionsuccess = _this select 0;
	};

	// retrieve team members
	WC_fnc_netcode_wcinteam = {
		wcinteam = _this select 0;
	};


	// put light around chopper landing zone
	if(tolower(worldName) == "takistan") then {
		_positions = [position tower2, 7, 360, getdir tower2, 7] call WC_fnc_docircle;
		{
			_light = "Land_runway_edgelight" createVehicle _x;
			_light setpos _x;
			_light setVehicleInit "this allowdammage false;";
			processInitCommands;
			sleep 0.01;
		}foreach _positions;
	
		_positions = [position tower3, 7, 360, getdir tower3, 7] call WC_fnc_docircle;
		{
			_light = "Land_runway_edgelight" createVehicle _x;
			_light setpos _x;
			_light setVehicleInit "this allowdammage false;";
			processInitCommands;
			sleep 0.01;
		}foreach _positions;
	
		_positions = [position tower4, 7, 360, getdir tower3, 7] call WC_fnc_docircle;
		{
			_light = "Land_runway_edgelight" createVehicle _x;
			_light setpos _x;
			_light setVehicleInit "this allowdammage false;";
			processInitCommands;
			sleep 0.01;
		}foreach _positions;
	
		_positions = [getmarkerpos "repair", 7, 360, getdir tower3, 7] call WC_fnc_docircle;
		{
			_light = "Land_runway_edgelight" createVehicle _x;
			_light setpos _x;
			_light setVehicleInit "this allowdammage false;";
			processInitCommands;
			sleep 0.01;
		}foreach _positions;
	};

	[defender1, wcenemyside] spawn WC_fnc_sentinelle;
	[defender2, wcenemyside] spawn WC_fnc_sentinelle;
	[defender3, wcenemyside] spawn WC_fnc_sentinelle;
	[defender4, wcenemyside] spawn WC_fnc_sentinelle;
	[defender5, wcenemyside] spawn WC_fnc_sentinelle;
	[defender6, wcenemyside] spawn WC_fnc_sentinelle;
	[defender7, wcenemyside] spawn WC_fnc_sentinelle;
	[defender8, wcenemyside] spawn WC_fnc_sentinelle;
	[defender9, wcenemyside] spawn WC_fnc_sentinelle;
	[defender10, wcenemyside] spawn WC_fnc_sentinelle;

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


	_bunker = nearestObjects [getmarkerpos "respawn_west", ["Land_fortified_nest_small_EP1"], 20000];
	{
		_dir = getdir _x;
		_pos = getpos _x; 
		_unit = "DSHKM_TK_GUE_EP1" createvehicle _pos; 
		_unit setpos _pos; 
		_unit setdir (_dir + 180);
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

	// create radiation on nuclear zone
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

	// For open game - all players are team members
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

	// synchronize the players rank
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