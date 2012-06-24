	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  Client Side logic

	if (isDedicated) exitWith {};
	if (side player != west) exitWith {};

	private [
		"_position", 
		"_magazines",
		"_weapons",
		"_primw",
		"_muzzles",
		"_arrayplayers"
		];

	// Init global variables
	wcgarbage = [] call WC_fnc_commoninitconfig;
	wcgarbage = [] call WC_fnc_clientinitconfig;

	wcanim = [] spawn WC_fnc_intro;

	// initialize musics
	wcjukebox = [] call WC_fnc_enummusic;

	// Grab all WC_fnc_publicvariable events
	wcgarbage = [] spawn WC_fnc_eventhandler;
	wcgarbage = [] spawn WC_fnc_playerhandler;

	sleep 1;

	// notify server that player is ready
	wcplayerreadyadd = name player;
	["wcplayerreadyadd", "server"] call WC_fnc_publicvariable;

	// intialize light depending weather
	if(wcwithlight == 1) then {
		wcgarbage = [] spawn WC_fnc_light;
	};

	waitUntil {!isNull player};
	waituntil {format ["%1", typeof player] != 'any'}; 
	player setpos getmarkerpos "respawn_west";

	if (format ["%1", wcselectedzone] == "any") then {wcselectedzone = [0,0,0];};

	// By default wc uses R3F revive
	if(true) then {
		execVM "extern\R3F_revive\revive_init.sqf";
	} else {
		R3F_REV_nb_reanimations = 0;
		player addEventHandler ["killed", { wcgarbage = [] spawn WC_fnc_onkilled}];
	};

	// Load player HUD
	wcgarbage = [] spawn WC_fnc_lifeslider;

	_marker = ['rescue', 0.01, [0,0,0], 'ColorRed', 'ICON', 'FDIAGONAL', 'Selector_selectedMission', 0, '', false] call WC_fnc_createmarkerlocal;
	wcgarbage = [_marker] spawn WC_fnc_markerhintlocal;

	wcrespawnmarker = ['respawn', 0.5, [0,0,0], 'ColorRed', 'ICON', 'FDIAGONAL', 'Camp', 0, format["%1 Camp", name player], false] call WC_fnc_createmarkerlocal;
	wcrespawnmarker setmarkersize [0,0];

	// arcade == 1
	if(wckindofgame == 1) then {
		wcgarbage = ["Hospital", getmarkerpos "hospital"] spawn BIS_fnc_3dcredits;
		wcgarbage = ["Weapons", getmarkerpos "crate1"] spawn BIS_fnc_3dcredits;
		if(wcautoloadweapons == 1) then {
			wcgarbage = ["Addons Weapons", getmarkerpos "autoloadcrate"] spawn BIS_fnc_3dcredits;
		};
		wcgarbage = ["Presets", position preset] spawn BIS_fnc_3dcredits;
		wcgarbage = ["Repair center", getmarkerpos "repair"] spawn BIS_fnc_3dcredits;
		wcgarbage = ["Recruitment", getmarkerpos "recruit1"] spawn BIS_fnc_3dcredits;
		wcgarbage = ["Hall of fames", getpos teammanage] spawn BIS_fnc_3dcredits;
		wcgarbage = ["Clothes", getmarkerpos "clothes"] spawn BIS_fnc_3dcredits;
		wcgarbage = ["Jail", getmarkerpos "jail"] spawn BIS_fnc_3dcredits;
		wcgarbage = ["Headquarters", getpos anim] spawn BIS_fnc_3dcredits;
		wcgarbage = ["Ied training", getpos iedtraining] spawn BIS_fnc_3dcredits;
	};

	// create a light in takistan base
	if!(isnull tower1) then {
		_light = "#lightpoint" createVehiclelocal (position tower1); 
		_light setLightBrightness 0.4; 
		_light setLightAmbient[0.0, 0.0, 0.0]; 
		_light setLightColor[1.0, 1.0, 1.0]; 
		_light lightAttachObject [tower1, [0,0,15]];
	};

	_end = createTrigger["EmptyDetector", wcmapcenter];
	_end setTriggerArea[10, 10, 0, false];
	_end setTriggerActivation["CIV", "PRESENT", TRUE];
	_end setTriggerStatements["(wcteamscore < wcscorelimitmin)", "
		wcanim = [] execVM 'warcontext\camera\WC_fnc_outrolooser.sqf';
	", ""];

	_end2 = createTrigger["EmptyDetector", wcmapcenter];
	_end2 setTriggerArea[10, 10, 0, false];
	_end2 setTriggerActivation["CIV", "PRESENT", TRUE];
	_end2 setTriggerStatements["(wcteamscore > wcscorelimitmax)", "
		wcanim = [] execVM 'warcontext\camera\WC_fnc_outro.sqf';
	", ""];

	_end3 = createTrigger["EmptyDetector", wcmapcenter];
	_end3 setTriggerArea[10, 10, 0, false];
	_end3 setTriggerActivation["CIV", "PRESENT", TRUE];
	_end3 setTriggerStatements["(wclevel > (wclevelmax - 1))", "
		wcanim = [] execVM 'warcontext\camera\WC_fnc_outro.sqf';
	", ""];


	// Trigger for menu options
	_trgmenuoption = createTrigger["EmptyDetector" , position player];
	_trgmenuoption setTriggerArea [0, 0, 0, false];
	_trgmenuoption setTriggerActivation ["NONE", "PRESENT", true];
	_trgmenuoption setTriggerTimeout [5, 5, 5, false];
	_trgmenuoption setTriggerStatements[
	"vehicle player != player", 
	"wcvehicle = vehicle player; 
	wcactionmenuoption = wcvehicle addAction ['<t color=''#ff4500''>Mission Info</t>', 'warcontext\dialogs\WC_fnc_createmenumissioninfo.sqf',[],-1,false]; wcgarbage = [] spawn WC_fnc_checkpilot; enableEnvironment false;", 
	"wcvehicle removeAction wcactionmenuoption; if(wcwithenvironment == 1) then { enableEnvironment true;};"];

	// Init GUI
	player addaction ["<t color='#ff4500'>Mission Info</t>","warcontext\dialogs\WC_fnc_createmenumissioninfo.sqf",[],-1,false];
	player addAction ["<t color='#dddd00'>"+localize "STR_WC_MENUDEPLOYTENT"+"</t>", "warcontext\actions\WC_fnc_dobuildtent.sqf",[],-1,false];
	player addAction ["<t color='#dddd00'>"+localize "STR_WC_MENUBUILDTRENCH"+"</t>", "warcontext\actions\WC_fnc_dodigtrench.sqf",[],-1,false];

	if (typeOf player in wcengineerclass) then {
		player addaction ["<t color='#dddd00'>"+localize "STR_WC_MENUREPAIRVEHICLE"+"</t>","warcontext\actions\WC_fnc_dorepairvehicle.sqf",[],-1,false];
		player addaction ["<t color='#dddd00'>"+localize "STR_WC_MENUUNLOCKVEHICLE"+"</t>","warcontext\actions\WC_fnc_dounlockvehicle.sqf",[],-1,false];
		player addaction ["<t color='#dddd00'>"+localize "STR_WC_MENUUNFLIPVEHICLE"+"</t>","warcontext\actions\WC_fnc_dounflipvehicle.sqf",[],-1,false];
	};

	[] spawn {
		private ["_oldlevel", "_ranked"];

		if(wckindofgame == 1) then {
			_ranked = [
				-60,
				-40,
				-20,
				0,
				20, 
				40,
				60,
				80
			];
		} else {
			_ranked = [
				-15,
				-10,
				-5,
				0,
				5, 
				10,
				15,
				20
			];
		};
		
		_oldlevel = 5;
		while { true } do {
			wcteamlevel = 8;
			if(wcteamscore >= (_ranked select 1)) then { wcteamlevel = 7;};
			if(wcteamscore >= (_ranked select 2)) then { wcteamlevel = 6;};
			if(wcteamscore >= (_ranked select 3)) then { wcteamlevel = 5;};
			if(wcteamscore >= (_ranked select 4)) then { wcteamlevel = 4;};
			if(wcteamscore >= (_ranked select 5)) then { wcteamlevel = 3;};
			if(wcteamscore >= (_ranked select 6)) then { wcteamlevel = 2;};
			if(wcteamscore >= (_ranked select 7)) then { wcteamlevel = 1;};
			if (_oldlevel != wcteamlevel) then {
				if (_oldlevel > wcteamlevel) then {
					_oldlevel = wcteamlevel;
					playsound "drum";
					_teampromote = localize format["STR_WC_TEAM%1", wcteamlevel];
					_message =[localize "STR_WC_MESSAGETEAMPROMOTED", format["to %1 !", _teampromote]];
					_message spawn EXT_fnc_infotext;
				} else {
					_oldlevel = wcteamlevel;
					playsound "drum";
					_teampromote = localize format["STR_WC_TEAM%1", wcteamlevel];
					_message =[localize "STR_WC_MESSAGETEAMDEGRADED", format["to %1 !", _teampromote]];
					_message spawn EXT_fnc_infotext;
				};
			};
			sleep 5;
		};
	};
	
	// add GPS
	removeBackpack player;

	[] execVM "warcontext\WC_fnc_loadweaponsplayer.sqf";
	[] execVM "warcontext\WC_fnc_creatediary.sqf";

	player addweapon "ITEMGPS";
	player addweapon "Binocular";
	player addweapon "ItemRadio";

	if(wcwithACE == 1) then {
		player addweapon "ACE_Earplugs";
	};

	wcgarbage = [(getmarkerpos "crate1"), "base"] spawn WC_fnc_createammobox;
	if(wcautoloadweapons == 1) then {
		wcgarbage = [(getmarkerpos "autoloadcrate"), "addons"] spawn WC_fnc_createammobox;
	};

	if(wcwithmarkers == 1) then {
		wcgarbage = [] spawn WC_fnc_playersmarkers;
		wcgarbage = [] spawn WC_fnc_vehiclesmarkers;
	};

	// syncrhonize players rank
	{
		(_x select 0) setrank (_x select 1);
	}foreach wcranksync;

	[] spawn {
		while { true } do {
			if (rating player < 0) then {
				if(driver(vehicle player) == player) then {
					player addrating (rating player * -1);
					wcgarbage = ["You have got a blame"] call BIS_fnc_dynamicText;
					wctk = name player;
					["wctk", "server"] call WC_fnc_publicvariable;
				};
			} else {
				if(rating player < 3000) then {
					player addrating 3000;
				};
			};
			sleep 4;
		};
	};

	// PERSONNAL RANK
	wcgarbage = [] spawn WC_fnc_playerranking;

	// BASE HOSPITAL
	[] spawn {
		while { true } do {
			if((position player) distance (getmarkerpos "hospital") < 5) then {
				_message =["You retrieve","all your revives"];
				_message spawn EXT_fnc_infotext;
				R3F_REV_nb_reanimations = R3F_REV_CFG_nb_reanimations;
				player setdamage 0;
			};
			sleep 10;
		};
	};


	// TEAMPLAY BONUS
	[] spawn {
		while { true } do {
			{
				if((_x distance player < 100) and _x != player) then {
					wcbonus = wcbonus + 1;
				};
				sleep 0.01;
			}foreach playableUnits;
			if(wcbonus > 10000) then {
				_message =["You have win", "10 points Teamplay bonus"];
				_message spawn EXT_fnc_infotext;
				wcbonus = 0;
				wcplayeraddscore = [player, 10];
				["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
				wcclientlogs = wcclientlogs + ["Teamplay bonus: 10 personnal points"];
			};
			sleep 1;
		};
	};

	// TRANSFERT POINT
	[] spawn {
		// if not noteam server
		if(wckindofserver != 3) then {
			while { true } do {
				if(wcteamplayscore > 29) then {
					["Share points", format[localize "STR_WC_TRANSFERTPOINT",wcteamplayscore], "Give somes points to others players through the mission info menu when you think they do a good job.", 10] spawn WC_fnc_playerhint;
					sleep 10;
				} else {
					if(wcteamplayscore > 19) then {
						["Share points", format[localize "STR_WC_TRANSFERTPOINT",wcteamplayscore], "Give somes points to others players through the mission info menu when you think they do a good job.", 10] spawn WC_fnc_playerhint;
						sleep 30;
					} else {
						if(wcteamplayscore > 9) then {
							["Share points", format[localize "STR_WC_TRANSFERTPOINT",wcteamplayscore], "Give somes points to others players through the mission info menu when you think they do a good job.", 10] spawn WC_fnc_playerhint;
							sleep 60;
						} else {
							if(wcteamplayscore > 0) then {
								["Share points", format[localize "STR_WC_TRANSFERTPOINT",wcteamplayscore], "Give somes points to others players through the mission info menu when you think they do a good job.", 10] spawn WC_fnc_playerhint;
								sleep 120;
							} else {
								sleep 60;
							};
						};
					};
				};
			};
		};
	};

	[] spawn {
		private ["_idaction", "_count"];
		_count = 0;
		while { true } do {
			wcadmin = serverCommandAvailable "#kick";
			if(serverCommandAvailable "#kick") then {
				wcadmin = true;
			} else {
				if((name player) in wcteammembers) then {
					wcadmin = true;
				} else {
					wcadmin = false;
				};
			};

			if (wcadmin) then {
				if(isnil "wcspectate") then {
					wcspectate = player addAction ["<t color='#dddd00'>"+localize "STR_WC_MENUSPECTATOR"+"</t>", "extern\spect\specta.sqf",[],-1,false];
				};
				if(isnil "wccancelmission") then {
					wccancelmission = player addAction ["<t color='#dddd00'>"+localize "STR_WC_MENUCANCELMISSION"+"</t>", "warcontext\actions\WC_fnc_docancelmission.sqf",[],-1,false];
				};
				if((isnil "wcbombingsupport") and (wcbombingavalaible == 1)) then {
					wcbombingsupport = player addAction ["<t color='#dddd00'>"+localize "STR_WC_MENUBOMBING"+"</t>", "warcontext\actions\WC_fnc_dobombingrequest.sqf",[],-1,false];
				};
				if((isnil "wcmanageteam") and (wckindofserver != 3)) then {
					wcmanageteam = player addAction ["<t color='#dddd00'>Manage team</t>", "warcontext\dialogs\WC_fnc_createmenumanageteam.sqf",[],6,false];
				};
			} else {
				if!(isnil "wcspectate") then { player removeAction wcspectate;};
				if!(isnil "wccancelmission") then { player removeAction wccancelmission;};
				if!(isnil "wcbombingsupport") then { player removeAction wcbombingsupport;};
				if!(isnil "wcmanageteam") then { player removeaction wcmanageteam;};
				wcspectate = nil;
				wcbombingsupport = nil;
				wccancelmission = nil;
				wcmanageteam = nil;
			};
			sleep 5;
		};
	};

	[] spawn {
		private ["_unit"];
		while { true } do {
			_unit = cursorTarget;
			if((side _unit == civilian) and !(isplayer _unit)) then {
				if((_unit distance player < 6) and (alive _unit)) then {
					_unit setvehicleinit "this playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon'; removeAllWeapons this; dostop this;";
					processInitCommands;
					sleep 10;
				};
			};
			sleep 1;
		};
	};

	[] spawn {
		private ["_units", "_attached", "_animation", "_unit"];

		_attached = false;
		_animation = ["amovppnemstpsnonwnondnon_healed", "amovppnemstpsnonwnondnon_injured"];
		_count = 0;

		while { true } do {
			if!(_attached) then { 
				_units = nearestObjects[player,["Man"], 2];
				if(count _units == 2) then {
					{
						if((_x != player) and ((animationState _x) in _animation)) then {
							if(isnil "wcdragg") then {
								wcdragg = player addAction ["<t color='#dddd00'>Drag player</t>", "warcontext\actions\WC_fnc_dodrag.sqf",[],-1,false];
							};	
							if(wcdragged) then {
								player playMove "acinpknlmstpsraswrfldnon";
								_x attachTo [player,[0.1, 1.01, 0]];
								_attached = true;
								_unit = _x;
							};
						};
					}foreach _units;
				} else {
					player removeaction wcdragg;
					wcdragg = nil;
				};
			};
			if(_attached) then {
				_count = _count + 1;
			};
			if(_count > 10) then {
				wcdragged = false;
				_attached = false;
				detach _unit;
				_count = 0;
				player playAction "released";	
				sleep 2;				
			};
			sleep 1;
		};
	};

	// AUTOLOAD WARNING MESSAGES IF DESYNC WITH SERVER
	[] spawn {
		waituntil {format ["%1", wccfgpatches] != 'any'};
		wccfglocalpatches =  wccfgpatches;
		{
			if!(isClass (configfile >> "CfgPatches" >> _x)) then {
				player sidechat format[localize "STR_WC_MESSAGEMISSINGADDONS", _x];
				sleep 1;
			} else {
				wccfglocalpatches = wccfglocalpatches - [_x];
			};
		}foreach wccfglocalpatches;

		if(count wccfglocalpatches > 0) then {
			sleep 30;
			[localize "STR_WC_MESSAGEWARNING", localize "STR_WC_MESSAGERESTARTGAME", localize "STR_WC_MESSAGENOTSYNC", 60] spawn WC_fnc_playerhint;
		};
	};

	// IED DETECTOR
	[] spawn {
		private ["_objects"];
		while { true } do {
			_objects = nearestObjects [player, ["All"], 30];
			{
				if(_x getvariable "wciedactivate") then {
					if(vehicle player == player) then {
						if(player distance _x > 20) then {
							playsound "bombdetector2";	
						} else {
							if(player distance _x > 10) then {
								playsound "bombdetector3";
							} else {
								playsound "bombdetector1";
							};
						};
					};
				};
			}foreach _objects;
		sleep 1;
		};
	};

	// NUCLEAR ZONE - RADIATION
	if(wcwithnuclear == 1) then {
		[] spawn {
			while { true } do {
				{
					if((player distance _x < 500) and !wcplayerinnuclearzone) then {
						wcgarbage = [_x] spawn WC_fnc_createnuclearzone;
					};
				}foreach wcnuclearzone;
				sleep 1;
			};
		};
	};

	// EVERYBODY IS MEDIC
	if((wceverybodymedic == 1) and !(typeOf player in wcmedicclass)) then {
		[] spawn {
			private ["_injured", "_men"];
			wcmedicmenu = nil;
			while { true } do {
				_men = nearestObjects[player,["Man"], 5];
				_injured = objnull;
				{
					if((damage _x > 0.2) and !(_x == player)) then {
						_injured = _x;
					};
				}foreach _men;
				if(!(isnull _injured) and (isnil "wcmedicmenu"))  then {
					wcmedicmenu = player addAction ["<t color='#dddd00'>Heal</t>", "warcontext\actions\WC_fnc_doheal.sqf",[_injured],6,false];
				} else {
					if!(isnil "wcmedicmenu") then { player removeAction wcmedicmenu; wcmedicmenu = nil;};
				};
				sleep 5;
			};
		};
	};

	// if player die, end of game for one life mission
	if(wcwithonelife == 1) then {
		_end = createTrigger["EmptyDetector", [4000,4000,0]];
		_end setTriggerArea[10, 10, 0, false];
		_end setTriggerActivation["CIV", "PRESENT", TRUE];
		_end setTriggerStatements["!alive player && local player", "
			tskExample1 = player createSimpleTask ['Task Message'];
			tskExample1 setSimpleTaskDescription ['Task Message', 'You have been killed', 'You have been killed'];
			wctoonelife = name player;
			['wctoonelife', 'server'] call WC_fnc_publicvariable;
		", ""];
		_end setTriggerType "END1";

		[] spawn {
			while { true } do {
				if((name player) in wconelife) then {
					removeallweapons player;
					removeallItems player;
				};
				sleep 10;
			};
		};
	};

	sleep 5;

	switch (wckindofgame) do {
		case 1: {
			_kindofgame = "arcade";
		};

		case 2: {
			_kindofgame = "simulation";	
		};

		case 3: {
			_kindofgame = "cheated";
		};
	};

	["Welcome to base", "Take some weapons at ammobox and wait for orders.", format["This mission is currently played as %1 game.", _kindofgame], 10] spawn WC_fnc_playerhint;


	// INITIALIZE PLAYER SCORE ON SERVER
	sleep 30;

	wcplayeraddscore = [player, -1];
	["wcplayeraddscore", "server"] call WC_fnc_publicvariable;

	wcclientlogs = wcclientlogs + [localize "STR_WC_MESSAGEMISSIONINITIALIZED"];