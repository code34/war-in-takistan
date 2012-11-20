	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - restore menu action when player died
	// -----------------------------------------------

	if (isDedicated) exitWith {};

	// Default menu
	player addaction ["<t color='#ff4500'>Mission Info</t>","warcontext\dialogs\WC_fnc_createmenumissioninfo.sqf",[],5,false];
	player addAction [localize "STR_WC_MENUDEPLOYTENT", "warcontext\actions\WC_fnc_dobuildtent.sqf",[],-1,false];
	player addAction [localize "STR_WC_MENUBUILDTRENCH", "warcontext\actions\WC_fnc_dodigtrench.sqf",[],-1,false];

	// Admin menu 
	if (wcadmin) then {
		wcbombingsupport = nil;
		wccancelmission = nil;
		wcmanageteam = nil;
		wcspectate = nil;
	};

	// Check operation Plan
	if(wcchoosemission) then {
		wcchoosemissionmenu = player addAction ["<t color='#ff4500'>"+localize "STR_WC_MENUCHOOSEMISSION"+"</t>", "warcontext\dialogs\WC_fnc_createmenuchoosemission.sqf",[],6,false];
	};