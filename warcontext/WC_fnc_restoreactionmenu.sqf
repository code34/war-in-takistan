	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - restore menu action when player died
	// -----------------------------------------------

	#include "common.hpp"

	if (isDedicated) exitWith {};

	// Default menu
	player addaction ["<t color='#ff4500'>Mission Info</t>","warcontext\WC_fnc_domissioninfo.sqf",[],-1,false];
	player addAction ["<t color='#dddd00'>"+localize "STR_WC_MENUDEPLOYTENT"+"</t>", "warcontext\WC_fnc_dobuildtent.sqf",[],-1,false];
	player addAction ["<t color='#dddd00'>"+localize "STR_WC_MENUBUILDTRENCH"+"</t>", "warcontext\WC_fnc_dodigtrench.sqf",[],-1,false];

	// Engineer menu
	if (typeOf player in wcengineerclass) then {
		player addaction ["<t color='#dddd00'>"+localize "STR_WC_MENUREPAIRVEHICLE"+"</t>","warcontext\WC_fnc_repairvehicle.sqf",[],-1,false];
		player addaction ["<t color='#dddd00'>"+localize "STR_WC_MENUUNLOCKVEHICLE"+"</t>","warcontext\WC_fnc_unlockvehicle.sqf",[],-1,false];
		player addaction ["<t color='#dddd00'>Unflip Vehicle</t>","warcontext\WC_fnc_unflipvehicle.sqf",[],-1,false];
	};

	// Admin menu
	wcadmin = serverCommandAvailable "#kick";
	if (wcadmin) then {
		wcbombingsupport = nil;
		wccancelmission = nil;
		wcmanageteam = nil;
		wcspectate = nil;
	};

	// Check operation Plan
	if(wcchoosemission) then {
		wcchoosemissionmenu = player addAction ["<t color='#dddd00'>"+localize "STR_WC_MENUCHOOSEMISSION"+"</t>", "warcontext\WC_fnc_openmission.sqf",[],6,false];
	};