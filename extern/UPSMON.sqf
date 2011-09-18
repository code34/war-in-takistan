	// =========================================================================================================
	//  UPSMON - Urban Patrol Script  Mon
	//  Version: 5.0.7 
	// Author: Monsada (chs.monsada@gmail.com) 
	//		Comunidad Hispana de Simulación: 
	//		http://www.simulacion-esp.com
	//
	//		Wiki: http://dev-heaven.net/projects/upsmon/wiki
	//		Forum: http://forums.bistudio.com/showthread.php?t=91696
	//		Share your missions with upsmon: http://dev-heaven.net/projects/upsmon/boards/86
	// ---------------------------------------------------------------------------------------------------------
	//  Based on Urban Patrol Script  
	//  Version: 2.0.3 
	//  Author: Kronzky (www.kronzky.info / kronzky@gmail.com)
	// ---------------------------------------------------------------------------------------------------------
	//  Required parameters:
	//    unit        = Unit to patrol area (1st argument)
	//    markername  = Name of marker that covers the active area. (2nd argument)
	//
	//	Patrol squad samples:
	//    nul=[this,"town"] execVM "upsmon.sqf";
	//
	//    defensive squad samples:
	//    nul=[this,"town","nomove"] execVM "extern\UPSMON.sqf";
	//
	//  Optional parameters: _
	//    random      = Place unit at random start position.
	//    randomdn    = Only use random positions on ground level.
	//    randomup    = Only use random positions at top building positions. 
	//    min:n/max:n = Create a random number (between min and max) of 'clones'.
	//    init:string = Custom init string for created clones.
	//    nomove      = Unit will stay at start position until enemy is spotted.
	//    nofollow    = Unit will only follow an enemy within the marker area.
	//    delete:n    = Delete dead units after 'n' seconds.
	//    nowait      = Do not wait at patrol end points.
	//    noslow      = Keep default behaviour of unit (don't change to "safe" and "limited").
	//    noai        = Don't use enhanced AI for evasive and flanking maneuvers.
	//    showmarker  = Display the area marker.
	//    trigger     = Display a message when no more units are left in sector.
	//    empty:n     = Consider area empty, even if 'n' units are left.
	//    track       = Display a position and destination marker for each unit.
	//    reinforcement  = Makes squad as reinforcement, when alarm KRON_UPS_reinforcement==true this squad will go where enemy were.
	//    reinforcement:x  = Makes squad as reinforcement id, when alarm KRON_UPS_reinforcementx==true this squad will go where enemy were.
	//    fortify = makes leader order to take positions on nearly buildings at distance 200 meters, squad fortified moves less than "nomove"
	//	spawned = use only with squads created in runtime, this feature will add squad to UPSMON correctly.
	//	nowp	= No waypoints will be created for this squad UNTIL ENEMY DETECTED, this squad will comunicate enemies but will not be moved by UPSMON until enemy detected, after that upsmon takes control of squad
	//	nowp2	= No waypoints will be created for this squad UNTIL ENEMY DETECTED and damaged, this squad will comunicate enemies but will not be moved by UPSMON until enemy detected and damaged, after that upsmon takes control of squad
	//	nowp3	= No waypoints will be created for this squad in any way, this squad will comunicate enemies but will not be moved by UPSMON.
	//	ambush	= Ambush squad will not move until in combat, will lay mines if enabled and wait for incoming enemies stealth and ambush when near or discovered.
	//	ambush2	= Ambush squad will not move until in combat, will NOT LAY MINES and wait for incoming enemies stealth and ambush when near or discovered.
	//	ambush:n	= Creates an anbush and wait maximun the especified time n in seconds. you can put 0 seconds for putting mines and go away if combined with "move" for example
	//	ambush2:n = Same as ambush:n but without laying mines.
	//	aware,combat,stealth,careless defines default behaviour of squad
	//	respawn = allow squad to respawn when all members are dead and no targets near
	//	respawn:x = allows to define the number of times squad may respawn.
	// -----------------------------------------------------------------------------
	//  Modified: 08.04.2010
	// -----------------------------------------------------------------------------
	// Changes in version: 
	// -----------------------------------------------------------------------------
	//   	Added:
	//		nowp	= No waypoints will be created for this squad UNTIL ENEMY DETECTED
	//		nowp2 	= No waypoints will be created for this squad UNTIL ENEMY DETECTED AND DAMAGED
	//		nowp3 	= No waypoints will be created for this squad in any way.
	//		Ambush2 Same as ambush but without using mines
	//		Added spawn support for vehicles in squad
	// 	Modified:
	//		FORTIFY moves leader too and prevents from moving when hurt
	//		Solved bug in targetting of resistance
	//		Solved bug when respawning a template squad were creating a new template
	//		Solved bug that did exiting AI form vehicle when upsmon begins
	//		Solved bug of squads loosing group and gets stucked
	//		Avoid to take same position on buildings
	//		Solved bug in control of heli
	// -----------------------------------------------------------------------------

	if (!isServer) exitWith {};

	if (isNil("KRON_UPS_INIT")) then {
		KRON_UPS_INIT=0;
	};
	
	waitUntil {KRON_UPS_INIT==1};

	// convert argument list to uppercase
	_UCthis = [];

	for [{_i=0},{_i<count _this},{_i=_i+1}] do {_e=_this select _i; if (typeName _e=="STRING") then {_e=toUpper(_e)};_UCthis set [_i,_e]};

	if ((count _this) < 2) exitWith {
		if (format["%1",_this] != "INIT") then {
			hint "UPS: Unit and marker name have to be defined!"
		};
	};

	// Postioning
	private[
		"_group",
		"_targetX",
		"_targetY",
		"_waiting",
		"_pursue",
		"_react",
		"_newpos",
		"_currPos",
		"_orgPos",
		"_targetPos",
		"_attackPos",
		"_flankPos",
		"_avoidPos", 
		"_speedmode",
		"_dist",
		"_lastdist",
		"_lastmove1",
		"_lastmove2",
		"_gothit",
		"_supressed" ,
		"_flankdist",
		"_nBuilding",
		"_nBuildingt",
		"_objsflankPos2",
		"_targettext",
		"_dir1",
		"_dir2",
		"_dir3",
		"_dd",
		"_timeontarget",
		"_newdamage",
		"_lastdamage",
		"_dirf1",
		"_dirf2",
		"_fightmode",
		"_flankPos2",
		"_cosU",
		"_sinU",
		"_cosT",
		"_sinT",
		"_reinforcement",
		"_reinforcementsent",
		"_target",
		"_targets",
		"_flankdir",
		"_prov",
		"_lastpos",
		"_newtarget",
		"_planta",
		"_nomove",
		"_newflankAngle",
		"_sharedist",
		"_targetPosOld",
		"_fldest",
		"_grpidx",
		"_grpid",
		"_i",
		"_unitpos",
		"_Behaviour", 
		"_incar", 
		"_inheli" ,
		"_inboat",
		"_gunner",
		"_driver",
		"_vehicle",
		"_minreact",
		"_lastreact",
		"_CombatMode",
		"_rnd",
		"_GetOutDist",
		"_GetOut",
		"_GetIn_NearestVehicles",
		"_makenewtarget",
		"_index",
		"_wp",
		"_grp",
		"_wptype",
		"_wpformation",
		"_i",
		"_targetdead",
		"_frontPos",
		"_GetIn",
		"_dist1",
		"_dist2",
		"_dist3",
		"_fldestfront",
		"_fldest2",
		"_bld",
		"_flyInHeight",
		"_fortify",
		"_buildingdist",
		"_rfid",
		"_Mines",
		"_enemytanksnear",
		"_friendlytanksnear",
		"_mineposition",
		"_enemytanknear",
		"_roads",
		"_timeout",
		"_lastcurrpos",
		"_wait",
		"_side",
		"_spawned",
		"_nowp",
		"_unitsIn",
		"_ambush",
		"_ambushed",
		"_ambushdist",
		"_friendside",
		"_enemyside",
		"_newattackPos",
		"_fixedtargetpos",
		"_NearestEnemy",
		"_targetdist",
		"_cargo",
		"_targetsnear",
		"_landing",
		"_ambushwait",
		"_membertypes",
		"_respawn",
		"_respawnmax",
		"_lead",
		"_safemode",
		"_vehicles",
		"_lastwptype",
		"_template",
		"_initstr",
		 "_nowpType",
		"_ambushtype",
		"_vehicletypes",
		"_nearroad"];						

	_grpid =0;
	_exit = false;
	_fldest = 0;
	_unitpos = "AUTO";
	_vehicle = objnull;
	_minreact = KRON_UPS_minreact;
	_lastreact = KRON_UPS_minreact;
	_rnd = 0.0;
	_GetOutDist = 0;
	_GetOut=false;
	_index = 0;
	_wp=[];
	_wptype="HOLD";
	_wpformation = "WEDGE";
	_targetdead = false;
	_GetIn=false;
	_dist2 = 0;
	_dist3 = 0;
	_fldestfront = 0;
	_fldest2=0;
	_bld = objnull;
	_flyInHeight = 0;
	_rfid = 0;
	_Mines = 3;
	_friendlytanks =[];
	_enemytanksnear = false;
	_friendlytanksnear = false;
	_mineposition = [0,0,0];
	_enemytanknear = objnull;
	_NearestEnemy = objnull;
	_roads = [];
	_timeout = 0;
	_wait=90;
	_side="";
	_friendside = [];
	_enemyside = [];
	_surrended = false;
	_inheli = false;
	spawned = false;
	_nowp = false;
	_unitsIn = [];
	_ambush = false;
	_ambushed = false;
	_ambushdist = KRON_UPS_ambushdist;
	_targetdist = 10000;
	_cargo = [];
	_targetsnear = false;
	_landing=false;
	_ambushwait = 10000;
	_membertypes = [];
	_vehicletypes =[];
	_respawn = false;
	_respawnmax = 10000;
	_lead=objnull;
	_safemode = ["CARELESS","SAFE"];
	_vehicles = [];
	_lastwptype = "";
	_initstr = "";

	// unit that's moving
	_obj = _this select 0;		
	_npc = _obj;

	KRON_UPS_Instances = KRON_UPS_Instances + 1;

	// give this group a unique index
	_grpid = KRON_UPS_Instances;

	_grpidx = format["%1",_grpid];
	_grpname = format["%1_%2",(side _npc),_grpidx];
	_side = side _npc;

	{
		_x setVariable ["UPSMON_grpid", _grpid, false];
		sleep 0.05;
	}foreach units _npc;

	//is is vehicle will not be in units so must set manually
	if (isnil {_npc getVariable ("UPSMON_grpid")}) then {		
		_npc setVariable ["UPSMON_grpid", _grpid, false];		
	};

	if (KRON_UPS_Debug>0) then {player sidechat format["%1: New instance",_grpidx,_npc getVariable ("UPSMON_grpid")]}; 

	//Is ACE mod installed and loaded?
	//_ace = isClass(configFile >> "CfgPatches" >> "ace_main");

	//Did ACE scripting start?
	//if (KRON_UPS_Debug>0) then {player sidechat format["_ACE=%1 ACE=%2",_ace,!(isNil "ace_main")]}; 

	// get name of area marker 
	_areamarker = _this select 1;
	if (isNil ("_areamarker")) exitWith {
		hint "UPS: Area marker not defined.\n(Typo, or name not enclosed in quotation marks?)";
	};	

	// remember center position of area marker
	_centerpos = getMarkerPos _areamarker;
	_centerX = abs(_centerpos select 0);
	_centerY = abs(_centerpos select 1);
	_centerpos = [_centerX,_centerY];

	// show area marker 
	_showmarker = if ("SHOWMARKER" in _UCthis) then {"SHOWMARKER"} else {"HIDEMARKER"};
	if (_showmarker=="HIDEMARKER") then {
		_areamarker setMarkerPos [-abs(_centerX),-abs(_centerY)];
	};

	// is anybody alive in the group?
	_exit = true;

	if (typename _npc == "OBJECT") then {		
		if (!isnull group _npc) then {
			_npc = [_npc, units (group _npc)] call MON_getleader;
		}else{
			_vehicles = [_npc,2] call MON_nearestSoldiers;
			if (count _vehicles>0) then {
				_npc = [_vehicles select 0,units (_vehicles select 0)] call MON_getleader;
			};
		};
	} else {
		if (count _obj>0) then {
			_npc = [_obj,count _obj] call MON_getleader;			
		};
	};

	if (!(_npc iskindof "Man")) then { 
		if (!isnull(commander _npc) ) then {
			_npc = commander _npc;
		}else{
			if (!isnull(driver _npc) ) then {
				_npc = driver _npc;
			}else{			
				_npc = gunner _npc;	
			};	
		};
		group _npc selectLeader _npc;
	};

	if (alive _npc) then {_exit = false;};	

	// exit if something went wrong during initialization (or if unit is on roof)
	if (_exit) exitWith {
		hint "UPSMON: Initialization aborted";
	};

	// remember the original group members, so we can later find a new leader, in case he dies
	_group = group _npc;
	_members = units _group;

	KRON_UPS_Total = KRON_UPS_Total + (count _members);

	//Fills member soldier types
	_vehicles = [];
	{	
		if (vehicle _x != _x ) then {
			_vehicles = _vehicles - [vehicle _x];
			_vehicles = _vehicles + [vehicle _x];
		};	
		_membertypes = _membertypes + [typeof _x];
	}foreach _members;

	//Fills member vehicle types
	{
		_vehicletypes = _vehicletypes + [typeof _x];
	}foreach _vehicles;

	// what type of "vehicle" is unit ?
	_isman = "Man" countType [_npc] > 0;
	_iscar = "LandVehicle" countType [_npc] > 0;
	_isboat = "Ship" countType [_npc] > 0;
	_isplane = "Air" countType [_npc] > 0;

	// we just have to brute-force it for now, and declare *everyone* an enemy who isn't a civilian
	_issoldier = _side != civilian;

	_friends=[];
	_enemies=[];	
	_sharedenemy=0;

	if (_issoldier) then {
		switch (_side) do {
			case west:
				{ 	_sharedenemy=0; 
					_friendside = [west];
					_enemyside = [east, resistance];				
				};
			case east:
				{  
					_sharedenemy=1; 
					_friendside = [east,resistance];
					_enemyside = [west];
				};
			case resistance:
				{ 
					_sharedenemy=2; 
					_enemyside = [west];
					_friendside = [east,resistance];
				};
		};
	};

	// count friendly armor
	{
		if ((side _x in _friendside) && ( _x iskindof "LandVehicle")) then {
			_friendlytanks = _friendlytanks + [_x];
		};
	}foreach vehicles;

	// X/Y range of target area
	_areasize = getMarkerSize _areamarker;
	_rangeX = _areasize select 0;
	_rangeY = _areasize select 1;
	_area = abs((_rangeX * _rangeY) ^ 0.5);
	_areadir = (markerDir _areamarker) * -1;


	// store some trig calculations
	_cosdir = cos(_areadir);
	_sindir = sin(_areadir);

	// minimum distance of new target position
	_mindist = (_rangeX^2+_rangeY^2)/3;

	if (_rangeX == 0) exitWith {
		hint format["UPS: Cannot patrol Sector: %1\nArea Marker doesn't exist",_areamarker]; 
		diag_log format ["WARCONTEXT: UPSMON - %1 AREA marker doesn t exist ", _areamarker];
	};


	// remember the original mode & speed
	_orgMode = behaviour _npc;
	_orgSpeed = speedmode _npc;

	// set first target to current position (so we'll generate a new one right away)
	_currPos = getpos _npc;
	_orgPos = _currPos;
	_orgDir = getDir _npc;
	_orgWatch= [_currPos, 50, _orgDir] call KRON_relPos; 
	_lastpos = _currPos;

	_avoidPos = [0,0];
	_flankPos = [0,0];
	_attackPos = [0,0];
	_newattackPos = [0,0];
	_fixedtargetpos = [0,0];
	_frontPos = [0,0];
	_dirf1 = 0;
	_dirf2 = 0;
	_flankPos2 = [0,0];
	_dist = 10000;
	_lastdist = 0;
	_lastmove1 = 0;
	_lastmove2 = 0;
	_maxmove = 0;
	_moved = 0;
	_timeontarget = 0;

	_fightmode = "walk";
	_fm=0;
	_gothit = false;
	_pursue = false;
	_hitPos = [0,0,0];
	_react = 0;

	// sum of damage of each soldiers of group
	_lastdamage = 0;

	_lastknown = 0;
	_opfknowval = 0;

	_sin0 = 1;
	_sin90 = 1;
	_cos90 = 0;
	_sin270 = -1;
	_cos270 = 0;
	_targetX = 0; 
	_targetY = 0; 
	_supressed = false;
	_flankdist = 0;
	_nBuilding = nil;
	_nBuildingt =nil;
	_speedmode="Limited";
	_objsflankPos2 =  [];
	_targettext ="";
	_dir1 = 0;
	_dir2 = 0;
	_dir3 = 0;
	_dd = 0;

	_reinforcement ="";
	_reinforcementsent = false;

	_target = objnull;
	_newtarget = objnull;
	_flankdir = 0; //1 tendencia a flankpos1, 2 tendencia a flankpos2
	_prov=0;
	_targets=[];
	_planta=0; //Indice de plantas en edificios
	_newflankAngle = 0;
	_closeenough = KRON_UPS_closeenough;

	_gunner = objnull;
	_driver = objnull;
	_fortify = false;

	_buildingdist =  150; //Distance to search buildings near
	_Behaviour = "CARELESS"; 
	_group = group _npc;
	_template = 0;
	_nowpType = 1;
	_ambushtype = 1;

	// set target tolerance high for choppers & planes
	if (_isplane) then {_closeenough = KRON_UPS_closeenough * 2};

	// ***************************************** optional arguments *****************************************

	// wait at patrol end points
	_pause = if ("NOWAIT" in _UCthis) then {"NOWAIT"} else {"WAIT"};

	// don't move until an enemy is spotted
	_nomove  = if ("NOMOVE" in _UCthis) then {"NOMOVE"} else {"MOVE"};

	//fortify group in near places
	_fortify = if ("FORTIFY" in _UCthis) then {true} else {false};

	if (_fortify) then {
		_nomove = "NOMOVE";
		_minreact = KRON_UPS_minreact * 3;
		_buildingdist = _buildingdist * 2;
		_makenewtarget = true;
		_wait = 3000;
	};


	// don't follow outside of marker area
	_nowp = if ("NOWP" in _UCthis) then {true} else {false};
	_nowp = if ("NOWP2" in _UCthis) then {true} else {_nowp};
	_nowp = if ("NOWP3" in _UCthis) then {true} else {_nowp};

	_nowpType = if ("NOWP2" in _UCthis) then {2} else {_nowpType};
	_nowpType = if ("NOWP3" in _UCthis) then {3} else {_nowpType};
	_orignowp = _nowp;

	//Ambush squad will no move until in combat or so close enemy
	_ambush= if ("AMBUSH" in _UCthis) then {true} else {false};
	_ambush= if ("AMBUSH:" in _UCthis) then {true} else {_ambush};
	_ambush= if ("AMBUSH2" in _UCthis) then {true} else {_ambush};
	_ambushwait = ["AMBUSH:",_ambushwait,_UCthis] call KRON_UPSgetArg;
	_ambushwait = ["AMBUSH2:",_ambushwait,_UCthis] call KRON_UPSgetArg;
	_ambushType = if ("AMBUSH2" in _UCthis) then {2} else {_ambushType};
	_ambushType = if ("AMBUSH2:" in _UCthis) then {2} else {_ambushType};

	// don't follow outside of marker area
	_respawn = if ("RESPAWN" in _UCthis) then {true} else {false};
	_respawn = if ("RESPAWN:" in _UCthis) then {true} else {_respawn};
	_respawnmax = ["RESPAWN:",_respawnmax,_UCthis] call KRON_UPSgetArg;
	if (!_respawn) then {_respawnmax = 0};

	// any init strings?
	_initstr = ["INIT:","",_UCthis] call KRON_UPSgetArg;
	
	// don't follow outside of marker area
	_nofollow = if ("NOFOLLOW" in _UCthis) then {"NOFOLLOW"} else {"FOLLOW"};
	
	// share enemy info 
	_shareinfo = if ("NOSHARE" in _UCthis) then {"NOSHARE"} else {"SHARE"};
	
	// suppress fight behaviour
	if ("NOAI" in _UCthis) then {_issoldier=false};
	
	// adjust cycle delay 
	_cycle = ["CYCLE:",KRON_UPS_Cycle,_UCthis] call KRON_UPSgetArg;
	_currcycle=_cycle;

	switch (side _npc) do {
		case east:
			{
			  	KRON_AllEast = KRON_AllEast + units _npc; 
			};

		case resistance:
			{  	
				KRON_AllRes = KRON_AllRes + units _npc; 
				KRON_UPS_East_enemies = KRON_UPS_East_enemies + units _npc;
			};
	};
	call (compile format ["KRON_UPS_%1_Total = KRON_UPS_%1_Total + count (units _npc)",side _npc]); 	

	// drop units at random positions
	_initpos = "ORIGINAL";
	if ("RANDOM" in _UCthis) then {_initpos = "RANDOM"};
	if ("RANDOMUP" in _UCthis) then {_initpos = "RANDOMUP"}; 
	if ("RANDOMDN" in _UCthis) then {_initpos = "RANDOMDN"}; 

	// don't position groups or vehicles on rooftops
	if ((_initpos!="ORIGINAL") && ((!_isman) || (count _members)>1)) then {_initpos="RANDOMDN"};

	// set behaviour modes (or not)
	_orgMode = "SAFE";

	if ("CARELESS" in _UCthis) then {_orgMode = "CARELESS"}; 
	if ("AWARE" in _UCthis) then {_orgMode = "AWARE"}; 
	if ("COMBAT" in _UCthis) then {_orgMode = "COMBAT"}; 
	if ("STEALTH" in _UCthis) then {_orgMode = "STEALTH"}; 
	_Behaviour = _orgMode; 
	_npc setbehaviour _Behaviour; 

	//Sets initial speed
	_noslow = if ("NOSLOW" in _UCthis) then {"NOSLOW"} else {"SLOW"};

	if (_noslow!="NOSLOW") then {
		_orgSpeed = "limited";
	} else {	
		_orgSpeed = "FULL";	
	}; 

	_speedmode = _orgSpeed;
	_npc setspeedmode _speedmode;

	// If enemy detected reinforcements will be sent
	_reinforcement= if ("REINFORCEMENT" in _UCthis) then {"REINFORCEMENT"} else {"NOREINFORCEMENT"};
	_rfid = ["REINFORCEMENT:", 0, _UCthis] call KRON_UPSgetArg;

	if (_rfid > 0) then {
		_reinforcement="REINFORCEMENT";
	};

	//Is a template for spawn module?
	_template = ["TEMPLATE:",_template,_UCthis] call KRON_UPSgetArg;

	//Fills template array for spawn
	if (_template > 0 && !_spawned) then {
		KRON_UPS_TEMPLATES = KRON_UPS_TEMPLATES + ( [[_template]+[_side]+[_membertypes]+[_vehicletypes]] );
	};

	// make start position random 
	if (_initpos != "ORIGINAL") then {
		_try=0;
		_bld=0;
		_bldpos=0;
	
		_currPos = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos;
		_posinfo = [_currPos] call KRON_PosInfo3;
	
		// _posinfo: [0,0]=no house near, [obj,-1]=house near, but no roof positions, [obj,pos]=house near, with roof pos
		_bld = _posinfo select 0;
		_bldpos = _posinfo select 1;
	
		if (_bldpos==0) then {
			if (_isman) then {
				{_x setpos _currPos} foreach units _npc; 
			} else {
				_npc setpos _currPos;
			};
		} else {
			_npc setPos (_bld buildingPos _bldpos); 
			_currPos = getPos _npc;
			_nowp = true; // don't move if on roof		
		};
	};

	// units that can be left for area to be "cleared"
	_zoneempty = ["EMPTY:",0,_UCthis] call KRON_UPSgetArg;


	// if fortify, soldiers go into static	
	if ( _nomove == "NOMOVE" ) then {		
		_unitsIn = [_grpid, _npc, 300] call MON_GetIn_NearestStatic;		
		if ( count _unitsIn > 0 ) then { sleep 10};
		[_npc, _buildingdist,false,_wait,true] spawn MON_moveNearestBuildings;
	};	


	// init done
	_makenewtarget = true;
	_newpos = false;
	_targetPos = [0,0,0]; //_currPos;
	_targettext = "_currPos";
	_swimming = false;
	_waiting = if(_nomove == "NOMOVE") then { 9999 } else {0};
	_sharedist = if (_nomove=="NOMOVE") then {KRON_UPS_sharedist} else {KRON_UPS_sharedist*1.5};


	//Gets position of waypoint if no targetpos
	if (format ["%1", _targetPos] == "[0,0,0]") then {
		_index = (count waypoints _group) - 1;	
		_wp = [_group,_index];
		_targetPos = waypointPosition _wp;
		if (([_currpos,_targetPos] call KRON_distancePosSqr)<= 20) then {_targetPos = [0,0,0];};
	};

// ***********************************************************************************************************
// ************************************************ MAIN LOOP ************************************************
// ***********************************************************************************************************
_loop=true;

scopeName "main"; 
while {_loop && (count (units _group) > 0)} do {

	_timeontarget = _timeontarget + _currcycle;
	_react = _react + _currcycle;	
	_waiting = _waiting - _currcycle;
	_lastreact = _lastreact + _currcycle;
	_newpos = false;			
	
	// did anybody in the group got hit?
	_newdamage = 0; 
	{
		if((damage _x) > 0.2) then {
			_newdamage= _newdamage + (damage _x); 

			// damage has increased since last round
			if (_newdamage > _lastdamage) then {
				_lastdamage = _newdamage; 
				_gothit=true;
			};
		};
		sleep 0.5;	
	} foreach (units _group);
	
	// ASSIGN LEADER OF GROUP ID
	_npc = leader _group;
	KRON_NPCs set [_grpid,_npc];

	// current position of leader
	_currPos = getpos _npc; 
	_currX = _currPos select 0; 
	_currY = _currPos select 1;
	
	// if the AI is a civilian we don't have to bother checking for enemy encounters
	if ((_issoldier) && !(_exit)) then {
		_pursue=false;
			
		// check kind of vehicle of leader
		_incar = "LandVehicle" countType [vehicle (_npc)] > 0;
		_inheli = "Air" countType [vehicle (_npc)] > 0;
		_inboat = "Ship" countType [vehicle (_npc)] > 0;			
			
		//Gets targets from radio
		_targets = call (compile format ["KRON_targets%1",_sharedenemy]);	
				
		//Reveal targets found by members to leader
		{
			_NearestEnemy = assignedTarget _x;
			if (_x knowsabout _NearestEnemy > 0.5 && (_npc knowsabout _NearestEnemy <= 0.5 || count _targets <= 0 )) then 	{		
				if (_npc knowsabout _NearestEnemy <= 0.5 ) then 	{		
					_npc reveal _NearestEnemy;
					if (KRON_UPS_Debug>0) then {player globalchat format["%1: %2 reveals target %3 to leader",_grpidx,typeof _x, typeof _NearestEnemy]}; 
				};
				
				//If no targets adds this
				if (count _targets <= 0) then {
					_targets = _targets + [_NearestEnemy];					
					_NearestEnemy setvariable ["UPSMON_lastknownpos", position _NearestEnemy, false];						
				};
			};

			{
				if(alive _x) then {
					_x reveal _NearestEnemy;
				} else {
					wcblinde = wcblinde - [_x];
				};
				sleep 0.05;
			}foreach wcblinde;
			sleep 0.5;
		}foreach units _npc;
	
		//Resets distance to target
		_dist = 10000;
		
		//Gets  current known position of target and distance
		if ( !isNull (_target) && alive _target ) then {
			_newattackPos = _target getvariable ("UPSMON_lastknownpos");
			
			if ( !isnil "_newattackPos" ) then {
				_attackPos=_newattackPos;	
				//Gets distance to target known pos
				_dist = ([_currpos,_attackPos] call KRON_distancePosSqr);				
			};
		};	
				
		//Initialization for geting new targets
		//Si el objetivo actual está muerto o no existe se limpia el conocimiento anterior
		if (isNull (_target) || !alive _target || !canmove _target ) then {
			_lastknown = 0;
			_opfknowval = 0; 
			_target = objnull;
		};			
		//_maxknowledge=0;		
		_newtarget = _target;					
	
		if ((_shareinfo=="SHARE")) then {			
			// if the leader comes across another unit that's either injured or dead, go into combat mode as well. 
			// If the other person is still alive, share enemy information.

			//Solicita por radio la posición del enemigo, si está dentro del radio de acción actua
			if ((KRON_UPS_comradio == 2)) then
			{	
				_targetsnear = false;
				
				//I we have a close target alive do not search another
				if (!alive _target || !canmove _target || _dist > _closeenough) then {					
					{															
						//if (KRON_UPS_Debug>0) then {player sidechat format["%1: targets=%2 tg=%3 newtg=%4 dist=%5 %6 %7 %8 %9",_grpidx,count _targets,typeof _x,_newtarget, _dist,_knows, _maxknowledge,_dist2,_attackPos]}; 																	
						 if ( !isnull _x && canmove _x && alive _x ) then {
													
							_newattackPos = _x getvariable ("UPSMON_lastknownpos");		
							
							if (  !isnil "_newattackPos" ) then {	
								_dist3 = ([_currpos,_newattackPos] call KRON_distancePosSqr);	
								
								//Sets if near targets to begin warning
								IF ( _dist3 <= (_closeenough + KRON_UPS_safedist)) then { _targetsnear = true };				
								
								//Sets new target
								if ( ( isnull (_newtarget) || captive _newtarget|| !alive _newtarget|| !canmove _newtarget || _dist3 < _dist ) 								
								&& ( _dist3 <= _sharedist || _reinforcementsent )
								&& ( !(_x iskindof "Air") || (_x iskindof "Air" && _isplane ))
								&& ( !(_x iskindof "Ship") || (_x iskindof "Ship" && _isboat ))
								&& ( _x emptyPositions "Gunner" == 0 && _x emptyPositions "Driver" == 0 
								|| (!isnull (gunner _x) && canmove (gunner _x))
								|| (!isnull (driver _x) && canmove (driver _x))) 	
								) then {
									_newtarget = _x;				
									_opfknowval = _npc knowsabout _x; 
									_dist = _dist3;			
									if (_dist < _closeenough) exitWith {};	
								};	
							};
						};
					sleep 0.5;			
					} foreach _targets;
					sleep 0.5;	
				};
			};				
						
					
			//Si cambia el target cambiamos inicializamos la dirección de flanqueo
			if ( !isNull (_newtarget) && alive _newtarget && canmove _newtarget && (_newtarget != _target || isNull (_target)) ) then {
				_timeontarget = 0;
				_targetdead = false;
				_flankdir= if (random 100 <= 10) then {0} else {_flankdir};	
				_target = _newtarget;						
			};						
		};		
		
		//Gets  current known position of target and distance
		if ( !isNull (_target) && alive _target ) then {
			//Enemy detected
			if (_fightmode != "fight" ) then {
				_fightmode = "fight";
				_react = KRON_UPS_react;
				if (KRON_UPS_Debug>0) then {player sidechat format["%1: Enemy detected %2",_grpidx, typeof _target]}; 	
				if (_nowpType == 1) then {_nowp = false};
			};			
			
			_newattackPos = _target getvariable ("UPSMON_lastknownpos");
			
			if ( !isnil "_newattackPos" ) then {
				_attackPos=_newattackPos;	
				//Gets distance to target known pos
				_dist = ([_currpos,_attackPos] call KRON_distancePosSqr);	
				//Looks at target known pos
				_members lookat _attackPos;							 				
			};
		};				
		
		//Si el enemigo se ha alejado de la covertura de rádio y no es un refuerzo enviado habremos perdido la pista
		if ( _fightmode != "walk" && !isnull(_target) && _dist < 15 &&  _npc knowsabout _target < 0.5 ) then {			
			//If squad is near last position and no target clear position of target
			if (KRON_UPS_Debug>0) then {player sidechat format["%1: Target lost",_grpidx]}; 				
			_fightmode="walk";
			_speedmode = _orgSpeed;			
			_target = objnull;
			_Behaviour = _orgMode;					
			_waiting = -1;	
			_unitpos = "AUTO";			
			_pursue=false;
			_nowp = _orignowp;	
			_targetdead	= true;
			_makenewtarget = true; //Volvemos a la posición original		
		};			
		
		//Si aumenta el conocimiento del target aceleramos la reacción
		if (_opfknowval>_lastknown ) then {
			_react = _react + 20;
		};	
	
		// if spotted an enemy or got shot, so start pursuit, if in combat and exceed time to react or movecompleted
		if (_fightmode != "walk" && ((_react >= KRON_UPS_react && _lastreact >=_minreact) || moveToCompleted _npc )) then {			
			_pursue=true;
		};

		//Ambush
		if (_ambush && !_ambushed) then {
			_ambushed = true;
			_nowp = true;
			_currcycle = 2;		
			_group setFormation "LINE";
			_npc setBehaviour "STEALTH";	
			_npc setSpeedMode "FULL";	
			sleep 10;
			{		
				[_x,"DOWN"] spawn MON_setUnitPos;			
				_x stop true;
				sleep 0.5;							
			}foreach units _npc;		
			
			//Puts a mine if near road
			if ( KRON_UPS_useMines ) then {			
				if (KRON_UPS_Debug>0) then {player sidechat format["%1: Puting mine for ambush",_grpidx]}; 	
				_npc setBehaviour "careless";
				_dir1 = getDir _npc;
				_mineposition = [position _npc,_dir1, 25] call MON_GetPos2D;					
				_roads = _mineposition nearroads KRON_UPS_ambushdist;
				
				if (count _roads > 0) then {					
					_mineposition = position (_roads select 0);
					if (_Mines > 0 && [_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};	
					
					if (count _roads > 3) then {
						_mineposition = position (_roads select 3);
						if (_Mines > 0 && [_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};
					};
					
				} else {
					_mineposition = [position _npc,(_dir1-30)mod 360, KRON_UPS_ambushdist + random 15] call MON_GetPos2D;				
					if (_Mines > 0 && [_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};	
					
					_mineposition = [position _npc,(_dir1+30)mod 360, KRON_UPS_ambushdist + random 15] call MON_GetPos2D;				
					if (_Mines > 0 && [_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};						
				};
				
				_mineposition = [position _npc,_dir1, KRON_UPS_ambushdist + random 20] call MON_GetPos2D;				
				if ([_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};		
				
				_mineposition = [position _npc,_dir1-15, KRON_UPS_ambushdist + random 10] call MON_GetPos2D;				
				if ([_npc,_mineposition] call MON_CreateMine) then {_Mines = _Mines -1;};						

				_npc setBehaviour "careless";			
				sleep 30;				
				{	
					if (!stopped _x) then {
						_x domove position _npc;
						waituntil {moveToCompleted _x || moveToFailed _x || !alive _x || !canmove _x || _x distance _npc <= 5};
					};
					sleep 0.5;
				}foreach units _npc;				
			};				

			_npc = leader _group;
			_npc setBehaviour "STEALTH";	
			_group setFormation "LINE";
			
			sleep random(10);
			{		
				[_x,"DOWN"] spawn MON_setUnitPos;			
				_x stop true;	
				_x setUnitPos "DOWN";
				sleep 0.5;				
			}foreach (units _group);
		};	
		
		//Ambus enemy is nearly aproach
		//_ambushdist = 50;		
		if (_ambush) then {
			_prov = ((_ambushdist*2 - (_npc distance _target))*3) - 40;
			//if (KRON_UPS_Debug>0) then {player sidechat format["%1:%6 _ambushdist=%5 last=%2 dist=%3 prov=%4",_grpidx,_lastdist,_npc distance _target,_prov,_ambushdist,typeof _target]}; 			
			if (_gothit  || _reinforcementsent || time > _ambushwait
					|| ( "Air" countType [_target]<=0 
						&& (	_npc distance _target <= _ambushdist + random 10 
								|| (!isNull (_target) && (( random 100 <= _prov &&  _npc distance _target > _lastdist)
									|| _npc distance _target > _ambushdist*3 && _lastdist < _ambushdist*3 && _lastdist > 0))
						))
				) then { 
				
				if (KRON_UPS_Debug>0) then {player sidechat format["%1: FIREEEEEEEEE!!!",_grpidx]}; 		
				_nowp = _orignowp;
				_ambush = false;
				_ambushed = false;
				_currcycle = _cycle;
				{
					_x stop false;	
					_x setUnitPos "Middle";
					sleep 0.5;				
				} foreach (units _group);
				
				//No engage yet
				_pursue = false;
			};
			
			//Sets distance to target
			_lastdist = _npc distance _target;			
		};
				
		//if (KRON_UPS_Debug>0) then {player sidechat format["%1: _nowp=%2 in vehicle=%3 _inheli=%4 _npc=%5",_grpidx,_nowp,vehicle (_npc) ,_inheli,typeof _npc ]}; 	
		//If in vehicle take driver if not controlled by user
		if (alive _npc && !_nowp) then {
			if (!_isman || (vehicle (_npc) != _npc && !_inboat && !(vehicle (_npc) iskindof "StaticWeapon"))) then { 						
				//If new target is close enough leaves vehicle	
				_unitsin = [];
				if (!_inheli) then { 						
					if (_fightmode == "walk") then {
						_GetOutDist =  _area / 20;
					}else{
						_GetOutDist =  _closeenough  * ((random .4) + 0.6);
					};
					 
					//If near target or stuck getout of vehicle and lock	or gothit exits inmediately
					if (_gothit || _dist <= _closeenough * 1.5 || (_lastcurrpos select 0 == _currpos select 0 && _lastcurrpos select 1 == _currpos select 1 && moveToFailed (vehicle (_npc))) 
													|| moveTocompleted (vehicle (_npc))) then 
					{
						_GetOutDist = 10000;
					};
					//if (KRON_UPS_Debug>0) then {player sidechat format["%1: vehicle=%2 _npc=%3",_grpidx,vehicle (_npc) ,typeof _npc ]}; 						 					
					_unitsin = [_npc,_targetpos,_GetOutDist] call MON_GetOutDist;	
					 sleep 0.05;
				}else{
					_GetOutDist = 0;
				};
				
				if (count _unitsin > 0) then {					
					if (KRON_UPS_Debug>0) then {player sidechat format["%1: Geting out of vehicle",_grpidx,([_currpos,_targetpos] call KRON_distancePosSqr),_GetOutDist,_area]}; 											
					_timeout = time + 15;	
					{ 
						waituntil {vehicle _x == _x || !canmove _x || !alive _x || time > _timeout || movetofailed _x  };
						sleep 0.5;
					}foreach _unitsin;			

					_npc = leader _group;			
					if (_fightmode == "fight" || _gothit) then {			
						_npc setBehaviour "AWARE";																		
						_group setFormation "DIAMOND";							
						[_npc, 50] call MON_move;																
					};
					
					if (_fightmode == "fight") then {	
						_pursue = true;
					}else
					{						
						_pursue = false;	
						_makenewtarget=true;
					};						
				};	
			};									
		};			

		//Si bajo ataque o aumenta el conocimiento se acelera la respuesta y se retoma el control de la AI
		if (_gothit ) then { 
			_react = if (!_supressed) then {_react + 30};
			if (_fightmode != "walk") then {
				if (_nowpType == 2) then {_nowp = false};
			};
		};	
		
		//Si no hay objetivo se anula la orden de persecución
		if ((isNull (_target) || !alive _target )) then {
			_pursue=false;	
			if (_gothit && !_fortify) then {
				if (_fightmode == "walk") then 
				{
					//Podría tratarse de un sniper, mejor estar alerta y moverse por si acaso			
					_Behaviour =  "AWARE";	
					_speedmode = "FULL";	
					_unitpos = "AUTO";				
					_gothit = false;				
					_makenewtarget = true;
					_waiting = -1;					
					if (KRON_UPS_Debug>0) then {player sidechat format["%1: Have been damaged moving",_grpidx,_makenewtarget]}; 
				} else {
					if (_react >= KRON_UPS_react && _lastreact >=_minreact && count _targets <= 0) then {										
						//Nos disparan y no tenemos target, nos movemos de posición								
						if (KRON_UPS_Debug>0) then {player sidechat format["%1: Under fire by unkown target, moving to newpos",_grpidx]}; 
						//Cubre al grupo con una granada de humo
						if (!_supressed && (random 100)<80) then {	
							[_npc,_target] spawn MON_throw_grenade;
						};									
						_gothit = false;
						_makenewtarget = true;		
						_waiting = -1;				
						_pause="NOWAIT";				
						_speedmode = "FULL";				
						_unitpos = "middle";		
						_Behaviour = "AWARE";							
					}else{				
						if (_lastreact >=_minreact && !_targetdead) then 
						{
							_targetdead = true;
							_pursue = true;
							//Nos hemos qdado sin objetivos continuamos la búsqueda				
							if (KRON_UPS_Debug>0) then {player sidechat format["%1: Target defeated, searching",_grpidx]}; 						
						};	
					};					
				};
			};
		};		
		
		//If no fixed target check if current target is available
		if (format ["%1",_fixedtargetPos] != "[0,0]") then {	
			//If fixed target check if close enough or near enemy and gothit
			if (([_currpos,_fixedtargetpos] call KRON_distancePosSqr) <= _closeenough || (_dist <= _closeenough && _gothit)) then {				
				_fixedtargetPos = [0,0];
			}else{		
				_pursue = false;
				_attackPos=_fixedtargetPos;
				if (_react >= KRON_UPS_react && _lastreact >=_minreact) then {
					_makenewtarget = true;
					_unitpos = "AUTO";
					_speed = "FULL";
				};				
			};
		};	
	
		//If captive or surrended do not pursue
		if ( isnil "_attackPos") then {_pursue = false;};
		if ( captive _target || format ["%1", _attackPos] == "[0,0]") then {_pursue = false;};
			
		//If no waypoint do not move
		if (_nowp) then {
			_makenewtarget = false;
			_pursue = false;
		};	
		
		if (_inheli) then {
			_landing = _heli getVariable "UPSMON_landing";
			if (isnil ("_landing")) then {_landing=false;};
			if (_landing) then {	
				_pursue = false;
			};
		};		
		sleep 0.5;
		
//**********************************************************************************************************************
//   								PURSUE:	SE 	INICIA	LA	PERSECUCIÓN	DEL	OBJETIVO
//**********************************************************************************************************************		
		if (_pursue) then {			
			_pursue = false;
			_newpos = true; 	
			_react = 0;		
			_lastreact = 0;
			_timeontarget = 0; 		
			_makenewtarget = false;			
			_fm = 1;
			//Cancel supress effect when reaction time
			_supressed = false;		

			_npc = leader _group;
		
			// get position of spotted unit in player group, and watch that spot
			_targetPos = _attackPos;		
			_targetX = _targetPos select 0;
			 _targetY = _targetPos select 1;
			_currPos = getpos _npc;									

			 // also go into "combat mode"		
			_pause="NOWAIT";
			_waiting=0;			
			
			// angle from unit to target
			_dir1 = [_currPos,_targetPos] call KRON_getDirPos;
			// angle from target to unit (reverse direction)
			_dir2 = (_dir1+180) mod 360;			
			
			//Establecemos una distancia de flanqueo	
			_flankdist = ((random 0.5)+0.7) * KRON_UPS_safedist;
						
			//La distancia de flanqueo no puede ser superior a la distancia del objetivo o nos pordría pillar por la espalda
			_flankdist = if ((_flankdist*1.40) >= _dist) then {_dist*.65} else {_flankdist};
			
			if (_inheli) then {_flankdist = _flankdist / 2;};
												
			// avoidance position (right or left of unit)
			_avoidPos = [_currPos,_dir2, KRON_UPS_safedist] call MON_GetPos2D;		

			//Calculamos posición de avance frontal			
			_frontPos = [_targetPos,_dir2, _flankdist] call MON_GetPos2D;					

			//Adaptamos el ángulo de flanqueo a la distancia		
			_newflankAngle = ((random(KRON_UPS_flankAngle)+1) * 2 * (_flankdist / KRON_UPS_safedist )) + (KRON_UPS_flankAngle/1.4) ;

			if (_newflankAngle > KRON_UPS_flankAngle) then {_newflankAngle = KRON_UPS_flankAngle};			
			
			//Calculamos posición de flanqueo 1 45º
			_dirf1 = (_dir2+_newflankAngle) mod 360;			
			_flankPos = [_targetPos,_dirf1, _flankdist] call MON_GetPos2D;
			
			//Calculamos posición de flanqueo 2 -45º			
			_dirf2 = (_dir2-_newflankAngle+360) mod 360;		
			_flankPos2 = [_targetPos,_dirf2, _flankdist] call MON_GetPos2D;	
			
			if (KRON_UPS_Debug>0) then {
				"flank1" setmarkerpos _flankPos; 
				"flank2" setmarkerpos _flankPos2; 
				"target" setmarkerpos _attackPos;	
			};
						
						
			//Decidir por el mejor punto de flanqueo
			//Contamos las posiciones de destino de otros grupos más alejadas
			_fldest = 0;
			_fldest2 = 0;
			_fldestfront = 0;
			_i = 0;
			
			{			
				if (_i != _grpid &&  format ["%1", _x] != "[0,0]") then {
					_dist1 = [_x,_flankPos] call KRON_distancePosSqr;
					_dist2 = [_x,_flankPos2] call KRON_distancePosSqr;	
					_dist3 = [_x,_frontPos] call KRON_distancePosSqr;	
					if (_dist1 <= _flankdist/1.5 || _dist2 <= _flankdist/1.5 || _dist3 <= _flankdist/1.5) then {					
						if (_dist1 < _dist2 && _dist1 < _dist3) then {_fldest = _fldest + 1;};
						if (_dist2 < _dist1 && _dist2 < _dist3) then {_fldest2 = _fldest2 + 1;};
						if (_dist3 < _dist1 && _dist3 < _dist2) then {_fldestfront = _fldestfront + 1;};						
					};
				};
				_i = _i + 1;
				sleep 0.5;
			}foreach KRON_targetsPos;	
			//sleep 0.05;
			
			//Contamos las posiciones de otros grupos más alejadas
			_i = 0;
			{			
				if (_i != _grpid && !isnull(_x)) then {
					_dist1 = [getpos(_x),_flankPos] call KRON_distancePosSqr;
					_dist2 = [getpos(_x),_flankPos2] call KRON_distancePosSqr;	
					_dist3 = [getpos(_x),_frontPos] call KRON_distancePosSqr;
					if (_dist1 <= _flankdist/1.5 || _dist2 <= _flankdist/1.5 || _dist3 <= _flankdist/1.5) then {										
						if (_dist1 < _dist2 && _dist1 < _dist3) then {_fldest = _fldest + 1;};
						if (_dist2 < _dist1 && _dist2 < _dist3) then {_fldest2 = _fldest2 + 1;};
						if (_dist3 < _dist1 && _dist3 < _dist2) then {_fldestfront = _fldestfront + 1;};	
					};
				};
				_i = _i + 1;
				sleep 0.5;
			}foreach KRON_NPCs;					
			//sleep 0.05;			
			
			//La preferencia es la elección inicial de dirección
			switch (_flankdir) do {
				case 1: 
					{_prov = 125};
				case 2: 
					{_prov = -25};
				default
					{_prov = 50};
			};						
			
			
			//Si es positivo significa que hay más destinos existentes lejanos a la posicion de flanqueo1, tomamos primariamente este
			if (_fldest<_fldest2) then {_prov = _prov + 50;};
			if (_fldest2<_fldest) then {_prov = _prov - 50;};		

			//Si la provablilidad es negativa indica que tomará el flank2 por lo tanto la provabilidad de coger 1 es 0
			if (_prov<0) then {_prov = 0;};
			
				
			//Evaluamos la dirección en base a la provablilidad calculada
			if ((random 100)<=_prov) then {
				_flankdir =1;
				_flankPos = _flankPos; _targettext = "_flankPos";
			} else {
				_flankdir =2;
				_flankPos = _flankPos2; _targettext = "_flankPos2";
			};			
			
					
			//Posición de ataque por defecto el flanco
			_targetPos = _flankPos;
			_targettext = "_flankPos";
			
			
			if ((surfaceIsWater _flankPos && !(_isplane || _isboat)) ) then {
				_targetPos = _attackPos;_targettext ="_attackPos"; 
				_flankdir =0;
			} else {
				if (_fldestfront < _fldest  && _fldestfront < _fldest2) then {
					_targetPos = _frontPos;_targettext ="_frontPos"; 
				};
			};
					
			//Establecemos tipo de waypoint
			//con DESTROY tiene peor comportamiento y a veces no se mueven
			_wptype = "MOVE";					
			
			//Establecer velocidad y modo de combate 	
			_rnd = random 100;			
			if ( _dist <= _closeenough ) then {
				//Si estamos muy cerca damos prioridad a fuego a discrección
				if ( _dist <= _closeenough/2 ) then {	
					//Modo combate cerrado
					_speedmode = "LIMITED";	
					_wpformation = "LINE";	
					_unitpos = "Middle";	
					_react = _react + KRON_UPS_react / 2;
					_minreact = KRON_UPS_minreact / 2;
					if ((_nomove == "NOMOVE" && _rnd < 25) && !_reinforcementsent) then {		
						//Combate defensivo							
						_Behaviour =  "STEALTH"; 
						_wptype = "HOLD";						
					} else {					
						_Behaviour =  "COMBAT";						
						_wptype = "MOVE";				
					}
				}else{
					//Si la tropa tiene el rol de no moverse tenderá a mantener la posición	
					_speedmode = "FULL";	
					_wpformation = "WEDGE";	
					_unitpos = "Middle";	
					_minreact = KRON_UPS_minreact / 1.5;					
					if ((_nomove == "NOMOVE" && _rnd < 50) && !_reinforcementsent) then {		
						//Combate defensivo							
						_Behaviour =  "COMBAT"; 
						_wptype = "HOLD";						
					} else {				
						_Behaviour =  "AWARE"; 			 		
						_wptype = "MOVE";
					};														
				};								
			} else	{			
				if (( _dist <= (_closeenough + KRON_UPS_safedist))) then {
					_speedmode = "FULL";
					_wpformation = "WEDGE";							
					_unitpos = if (_rnd < 90) then {"Middle"}else{"AUTO"};					
					_minreact = KRON_UPS_minreact;
					if ((_nomove=="NOMOVE" && _rnd < 75)  && !_reinforcementsent) then {
						//Combate defensivo
						_Behaviour =  "AWARE"; 	
						_wptype = "HOLD";							
					}else{	
						//Movimiento con precaución (más rápido)				
						_Behaviour =  "AWARE"; 		
						_wptype = "MOVE";						
					};										
				} else {
					//In distance of radio patrol may act.
					if (( _dist <  KRON_UPS_sharedist )) then {
						//Pelotón lejos del objetivo hay que desplazarse rápido y directo al punto
						_Behaviour =  "AWARE"; 
						_speedmode = "FULL";
						_unitpos = if (_rnd < 60) then {"Middle"}else{"AUTO"};		
						_minreact = KRON_UPS_minreact * 2;										
						if ((_nomove=="NOMOVE" && _rnd < 95) && !_reinforcementsent) then {
							_wptype = "HOLD";						
							_wpformation = "WEDGE";							
						}else{					
							_wptype = "MOVE";	
							_wpformation = "WEDGE";						
						};
					} else {
						//Pelotón muy muy lejos del objetivo si es rol nomove no se moverán
						_Behaviour =  "SAFE"; 
						_speedmode = "FULL";
						_unitpos = "AUTO";
						_minreact = KRON_UPS_minreact * 3;
						
						if (((_nomove=="NOMOVE") || (_nomove=="MOVE" && _rnd < 70)) && !_reinforcementsent) then {
							_wptype = "HOLD";						
							_wpformation = "WEDGE";
						}else{					
							_wptype = "MOVE";	
							_wpformation = "COLUMN";						
						};						
					};
				};	
			};	
			
			//Las escuadras fortificadas mantienen siempre la posición
			if ( _fortify && (random 100)<99) then {_wptype = "HOLD"};
			
			// did the leader die?
			_npc = leader _group;
	
			//If leader is in vehicle will move in  anyway
			if (vehicle (_npc) != _npc || !_isman) then {
				_wptype = "MOVE";
				_Behaviour =  "AWARE"; 
				if ( _inheli ) then {
					_speedmode = "FULL";	
					_unitpos = "AUTO";	
					if ( (random 100)<60 ) then {					
						_targetPos = _AttackPos;
					};
					
				};
			};			
		
			//Establecemos el target
			KRON_targetsPos set [_grpid,_targetPos];
			sleep .05;					
			
			// if mines are on and there is no friendly armor, soldiers put mine
			if ( KRON_UPS_useMines && _Mines > 0 ) then {
				_enemytanksnear = false;	
				{
					if ( ("Tank" countType [_x] > 0 || "Wheeled_APC" countType [_x] >0 
						|| "Tank" countType [vehicle _x] > 0 || "Wheeled_APC" countType [vehicle _x] >0 ) 
						&& alive _x && canMove _x && _npc distance _x <= _closeenough + KRON_UPS_safedist )
						exitwith { _enemytanksnear = true; _enemytanknear = _x;};
						sleep 0.5;																				
				}foreach _targets;				
				
				//If use mines are enabled and enemy armors near and no friendly armor put mine.
				if ( _enemytanksnear && !isnull _enemytanknear && alive _enemytanknear ) then {
					_friendlytanksnear = false;
					{
						if (!( alive _x && canMove _x)) then {_friendlytanks = _friendlytanks - [_x]};
						if (alive _x && canMove _x && _npc distance _x <= _closeenough + KRON_UPS_safedist ) exitwith { _friendlytanksnear = true;}; 
						sleep 0.5;
					}foreach _friendlytanks;	
					
					if (!_friendlytanksnear && random(100) < 30 ) then {
						_dir1 = [_currPos,position _enemytanknear] call KRON_getDirPos;
						_mineposition = [position _npc,_dir1, 25] call MON_GetPos2D;	
						_roads = _mineposition nearroads 50;
						if (count _roads > 0) then {_mineposition = position (_roads select 0);};
						if ([_npc,_mineposition] call MON_CreateMine) then {
							_Mines = _Mines - 1;
							if (KRON_UPS_Debug>0) then {player sidechat format["%1: %3 puting mine for %2",_grpidx,typeof _enemytanknear, side _npc]}; 									
						};													
					};				
				};
			};
										
			// Si es unidad de refuerzo siempre acosará al enemigo
			if (_reinforcementsent) then {
				_wptype="MOVE";
				_newpos=true; 
				_makenewtarget = false;
			};			
						
			if (_nofollow=="NOFOLLOW" && _wptype != "HOLD") then {
				_targetPos = [_targetPos,_centerpos,_rangeX,_rangeY,_areadir] call KRON_stayInside;
				_targetdist = [_currPos,_targetPos] call KRON_distancePosSqr;
				if ( _targetdist <= 1 ) then {
					_wptype="HOLD";
				};
			};
			
			if (_wptype == "HOLD") then {
				_targetPos = _currPos;	
				_targettext = "_currPos";
			};			
			
			_lastknown = _opfknowval; //Se actualiza con el último valor, por si cambia el target
				
			//Si por el motivo que sea se cancela la nueva posición se deben limpiar los parámetros que hacen entrar en pursuit
			if  (!_newpos) then {
				//Si la unidad ha decidio mantener posición pero está siendo atacada está siendo suprimida, debe tener la oportunidad de reaccionar
				_newpos = _gothit;
				if  (!_newpos) then {
					_targetPos=_lastpos;
					if (KRON_UPS_Debug>0) then {player sidechat format["%1 Mantaining orders %2",_grpidx,_nomove]};	
				};
			};			
			if (KRON_UPS_Debug>=1) then {
				"avoid" setmarkerpos _avoidPos; 
				"flank" setmarkerpos _flankPos; 
				_destname setMarkerPos _targetPos;
			};						
		};	//END PURSUE				
	}; //((_issoldier) && ((count _enemies)>0)
	sleep 0.5;
	
	
//**********************************************************************************************************************
//   								SIN		NOVEDADES
//**********************************************************************************************************************
	if !(_newpos) then {
		// did the leader die?
		_npc = leader _group;

		// calculate new distance
		// if we're waiting at a waypoint, no calculating necessary	
		_currpos = getpos _npc;		
		
		//Sets behaviour of squad if nearly changes of target
		if (_targetsnear) then{
			if( toUpper(_Behaviour) IN _safemode) then {				
				_Behaviour = "AWARE";
				_npc setBehaviour _Behaviour;	
			};						
		};	
		//If in safe mode if find dead bodies change behaviour
		if( toUpper(_Behaviour) IN _safemode) then {	
			_unitsin = [_npc,_buildingdist] call MON_deadbodies;
			if (count _unitsin > 0) then { 
				_Behaviour = "AWARE";
				_react = _react + 30;
				_npc setBehaviour _Behaviour;
				if (KRON_UPS_Debug>0) then {player sidechat format["%1 dead bodies found! set %2",_grpidx,_Behaviour, count _targets]};	
			};
		};
			
		//Stuck control
		if (!_nowp && alive _npc && canmove _npc && _wptype == "MOVE" && _timeontarget >= 60 && _lastcurrpos select 0 == _currpos select 0 && _lastcurrpos select 1 == _currpos select 1) then {
			[_npc] call MON_cancelstop;	
			_makenewtarget = true;
			if (KRON_UPS_Debug>0) then {player sidechat format["%1 stucked, moving",_grpidx]};	
		};
		
		_lastpos = _targetPos;
		_lastcurrpos = _currpos; //sets last currpos for avoiding stuk				
			
		if (_waiting < 0) then {
			//Gets distance to targetpos
			_targetdist = [_currPos,_targetPos] call KRON_distancePosSqr;	
			
			//Se evalua si se ha excedido el tiempo máximo de espera y el objetivo ya está abatido para retornar a la posición inicial.		
			if (_fightmode!="walk") then {
				if (_timeontarget > KRON_UPS_alerttime && count _targets <= 0 && ( isNull (_target) || !alive (_target) || captive _target)) then {
					_pursue = false;
					_gothit = false;
					_targetdead	= true;		
					_fightmode = "walk";
					_speedmode = _orgSpeed;						
					_targetPos = _currPos;
					_reinforcementsent = false;
					_nowp = _orignowp;
					_target = objnull;
					_fixedtargetPos = [0,0];			
					_Behaviour = _orgMode;					
					_waiting = -1;	
					_unitpos = "AUTO";	
					_wpformation = "WEDGE";						

					KRON_UPS_reinforcement = false; //ya no hay amenaza
					if (_rfid > 0 ) then {
						call (compile format ["KRON_UPS_reinforcement%1 = false;",_rfid]);
					};
					
					{[_x,"AUTO"] spawn MON_setUnitPos; sleep 0.5;}	foreach units _npc;	
					_npc setBehaviour _orgMode;									
					
					if (KRON_UPS_Debug>0) then {player sidechat format["%1 Without objectives, leaving combat mode",_grpidx]};	
				};
			};	
			
			//if (KRON_UPS_Debug>0) then {player globalchat format["%1  _targetdist %2  atdist=%3 dist=%4",_grpidx, _targetdist, _area/8,_dist]};	
			// if not in combat and we're either close enough, seem to be stuck, or are getting damaged, so find a new target 
			if (!_nowp && (!_gothit) && (!_swimming) && (_fightmode == "walk") && (( _targetdist <= (_area/4) || moveToFailed _npc) && (_timeontarget > KRON_UPS_maxwaiting))) then {
				_makenewtarget=true;
				_unitpos = "AUTO";
				_Behaviour = _orgMode;
			};

			// make new target
			if (_makenewtarget) then 
			{			
				_gothit=false;
				_react = 0;		
				_lastreact = 0;	
				_makenewtarget = false;				
				_timeontarget = 0;
				_wptype = "MOVE";			
			
				if (format ["%1",_fixedtargetPos] !="[0,0]") then {	
					_targetPos = _fixedtargetPos; 
					_targettext = "Reinforcement";					
				}else{				
					if (KRON_UPS_Debug>0) then {player sidechat format["%1 Patrol to new position",_grpidx]};	
					if ((_nomove=="NOMOVE") && (_timeontarget>KRON_UPS_alerttime)) then {
						if (([_currPos,_orgPos] call KRON_distancePosSqr) < _closeenough) then {
							_newpos = false;
							_wptype = "HOLD";
							_waiting = 9999;
							if (_fortify) then {
								_minreact = KRON_UPS_minreact * 3;
								_buildingdist = _buildingdist * 2;
								_wait = 3000;								
							};							
						} else {
							_targetPos=_orgPos; _targettext ="_orgPos";
						};
					} else {
						// re-read marker position/size
						_centerpos = getMarkerPos _areamarker; 
						_centerX = abs(_centerpos select 0);
						_centerY = abs(_centerpos select 1);
						_centerpos = [_centerX,_centerY];

						_areasize = getMarkerSize _areamarker; 
						_rangeX = _areasize select 0; 
						_rangeY = _areasize select 1;
						_areadir = (markerDir _areamarker) * -1;

						// find a new target that's not too close to the current position
						_targetPos=_currPos; 
						_targettext ="newTarget";

						//_tries=0;
						//while {((([_currPos,_targetPos] call KRON_distancePosSqr) < _mindist)) && (_tries<20)} do {
						//	_tries= _tries + 1;
						//	// generate new target position (on the road)
						//	_road=0;
						//	while {_road < 20} do {
						//		_targetPos = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos; 
						//		_road = [_targetPos,(_isplane||_isboat),_road] call KRON_OnRoad;
						//		sleep 0.5;
						//	};
						//	sleep 0.5;
						//};

						_targetPos = [_areamarker, "onground"] call WC_fnc_createpositioninmarker;

						//_nearroad = false;
						//_tries = 0;
						//while { !_nearroad && _tries < 20 } do {
						//	if ([_currPos,_targetPos] call KRON_distancePosSqr < _mindist) then {
						//		_targetPos = [_centerX,_centerY,_rangeX,_rangeY,_cosdir,_sindir,_areadir] call KRON_randomPos; 
						//		_nearroad = [_targetPos] call KRON_OnRoad2;
						//	};
						//	_tries = _tries + 1;
						//	sleep 0.5;
						//};
					};
				};

				// distance to target position		
				_avoidPos = [0,0]; 
				_flankPos = [0,0]; 
				_attackPos = [0,0];
				_frontPos = [0,0];			
				_fm=0;				
				_newpos=true;								
			};
		};			
	};	

	// if in water, get right back out of it again
	if (surfaceIsWater _currPos) then {
		if (_isman && !_swimming) then {
			_drydist=999;
			// look around, to find a dry spot
			for [{_a=0}, {_a<=270}, {_a=_a+90}] do {
				_dp=[_currPos,30,_a] call KRON_relPos; 
				if !(surfaceIsWater _dp) then {_targetPos=_dp};				
			};
			_newpos=true; 
			_swimming=true;
		};
	} else {
		_swimming=false;
	};

	sleep 0.5;
	

//**********************************************************************************************************************
//   								NEWPOS:	SE	EJECUTA		LA	ORDEN 	DE 	MOVIMIENTO
//**********************************************************************************************************************
	if ((_waiting<=0) && _newpos) then {		

		_npc = leader _group;	
		//_npc = [_npc,_members] call MON_getleader;									
		//if (!alive _npc || !canmove _npc || isplayer _npc ) exitwith {_exit=true;};	
		
		_currPos = getpos _npc;		
		_newpos = false;
		_waiting = -1; 	
		_swimming=false;			
		_GetIn_NearestVehicles = false;	
		
		//Gets distance to targetpos
		_targetdist = [_currPos,_targetPos] call KRON_distancePosSqr;		
	
		//If gothit and not in vehicle
		if (_gothit && _npc == vehicle (_npc) && alive _npc ) then {																
			//Unidad suprimida		
			if ((random 100) < 50) then {				
		
				//La unidad está suprimida, borramos el waypoint actual
				_supressed = true;						
				_targetPos = _currPos;	
				_targettext ="SUPRESSED";
				_wptype = "HOLD";
			
				// Units go to ground and do supress fire
				{
					//Se anula el movimiento
					if ( _x iskindof "Man" && canmove _x && alive _x) then {																		
						if ((random 100) < 40 || (primaryWeapon _x ) in KRON_UPS_MG_WEAPONS) then {
							[_x,"DOWN", random(20)] spawn MON_setUnitPosTime;			
						} else {
							[_x,"Middle"] spawn MON_setUnitPos;
						};
					};
					sleep 0.5;
				} foreach units _npc;	
				sleep 0.05;					
				
				// Units go away! 
				if ((random 100) <= 60 && morale _npc < 0) then {	
					_targetPos = _avoidPos;
					_targettext = "_avoidPos";
					_wptype = "MOVE";
					_flankdir = 0;	
				};
			};
			
			// units do a roll on the ground
			{ 				
				if ( (random 100) < 20) then {													
					_x spawn MON_animCroqueta;														
				};
				sleep 0.5;		
			} foreach units _npc;				
			
			// throw a grenade
			if ((random 100) > 70) then {		
				[_npc,_target] call MON_throw_grenade;
			};
			sleep 0.5;				
		};
		
		_npc = leader _group;

		//Si no ha sido suprimida continuamos el avance
		if (alive _npc) then {
			_currPos = getpos _npc;			
								
			if ( _wptype == "MOVE") then {
				
				//Try to avoid stucked soldiers out of vehicles
				if ( _npc == vehicle _npc) then {
					{
						if (alive _x && canmove _x) then {
							[_x] dofollow _npc;
						};
						sleep 0.5;
					}foreach (units _group);
				};
				sleep 0.05;	
				
				//Search for vehicle			
				if (!_gothit && _targetdist >= ( KRON_UPS_searchVehicledist )) then {							
					if ( vehicle _npc == _npc && _dist > _closeenough ) then {												
					
						 _unitsIn = [_grpid,_npc] call MON_GetIn_NearestVehicles;		
						 
						if ( count _unitsIn > 0) then {	
							_GetIn_NearestVehicles = true;
							_speedmode = "FULL";	
							_unitpos = "AUTO";	
							_npc setbehaviour "CARELESS";
							_npc setspeedmode "FULL";
							_timeout = time + 60;
							
							_vehicle = objnull;
							_vehicles = [];
							{ 
								waituntil {vehicle _x != _x || !canmove _x || !canstand _x || !alive _x || time > _timeout || movetofailed _x}; 
								
								if ( vehicle _x != _x && (isnull _vehicle || _vehicle != vehicle _x)) then {
									_vehicle = vehicle _x ;
									_vehicles = _vehicles + [_vehicle]
								};
								sleep 0.5;							
							}foreach _unitsIn;
											
							sleep 1;							
							{
								_vehicle = _x;
								_cargo = _vehicle getvariable ("UPSMON_cargo");
								if ( isNil("_cargo")) then {_cargo = [];};	
								_cargo ordergetin true;
								
								//Wait for other groups to getin								
								{ 
									waituntil {vehicle _x != _x || !canmove _x || !canstand _x || !alive _x || time > _timeout || movetofailed _x}; 
									sleep 0.5;
								}foreach _cargo;	
								
								//Starts gunner control
								[_vehicle] spawn MON_Gunnercontrol;
								
								//Resets vehicle id and cargo
								_vehicle setVariable ["UPSMON_grpid", 0, false];	
								_vehicle setVariable ["UPSMON_cargo", [], false];
								sleep 0.5;
							} foreach _vehicles;
							
							_npc = leader _group;
							if ( "Air" countType [vehicle (_npc)]>0) then {											
								_rnd = (random 2) * 0.1;
								_flyInHeight = round(KRON_UPS_flyInHeight * (0.9 + _rnd));
								vehicle _npc flyInHeight _flyInHeight;
								
								//Si acaba de entrar en el heli se define punto de aterrizaje
								if (_GetIn_NearestVehicles) then { 
									_GetOutDist = round(((KRON_UPS_paradropdist )  * (random 100) / 100 ) + 150);
									[vehicle _npc, _TargetPos, _GetOutDist,_flyInHeight] spawn MON_doParadrop;
									//Execute control stuck for helys
									[vehicle _npc] spawn MON_HeliStuckcontrol;
									//if (KRON_UPS_Debug>0 ) then {player sidechat format["%1: flyingheiht=%2 paradrop at dist=%3",_grpidx, _flyInHeight, _GetOutDist,_rnd]}; 
								};				
							};							
						};					
					};
				};
			};	
			sleep 0.05;	
			
			//Get in combat vehicles
			if (!_gothit && !_GetIn_NearestVehicles && _fightmode != "walk" ) then {					
				_dist2 = _dist / 4;
				if ( _dist2 <= 100 ) then {
					_unitsIn = [];					
					_unitsIn = [_grpid,_npc,_dist2,false] call MON_GetIn_NearestCombat;	
					_timeout = time + (_dist2/2);
				
					if ( count _unitsIn > 0) then {							
						if (KRON_UPS_Debug>0 ) then {player sidechat format["%1: Geting in combat vehicle targetdist=%2",_grpidx,_npc distance _target]}; 																						
						_npc setbehaviour "CARELESS";
						_npc setspeedmode "FULL";						
						
						{ 
							waituntil {vehicle _x != _x || !canmove _x || !canstand _x || !alive _x || time > _timeout || movetofailed _x}; 
							sleep 0.5;
						}foreach _unitsIn;
						
						_npc = leader _group;
					
						//Return to combat mode
						_npc setbehaviour _Behaviour;	
						_timeout = time + 180;
						{ 
							waituntil {vehicle _x != _x || !canmove _x || !alive _x || time > _timeout || movetofailed _x}; 
							sleep 0.5;
						}foreach _unitsIn;
						
						{								
							if ( vehicle _x  iskindof "Air") then {
								//moving hely for avoiding stuck
								if (driver vehicle _x == _x) then {
									_vehicle = vehicle (_x);									
									[_vehicle,1000] spawn MON_domove;	
									//Execute control stuck for helys
									[_vehicle] spawn MON_HeliStuckcontrol;
									if (KRON_UPS_Debug>0 ) then {player sidechat format["%1: Geting in combat vehicle after",_grpidx,_npc distance _target]}; 	
								};									
							};
							
							if (driver vehicle _x == _x) then {
								//Starts gunner control
								[vehicle _x] spawn MON_Gunnercontrol;								
							};
							sleep 0.5;
						}foreach _unitsIn;									
					};	
					sleep 0.05;
				};
			};
			
			_npc = leader _group;		
			
			//If use statics are enabled leader searches for static weapons near.
			if (KRON_UPS_useStatics && (vehicle _npc == _npc) && !_GetIn_NearestVehicles && ((_wptype == "HOLD" && (random 100) < 80) || (_wptype != "HOLD" && (random 100) < 60))) then {
			
				 _unitsIn = [_grpid,_npc,_buildingdist] call MON_GetIn_NearestStatic;			
				
				if ( count _unitsIn > 0) then {									
					_npc setbehaviour "CARELESS";
					_npc setspeedmode "FULL";					
					_timeout = time + 60;
			
					{ 
						waituntil {vehicle _x != _x || !canmove _x || !alive _x || time > _timeout || movetofailed _x}; 
						sleep 0.5;
					}foreach _unitsIn;
					
				};
				sleep 0.05;
			};		

			_npc = leader _group;		
			
			//Buildings usage.
			if (!_GetIn_NearestVehicles) then {
				if ( _wptype == "HOLD" && vehicle _npc == _npc && ( _fortify ||(random 100) < 60) ) then {
					//if (KRON_UPS_Debug>0) then {player sidechat format["%1: Moving to nearest buildings",_grpidx]}; 
					[_npc,_buildingdist,false,_wait] spawn MON_moveNearestBuildings;				
				} else {				
					//If we are close enough patrol in buildings for searching enemies
					if ((( _wptype != "HOLD" && vehicle _npc == _npc && (random 100) < 90  ) 
						&& _npc == vehicle _npc && _dist <= ( _closeenough ))) then {
						[_npc,_buildingdist,true] spawn MON_moveNearestBuildings;
					};		
				};
				sleep 0.05;	
			};			
			
			_npc = leader _group;				
							
			_index = currentWaypoint _group;	
			
			//Si el waypoing es distinto del que tiene o es diferente de hold lo establecemos
			IF (_wptype != "HOLD" || _lastwptype != _wptype) then {														
				//No haq waypoints  o están completados
				//_index = 1 Waypoint por defecto, no usar.	
				if ( _index == 1 || _index > count waypoints _group && !isnull _group) then {		
					_wp = _group addWaypoint [_targetPos, 0];									
					_index = _wp select 1;															
					//if (KRON_UPS_Debug>0) then {player sidechat format["%1: created wp %2 index %3",_grpidx,_wp, _index]}; 						
				} else {					
					_wp = [_group,_index];
					//if (KRON_UPS_Debug>0) then {player globalchat format["%1: not created wp %2 index %3 %4",_grpidx,_wp, _index,_targetPos]}; 
				};				
			};										
			
			_wp = [_group,_index];
		
			//Definimos los parámetros del nuevo waypoint				
			_wp  setWaypointType _wptype;						
			_wp  setWaypointPosition [_targetPos, 0];					
			_wp  setWaypointFormation _wpformation;		
			_wp  setWaypointSpeed _speedmode;	
			_lastwptype = _wptype;						 				

			 //Si tiene más de 2 waypoints borramos los obsoletos		
			{	
				if ( _x select 1 < _index ) then {
					deleteWaypoint _x;
				};
				sleep 0.5;		
			}foreach waypoints _group;		
			sleep 0.05;		
							
			//if (KRON_UPS_Debug>0) then {diag_log format["%1: waypoints %2 %3 %4 %5",_grpidx,count waypoints _group, _group, group _npc, group (leader _npc)]}; 											
			
			//Sets behaviour
			if (toupper(behaviour _npc) != toupper (_Behaviour)) then {
				_npc setBehaviour _Behaviour;	
			};						
			
			//Refresh position vector
			KRON_targetsPos set [_grpid,_targetPos];								
		
			//Aunque haya predefinido un tipo de movimiento se dejará un pequeño porcentaje para variar a nivel individual
			{
				if ((random 100)<95 && _x == vehicle _x && _x iskindof "Man" && !((primaryWeapon _x ) in KRON_UPS_MG_WEAPONS)) then {
					[_x,_unitpos] spawn MON_setUnitPos;
				}else{
					[_x,"AUTO"] spawn MON_setUnitPos;
				};
				sleep 0.5;
			} foreach units _npc;	
						
			
			//If closeenough will leave some soldiers doing supress fire
			if (_gothit || _dist <= _closeenough) then {
				{
					if (!canStand _x || ((primaryWeapon _x ) in KRON_UPS_MG_WEAPONS) || (vehicle _x == _x && _x iskindof "Man" && (random 100) < 50) ) then {						
						_x suppressFor random(20);
					};
					sleep 0.5;
				} foreach units _npc;									
			};							
		};						
		
	
		_gothit=false;
	};//if ((_waiting<=0) && _newpos) then {	

	if (_track=="TRACK") then { 
		switch (_fm) do {
			case 1: 
				{_destname setmarkerSize [.4,.4]};
			case 2: 
				{_destname setmarkerSize [.6,.6]};
			default
				{_destname setmarkerSize [.5,.5]};
		};
		_destname setMarkerPos _targetPos;				

	};
	
	//If in hely calculations must done faster
	if (_isplane || _inheli) then {_currcycle = _cycle/2};
	
	if (_exit) then {
		_loop=false;
	} else {
		// slowly increase the cycle duration after an incident
		sleep _currcycle;
	};	
}; 


if (KRON_UPS_Debug>0) then {hint format["%1 exiting mainloop",_grpidx]};	

//Limpiamos variables globales de este grupo
KRON_targetsPos set [_grpid,[0,0]];
KRON_NPCs set [_grpid,objnull];
KRON_UPS_Exited=KRON_UPS_Exited+1;

if (_track=="TRACK") then {
	//_trackername setMarkerType "Dot";
	_trackername setMarkerType "Empty";
	_destname setMarkerType "Empty";
};

//Gets dist from orinal pos
if (!isnull _target) then {
	_dist = ([_orgpos,position _target] call KRON_distancePosSqr);	
};
if (KRON_UPS_Debug>0) then {player sidechat format["%1 _dist=%2 _closeenough=%3",_grpidx,_dist,_closeenough]};		

_friends=nil;
_enemies=nil;
_friendlytanks = nil;
_roads = nil;
_targets = nil;
_members = nil;
_membertypes = nil;
_UCthis = nil;


if(true) exitWith {}; 