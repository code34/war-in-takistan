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
		wcday = wcday + 1;
		wclistofmissions = [];
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