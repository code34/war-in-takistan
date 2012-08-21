	//////////////////////////////////////////////////////////////////////////
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description - Init
	//////////////////////////////////////////////////////////////////////////

	// DEVELOPPER - MAP 
	//
	// warcontext\ contains main scripts
	// warcontext\client\ contains the client side logic
	// warcontext\server\ contains the server side logic
	// warcontext\modules\ contains all standalone logics
	// warcontext\ressources\ contains all script that parse game ressources
	// warcontext\dialogs\ contains all script relative to menubox
	// warcontext\actions\ contains all script relative to addaction menu
	// warcontext\camera\ contains all script that happens camera
	// warcontext\functions\ contains all shared functions

	titleText [localize "STR_WC_MESSAGEINITIALIZING", "BLACK FADED"];

	////////////////////////////////
	// initialize lobby parameters
	////////////////////////////////

	for "_i" from 0 to (count paramsArray - 1) do {
		call compile format["%1=%2;", configName ((missionConfigFile >> "Params") select _i), paramsArray select _i];
		sleep 0.01;
	};

	// protection against player that come with ACE when doesn t need
	if(wcwithACE == 1) then {
		if!(isClass(configFile >> "cfgPatches" >> "ace_main")) then {
			if(isserver) then {				
				while { true } do { hint "Player without ACE:\n check your addons!"; diag_log "WARCONTEXT: DEDICATED SERVER - MISSING ACE ADDONS - WIT DOESNT START"; sleep 10;};
			} else {
				player setpos [0,0,0];
				removeAllItems player;
				removeAllWeapons player;
				player enablesimulation false;
				while { true } do { hint "Player without ACE:\n check your addons!"; sleep 1;};
			};
		};
	} else {
		if (isClass(configFile >> "cfgPatches" >> "ace_main")) then {
			if(isserver) then {
				while { true } do { hint "Player with ACE:\n check your addons!"; diag_log "WARCONTEXT: DEDICATED SERVER - USING ACE WITH NON ACE VERSION - WIT DOESNT START"; sleep 10;};
			} else {
				player setpos [0,0,0];
				removeAllItems player;
				removeAllWeapons player;
				player enablesimulation false;
				while { true } do { hint "Player with ACE:\n check your addons!"; sleep 1;};
			};
		};
	};

	// init R3F arty and logistic script
	[] spawn { execVM "extern\R3F_ARTY_AND_LOG\init.sqf"; };

	// init BON loadout script
	[] spawn { presetDialogUpdate = compile preprocessFile "extern\bon_loadoutpresets\bon_func_presetdlgUpdate.sqf"; };

	/////////////////////
	// EXTERNAL SCRIPTS
	/////////////////////

	EXT_fnc_atot 			= compile preprocessFile "extern\EXT_fnc_atot.sqf";
	EXT_fnc_createcomposition	= compile preprocessFile "extern\EXT_fnc_createcomposition.sqf";
	EXT_fnc_SortByDistance		= compile preprocessFile "extern\EXT_fnc_Common_SortByDistance.sqf";
	EXT_fnc_infotext		= compile preprocessFile "extern\EXT_fnc_infoText.sqf";
	WC_fnc_teamstatus		= compile preprocessFile "extern\TeamStatusDialog\TeamStatusDialog.sqf";

	//////////////////
	// CONFIG FILES
	//////////////////

	WC_fnc_commoninitconfig 	= compile preprocessFile "WC_fnc_commoninitconfig.sqf";

	// warcontext anim - camera
	WC_fnc_intro			= compile preprocessFile "warcontext\camera\WC_fnc_intro.sqf";
	WC_fnc_camfocus 		= compile preprocessFile "warcontext\camera\WC_fnc_camfocus.sqf";
	WC_fnc_credits			= compile preprocessFile "warcontext\camera\WC_fnc_credits.sqf";
	WC_fnc_outro			= compile preprocessFile "warcontext\camera\WC_fnc_outro.sqf";
	WC_fnc_outrolooser		= compile preprocessFile "warcontext\camera\WC_fnc_outrolooser.sqf";

	///////////////////////
	// RESOURCES PARSER
	///////////////////////

	WC_fnc_enumcfgpatches 		= compile preprocessFile "warcontext\ressources\WC_fnc_enumcfgpatches.sqf";
	WC_fnc_enumcompositions		= compile preprocessFile "warcontext\ressources\WC_fnc_enumcompositions.sqf";
	WC_fnc_enumfaction 		= compile preprocessFile "warcontext\ressources\WC_fnc_enumfaction.sqf";
	WC_fnc_enummagazines 		= compile preprocessFile "warcontext\ressources\WC_fnc_enummagazines.sqf";
	WC_fnc_enummusic 		= compile preprocessFile "warcontext\ressources\WC_fnc_enummusic.sqf";
	WC_fnc_enumvehicle 		= compile preprocessFile "warcontext\ressources\WC_fnc_enumvehicle.sqf";
	WC_fnc_enumweapons 		= compile preprocessFile "warcontext\ressources\WC_fnc_enumweapons.sqf";
	WC_fnc_enumvillages		= compile preprocessFile "warcontext\ressources\WC_fnc_enumvillages.sqf";

	/////////////////////
	// GLOBAL FUNCTIONS
	////////////////////

	WC_fnc_attachmarker 		= compile preprocessFile "warcontext\functions\WC_fnc_attachmarker.sqf";
	WC_fnc_attachmarkerlocal	= compile preprocessFile "warcontext\functions\WC_fnc_attachmarkerlocal.sqf";
	WC_fnc_attachmarkerinzone	= compile preprocessFile "warcontext\functions\WC_fnc_attachmarkerinzone.sqf";
	WC_fnc_backupbuilding		= compile preprocessFile "warcontext\functions\WC_fnc_backupbuilding.sqf";
	WC_fnc_checkpilot		= compile preprocessFile "warcontext\functions\WC_fnc_checkpilot.sqf";
	WC_fnc_clockformat 		= compile preprocessFile "warcontext\functions\WC_fnc_clockformat.sqf";
	WC_fnc_copymarker 		= compile preprocessFile "warcontext\functions\WC_fnc_copymarker.sqf";
	WC_fnc_copymarkerlocal 		= compile preprocessFile "warcontext\functions\WC_fnc_copymarkerlocal.sqf";
	WC_fnc_creategridofposition	= compile preprocessFile "warcontext\functions\WC_fnc_creategridofposition.sqf";
	WC_fnc_createmarker 		= compile preprocessFile "warcontext\functions\WC_fnc_createmarker.sqf";
	WC_fnc_createmarkerlocal	= compile preprocessFile "warcontext\functions\WC_fnc_createmarkerlocal.sqf";
	WC_fnc_createcircleposition	= compile preprocessFile "warcontext\functions\WC_fnc_createcircleposition.sqf";
	WC_fnc_createposition 		= compile preprocessFile "warcontext\functions\WC_fnc_createposition.sqf";
	WC_fnc_createpositionaround	= compile preprocessFile "warcontext\functions\WC_fnc_createpositionaround.sqf";
	WC_fnc_createpositioninmarker 	= compile preprocessFile "warcontext\functions\WC_fnc_createpositioninmarker.sqf";
	WC_fnc_deletemarker		= compile preprocessFile "warcontext\functions\WC_fnc_deletemarker.sqf";
	WC_fnc_exportweaponsplayer	= compile preprocessFile "warcontext\functions\WC_fnc_exportweaponsplayer.sqf";
	WC_fnc_garbagecollector		= compile preprocessFile "warcontext\functions\WC_fnc_garbagecollector.sqf";
	WC_fnc_getobject		= compile preprocessFile "warcontext\functions\WC_fnc_getobject.sqf";
	WC_fnc_getterraformvariance	= compile preprocessFile "warcontext\functions\WC_fnc_getterraformvariance.sqf";
	WC_fnc_markerhint		= compile preprocessFile "warcontext\functions\WC_fnc_markerhint.sqf";
	WC_fnc_markerhintlocal		= compile preprocessFile "warcontext\functions\WC_fnc_markerhintlocal.sqf";
	WC_fnc_missionname	 	= compile preprocessFile "warcontext\functions\WC_fnc_missionname.sqf";
	WC_fnc_loadweaponsplayer	= compile preprocessFile "warcontext\functions\WC_fnc_loadweaponsplayer.sqf";
	WC_fnc_playerhint		= compile preprocessFile "warcontext\functions\WC_fnc_playerhint.sqf";
	WC_fnc_sortlocationbydistance	= compile preprocessFile "warcontext\functions\WC_fnc_sortlocationbydistance.sqf";
	WC_fnc_refreshmarkers		= compile preprocessFile "warcontext\functions\WC_fnc_refreshmarkers.sqf";
	WC_fnc_relocatelocation		= compile preprocessFile "warcontext\functions\WC_fnc_relocatelocation.sqf";
	WC_fnc_relocateposition		= compile preprocessFile "warcontext\functions\WC_fnc_relocateposition.sqf";
	WC_fnc_restorebuilding 		= compile preprocessFile "warcontext\functions\WC_fnc_restorebuilding.sqf";
	WC_fnc_seed	 		= compile preprocessFile "warcontext\functions\WC_fnc_seed.sqf";
	WC_fnc_setskill 		= compile preprocessFile "warcontext\functions\WC_fnc_setskill.sqf";
	WC_fnc_weaponcanflare		= compile preprocessFile "warcontext\functions\WC_fnc_weaponcanflare.sqf";

	////////////////////////////////
	// WARCONTEXT STANDALONE MODULES 
	////////////////////////////////

	// AIR BOMBING
	WC_fnc_bomb			= compile preprocessFile "warcontext\modules\wc_airbombing\WC_fnc_bomb.sqf";

	// AIR PATROL
	WC_fnc_airpatrol 		= compile preprocessFile "warcontext\modules\wc_airpatrols\WC_fnc_airpatrol.sqf";
	WC_fnc_initairpatrol		= compile preprocessFile "warcontext\modules\wc_airpatrols\WC_fnc_initairpatrol.sqf";

	// AMMOBOX
	WC_fnc_createammobox 		= compile preprocessFile "warcontext\modules\wc_ammobox\WC_fnc_createammobox.sqf";
	WC_fnc_loadweapons		= compile preprocessFile "warcontext\modules\wc_ammobox\WC_fnc_loadweapons.sqf";

	// ANIMALS
	WC_fnc_createsheep		= compile preprocessFile "warcontext\modules\wc_animals\WC_fnc_createsheep.sqf";
	
	// ANTI AIR
	WC_fnc_antiair 			= compile preprocessFile "warcontext\modules\wc_antiair\WC_fnc_antiair.sqf";	

	// CIVIL CAR
	WC_fnc_createcivilcar 		= compile preprocessFile "warcontext\modules\wc_civilcars\WC_fnc_createcivilcar.sqf";	

	// CIVILIANS
	WC_fnc_altercation 		= compile preprocessFile "warcontext\modules\wc_civilians\WC_fnc_altercation.sqf";
	WC_fnc_buildercivilian		= compile preprocessFile "warcontext\modules\wc_civilians\WC_fnc_buildercivilian.sqf";
	WC_fnc_civilianinit 		= compile preprocessFile "warcontext\modules\wc_civilians\WC_fnc_civilianinit.sqf";
	WC_fnc_drivercivilian		= compile preprocessFile "warcontext\modules\wc_civilians\WC_fnc_drivercivilian.sqf";
	WC_fnc_healercivilian		= compile preprocessFile "warcontext\modules\wc_civilians\WC_fnc_healercivilian.sqf";
	WC_fnc_popcivilian		= compile preprocessFile "warcontext\modules\wc_civilians\WC_fnc_popcivilian.sqf";
	WC_fnc_propagand		= compile preprocessFile "warcontext\modules\wc_civilians\WC_fnc_propagand.sqf";
	WC_fnc_sabotercivilian 		= compile preprocessFile "warcontext\modules\wc_civilians\WC_fnc_sabotercivilian.sqf";
	WC_fnc_walkercivilian 		= compile preprocessFile "warcontext\modules\wc_civilians\WC_fnc_walkercivilian.sqf";	

	// COMPOSITIONS
	WC_fnc_createcomposition	= compile preprocessFile "warcontext\modules\wc_compositions\WC_fnc_createcomposition.sqf";

	// TOWN GENERATOR
	WC_fnc_computeavillage 		= compile preprocessFile "warcontext\modules\wc_computevillage\WC_fnc_computeavillage.sqf";

	// ENEMYS GROUPS
	WC_fnc_ambiantlife 		= compile preprocessFile "warcontext\modules\wc_enemygroups\WC_fnc_ambiantlife.sqf";
	WC_fnc_creategroup 		= compile preprocessFile "warcontext\modules\wc_enemygroups\WC_fnc_creategroup.sqf";
	WC_fnc_creategroupdefend	= compile preprocessFile "warcontext\modules\wc_enemygroups\WC_fnc_creategroupdefend.sqf";
	WC_fnc_creategroupsupport	= compile preprocessFile "warcontext\modules\wc_enemygroups\WC_fnc_creategroupsupport.sqf";

	// FAST TIME
	WC_fnc_fasttime			= compile preprocessFile "warcontext\modules\wc_fasttime\WC_fnc_fasttime.sqf";

	// GESTURE
	WC_fnc_dosillything		= compile preprocessFile "warcontext\modules\wc_gesture\WC_fnc_dosillything.sqf";
	
	// HANDLER
	WC_fnc_grouphandler		= compile preprocessFile "warcontext\modules\wc_handler\WC_fnc_grouphandler.sqf";
	WC_fnc_vehiclehandler 		= compile preprocessFile "warcontext\modules\wc_handler\WC_fnc_vehiclehandler.sqf";

	// HUD
	WC_fnc_lifeslider		= compile preprocessFile "warcontext\modules\wc_hud\WC_fnc_lifeslider.sqf";

	// IED
	WC_fnc_createied 		= compile preprocessFile "warcontext\modules\wc_ied\WC_fnc_createied.sqf";
	WC_fnc_createiedintown 		= compile preprocessFile "warcontext\modules\wc_ied\WC_fnc_createiedintown.sqf";
	WC_fnc_disarmied		= compile preprocessFile "warcontext\modules\wc_ied\WC_fnc_disarmied.sqf";
	WC_fnc_ieddetector		= compile preprocessFile "warcontext\modules\wc_ied\WC_fnc_ieddetector.sqf";

	// KEYMAPPER
	WC_fnc_keymapper		= compile preprocessFile "warcontext\modules\wc_keymapper\WC_fnc_keymapper.sqf";

	// LOADOUT	
	WC_fnc_saveloadout		= compile preprocessFile "warcontext\modules\wc_loadout\WC_fnc_saveloadout.sqf";
	WC_fnc_restoreloadout		= compile preprocessFile "warcontext\modules\wc_loadout\WC_fnc_restoreloadout.sqf";
	
	// MARKERS
	WC_fnc_playersmarkers		= compile preprocessFile "warcontext\modules\wc_markers\WC_fnc_playersmarkers.sqf";
	WC_fnc_vehiclesmarkers		= compile preprocessFile "warcontext\modules\wc_markers\WC_fnc_vehiclesmarkers.sqf";	

	// MINEFIELD
	WC_fnc_createminefield 		= compile preprocessFile "warcontext\modules\wc_minefield\WC_fnc_createminefield.sqf";
	
	// MORTAR
	WC_fnc_mortar		 	= compile preprocessFile "warcontext\modules\wc_mortar\WC_fnc_mortar.sqf";

	// MORTUARY
	WC_fnc_createmortuary		= compile preprocessFile "warcontext\modules\wc_mortuary\WC_fnc_createmortuary.sqf";

	// NUKE
	WC_fnc_createnuclearfire 	= compile preprocessFile "warcontext\modules\wc_nuke\WC_fnc_createnuclearfire.sqf";
	WC_fnc_createnuclearzone 	= compile preprocessFile "warcontext\modules\wc_nuke\WC_fnc_createnuclearzone.sqf";	
	WC_fnc_nuclearnuke		= compile preprocessFile "warcontext\modules\wc_nuke\WC_fnc_nuclearnuke.sqf";
	WC_fnc_radiationzone		= compile preprocessFile "warcontext\modules\wc_nuke\WC_fnc_radiationzone.sqf";

	// RANKING
	WC_fnc_playerranking		= compile preprocessFile "warcontext\modules\wc_ranking\WC_fnc_playerranking.sqf";
	WC_fnc_playerscore		= compile preprocessFile "warcontext\modules\wc_ranking\WC_fnc_playerscore.sqf";

	// RESPAWNABLE VEHICLE
	WC_fnc_respawnvehicle		= compile preprocessFile "warcontext\modules\wc_respawnvehicle\WC_fnc_respawnvehicle.sqf";

	// ROAD PATROL
	WC_fnc_createconvoy 		= compile preprocessFile "warcontext\modules\wc_roadpatrols\WC_fnc_createconvoy.sqf";

	// SABOTAGE
	WC_fnc_nastyvehicleevent	= compile preprocessFile "warcontext\modules\wc_sabotage\WC_fnc_nastyvehicleevent.sqf";	

	// SEA PATROL
	WC_fnc_createseapatrol		= compile preprocessFile "warcontext\modules\wc_seapatrols\WC_fnc_createseapatrol.sqf";
	WC_fnc_seapatrol 		= compile preprocessFile "warcontext\modules\wc_seapatrols\WC_fnc_seapatrol.sqf";

	// REPAIR ZONE
	WC_fnc_servicing 		= compile preprocessFile "warcontext\modules\wc_repairzone\WC_fnc_servicing.sqf";
	
	// STATIC WEAPONS
	WC_fnc_createstatic	 	= compile preprocessFile "warcontext\modules\wc_staticweapons\WC_fnc_createstatic.sqf";
	
	// SUPPORT
	WC_fnc_support	 		= compile preprocessFile "warcontext\modules\wc_support\WC_fnc_support.sqf";

	// TACTICAL OBJECTS
	WC_fnc_creategenerator 		= compile preprocessFile "warcontext\modules\wc_tacticalobjects\WC_fnc_creategenerator.sqf";
	WC_fnc_createradio	 	= compile preprocessFile "warcontext\modules\wc_tacticalobjects\WC_fnc_createradio.sqf";
	WC_fnc_createmhq	 	= compile preprocessFile "warcontext\modules\wc_tacticalobjects\WC_fnc_createmhq.sqf";

	// UNITS PATROL
	WC_fnc_patrol			= compile preprocessFile "warcontext\modules\wc_unitpatrols\WC_fnc_patrol.sqf";
	WC_fnc_protectobject		= compile preprocessFile "warcontext\modules\wc_unitpatrols\WC_fnc_protectobject.sqf";
	WC_fnc_sentinelle	 	= compile preprocessFile "warcontext\modules\wc_unitpatrols\WC_fnc_sentinelle.sqf";

	// UNITS ROLE
	WC_fnc_createmedic 		= compile preprocessFile "warcontext\modules\wc_unitsrole\WC_fnc_createmedic.sqf";
	WC_fnc_fireflare 		= compile preprocessFile "warcontext\modules\wc_unitsrole\WC_fnc_fireflare.sqf";

	// WEATHER
	WC_fnc_light			= compile preprocessFile "warcontext\modules\wc_weather\WC_fnc_light.sqf";
	WC_fnc_weather		 	= compile preprocessFile "warcontext\modules\wc_weather\WC_fnc_weather.sqf";

	/////////////////
	// END OF MODULES
	/////////////////

	///////////////////
	// WIT MAIN SCRIPTS
	///////////////////

	WC_fnc_creatediary		= compile preprocessFile "warcontext\WC_fnc_creatediary.sqf";
	WC_fnc_createlistofmissions	= compile preprocessFile "warcontext\WC_fnc_createlistofmissions.sqf";
	WC_fnc_createsidemission 	= compile preprocessFile "warcontext\WC_fnc_createsidemission.sqf";
	WC_fnc_debug			= compile preprocessFile "warcontext\WC_fnc_debug.sqf";
	WC_fnc_eventhandler 		= compile preprocessFile "warcontext\WC_fnc_eventhandler.sqf";
	WC_fnc_mainloop 		= compile preprocessFile "warcontext\WC_fnc_mainloop.sqf";
	WC_fnc_onkilled			= compile preprocessFile "warcontext\WC_fnc_onkilled.sqf";
	WC_fnc_restoreactionmenu	= compile preprocessFile "warcontext\WC_fnc_restoreactionmenu.sqf";

	//////////////
	// CLIENT SIDE
	//////////////
	WC_fnc_clientinitconfig 	= compile preprocessFile "warcontext\client\WC_fnc_clientinitconfig.sqf";
	WC_fnc_clienthandler		= compile preprocessFile "warcontext\client\WC_fnc_clienthandler.sqf";
	WC_fnc_clientside		= compile preprocessFile "warcontext\client\WC_fnc_clientside.sqf";
	
	//////////////
	// SERVER SIDE
	//////////////
	WC_fnc_publishmission		= compile preprocessFile "warcontext\server\WC_fnc_publishmission.sqf";
	WC_fnc_serverinitconfig 	= compile preprocessFile "warcontext\server\WC_fnc_serverinitconfig.sqf";
	WC_fnc_serverhandler 		= compile preprocessFile "warcontext\server\WC_fnc_serverhandler.sqf";
	WC_fnc_serverside 		= compile preprocessFile "warcontext\server\WC_fnc_serverside.sqf";

	////////////
	// MISSIONS
	////////////

	WC_fnc_bringunit		= compile preprocessFile "warcontext\missions\WC_fnc_bringunit.sqf";
	WC_fnc_bringvehicle		= compile preprocessFile "warcontext\missions\WC_fnc_bringvehicle.sqf";
	WC_fnc_build			= compile preprocessFile "warcontext\missions\WC_fnc_build.sqf";
	WC_fnc_defend			= compile preprocessFile "warcontext\missions\WC_fnc_defend.sqf";
	WC_fnc_destroygroup		= compile preprocessFile "warcontext\missions\WC_fnc_destroygroup.sqf";
	WC_fnc_heal			= compile preprocessFile "warcontext\missions\WC_fnc_heal.sqf";
	WC_fnc_jail			= compile preprocessFile "warcontext\missions\WC_fnc_jail.sqf";
	WC_fnc_liberatehotage 		= compile preprocessFile "warcontext\missions\WC_fnc_liberatehotage.sqf";
	WC_fnc_rescuecivil		= compile preprocessFile "warcontext\missions\WC_fnc_rescuecivil.sqf";
	WC_fnc_rob			= compile preprocessFile "warcontext\missions\WC_fnc_rob.sqf";
	WC_fnc_steal	 		= compile preprocessFile "warcontext\missions\WC_fnc_steal.sqf";
	WC_fnc_sabotage	 		= compile preprocessFile "warcontext\missions\WC_fnc_sabotage.sqf";
	WC_fnc_securezone 		= compile preprocessFile "warcontext\missions\WC_fnc_securezone.sqf";


	///////////////////////////////////////////
	//	INITIALIZE NOW
	//////////////////////////////////////////

	waituntil {!isnil "bis_fnc_init"};

	wcgarbage = [] call WC_fnc_commoninitconfig;

	/////////////////////////////////////////////////////////////////
	//	CLIENT SIDE
	/////////////////////////////////////////////////////////////////

	if (local player) then { wcgarbage = [] spawn WC_fnc_clientside;};

	/////////////////////////////////////////////////////////////////
	//	SERVER SIDE
	/////////////////////////////////////////////////////////////////

	if (isserver) then { wcgarbage = [] spawn WC_fnc_serverside;};