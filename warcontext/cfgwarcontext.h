	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT INTERFACE

	class WC
	{
		class AMBIANTS
		{
			class ambiantLife
			{
				description = "[EN]\nCreate ambiant life in a location";
				file = "warcontext\WC_fnc_ambiantlife.sqf";
			};
			class createbunker
			{
				description = "[EN]\nCreate bunker in a location";
				file = "warcontext\WC_fnc_createbunker.sqf";
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
			//class createnuclearfire
			//{
			//	description = "[EN]\nCreate a nuclear fire at a position";
			// file = "warcontext\WC_fnc_createnuclearfire.sqf";
			//};
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
			class civilcar
			{
				description = "[EN]\nCreate civil cars in a location";
				file = "warcontext\WC_fnc_createbunker.sqf";
			};
		};
		class LOGICS
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
