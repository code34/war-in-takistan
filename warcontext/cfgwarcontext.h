	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT INTERFACE

	class WARCONTEXT
	{
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
			class createcivilcars
			{
				description = "[EN]\nCreate civil cars in a location";
				file = "warcontext\WC_fnc_createcivilcar.sqf";
			};
		};
		class FUNCTIONS
		{
			class attachmarker
			{
				description = "[EN]\nAttach marker to an object";
				file = "warcontext\WC_fnc_attachmarker.sqf";
			};
			class copymarker
			{
				description = "[EN]\ncopy a marker from an existing marker";
				file = "warcontext\WC_fnc_copymarker.sqf";
			};
			class createmarker
			{
				description = "[EN]\nCreate a public marker";
				file = "warcontext\WC_fnc_attachmarker.sqf";
			};
			class createposition
			{
				description = "[EN]\nCreate a position on map";
				file = "warcontext\WC_fnc_createposition.sqf";
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
				file = "warcontext\WC_fnc_camfocus.sqf";
			};
		};
	};
