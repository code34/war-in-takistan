	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT INTERFACE

	class WARCONTEXT
	{
		class ACTIONS
		{
			class dodigtrench
			{
				description = "[EN]\nDig a trench";
				file = "warcontext\actions\WC_fnc_dodigtrench.sqf";
			};
			class dobuildtent
			{
				description = "[EN]\nBuild a tent: personnal respawn point";
				file = "warcontext\actions\WC_fnc_dobuildtent.sqf";
			};
		}

		class AMBIANTS
		{
			class ambiantLife
			{
				description = "[EN]\nCreate ambiant life in a location";
				file = "warcontext\WC_fnc_ambiantlife.sqf";
			};
			class antiair
			{
				description = "[EN]\nCreate an antiair site at random position on map";
				file = "warcontext\WC_fnc_antiair.sqf";
			};
			class createcomposition
			{
				description = "[EN]\nCreate composition in a location";
				file = "warcontext\WC_fnc_createcomposition.sqf";
			};
			class creategroup
			{
				description = "[EN]\nCreate groups of enemys in a location";
				file = "warcontext\WC_fnc_creategroup.sqf";
			};
			class createmortuary
			{
				description = "[EN]\nCreate a mortuary at a position";
				file = "warcontext\WC_fnc_createmortuary.sqf";
			};
			class createnuclearfire
			{
				description = "[EN]\nCreate a nuclear fire from a vehicle with x ammo";
				file = "warcontext\WC_fnc_createnuclearfire.sqf";
			};
			class createsidemission
			{
				description = "[EN]\nGenerate a side mission";
				file = "warcontext\WC_fnc_createsidemission.sqf";
			};
			class createstatic
			{
				description = "[EN]\nGenerate statics in a location";
				file = "warcontext\WC_fnc_createsidemission.sqf";
			};
			class createcivilcars
			{
				description = "[EN]\nCreate civil cars in a location";
				file = "warcontext\WC_fnc_createcivilcar.sqf";
			};
			class createammobox
			{
				description = "[EN]\nCreate an ammobox at a position";
				file = "warcontext\ambiants\WC_fnc_createammobox.sqf";
			};
		};
		class FUNCTIONS
		{
			class attachmarker
			{
				description = "[EN]\nAttach marker to an object";
				file = "warcontext\functions\WC_fnc_attachmarker.sqf";
			};
			class backupbuilding
			{
				description = "[EN]\nBackup building, compositions in clipboard";
				file = "warcontext\functions\WC_fnc_backupbuilding.sqf";
			};
			class checkpilot
			{
				description = "[EN]\nCheck if pilot is a team member";
				file = "warcontext\functions\WC_fnc_checkpilot.sqf";
			};
			class clockformat
			{
				description = "[EN]\nClock format - feel empty string with 0";
				file = "warcontext\functions\WC_fnc_clockformat.sqf";
			};
			class copymarker
			{
				description = "[EN]\ncopy a marker from an existing marker";
				file = "warcontext\functions\WC_fnc_copymarker.sqf";
			};
			class copymarkerlocal
			{
				description = "[EN]\ncopy a marker from an existing marker on local client only";
				file = "warcontext\functions\WC_fnc_copymarkerlocal.sqf";
			};
			class creategridofposition
			{
				description = "[EN]\nCreate a grid of 9 positions NW,N,NE,W,C,E,SW,S,SE around a position";
				file = "warcontext\functions\WC_fnc_creategridofposition.sqf";
			};
			class createcircleposition
			{
				description = "[EN]\nCreate a positions circle of x points around position";
				file = "warcontext\functions\WC_fnc_createcircleposition.sqf";
			};
			class createposition
			{
				description = "[EN]\nCreate a position in a square x,y";
				file = "warcontext\functions\WC_fnc_createposition.sqf";
			};
			class createpositionaround
			{
				description = "[EN]\nCreate a position around a position at x distance";
				file = "warcontext\functions\WC_fnc_createpositionaround.sqf";
			};
			class createpositioninmarker
			{
				description = "[EN]\nCreate a position in a marker";
				file = "warcontext\functions\WC_fnc_createpositioninmarker.sqf";
			};
			class createmarker
			{
				description = "[EN]\nCreate a public marker";
				file = "warcontext\functions\WC_fnc_createmarker.sqf";
			};
			class createmarkerlocal
			{
				description = "[EN]\nCreate a local marker client only";
				file = "warcontext\functions\WC_fnc_createmarkerlocal.sqf";
			};
			class deletemarker
			{
				description = "[EN]\nDelete all public markers";
				file = "warcontext\functions\WC_fnc_deletemarker.sqf";
			};
			class garbagecollector
			{
				description = "[EN]\nGarbage unit after die and amount of time";
				file = "warcontext\functions\WC_fnc_garbagecollector.sqf";
			};
			class getobject
			{
				description = "[EN]\nGet an object by its editor ID";
				file = "warcontext\functions\WC_fnc_getobject.sqf";
			};
			class WC_fnc_getterraformvariance
			{
				description = "[EN]\nGet terran alt variance";
				file = "warcontext\functions\WC_fnc_getterraformvariance.sqf";
			};
			class markerhint
			{
				description = "[EN]\nHint a public marker";
				file = "warcontext\functions\WC_fnc_markerhint.sqf";
			};
			class markerhintlocal
			{
				description = "[EN]\nHint a local marker on client only";
				file = "warcontext\functions\WC_fnc_markerhintlocal.sqf";
			};
			class playerhint
			{
				description = "[EN]\nPrint a message on client";
				file = "warcontext\functions\WC_fnc_playerhint.sqf";
			};
			class sortlocationbydistance
			{
				description = "[EN]\nSort locations by distance";
				file = "warcontext\functions\WC_fnc_sortlocationbydistance.sqf";
			};
			class relocatelocation
			{
				description = "[EN]\nRelocate location to a better place";
				file = "warcontext\functions\WC_fnc_relocationlocation.sqf";
			};
			class relocateposition
			{
				description = "[EN]\nRelocate position to a better place";
				file = "warcontext\functions\WC_fnc_relocateposition.sqf";
			};
			class seed
			{
				description = "[EN]\nGenerate a number between x and y (not absolute)";
				file = "warcontext\functions\WC_fnc_seed.sqf";
			};
			class setskill
			{
				description = "[EN]\nSet skill of a unit";
				file = "warcontext\functions\WC_fnc_setskill.sqf";
			};
		};
		class GUI
		{
			class lifeslider
			{
				description = "[EN]\nGenerate the GUI";
				file = "warcontext\WC_fnc_lifeslider.sqf";
			};
			class menubuildvehicles
			{
				description = "[EN]\nOpen a dialog box to build a vehicle";
				file = "warcontext\dialog\WC_fnc_menubuildvehicles.sqf";
			};
			class menuchangeclothes
			{
				description = "[EN]\nOpen a dialog box to change players clothes";
				file = "warcontext\dialog\WC_fnc_menuchangeclothes.sqf";
			};
			class menuchoosemission
			{
				description = "[EN]\nOpen a dialog box for choose a mission";
				file = "warcontext\dialog\WC_fnc_menuchoosemission.sqf";
			};
			class menumanagementteam
			{
				description = "[EN]\nOpen a dialog box manage team members";
				file = "warcontext\dialog\WC_fnc_menumanagementteam.sqf";
			};
			class menummissioninfo
			{
				description = "[EN]\nOpen a dialog box: main mission info";
				file = "warcontext\dialog\WC_fnc_menumissioninfo.sqf";
			};
			class menureadlogs
			{
				description = "[EN]\nOpen a dialog box with game logs";
				file = "warcontext\dialog\WC_fnc_menureadlogs.sqf";
			};
			class menurecruitment
			{
				description = "[EN]\nOpen a dialog box to recruit some AI";
				file = "warcontext\dialog\WC_fnc_menurecruitment.sqf";
			};
			class menusettings
			{
				description = "[EN]\nOpen a dialog box with game settings";
				file = "warcontext\dialog\WC_fnc_menusettings.sqf";
			};
		};
		class CAMERA
		{
			class camfocus
			{
				description = "[EN]\nCreate a random camera on goal";
				file = "warcontext\functions\WC_fnc_camfocus.sqf";
			};
		};
	};
