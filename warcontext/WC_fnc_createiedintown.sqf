	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - IED in town 
	
	private ["_position", "_iedobject", "_object", "_position", "_iedtype", "_positions", "_count", "_index"];

	//_iedobject = [
	//		"VolhaLimo_TK_CIV_EP1",
	//		"LandRover_TK_CIV_EP1",
	//		"UAZ_Unarmed_TK_CIV_EP1",
	//		"Volha_2_TK_CIV_EP1",
	//		"Volha_1_TK_CIV_EP1",
	//		"Land_Misc_Garb_Heap_EP1", 
	//		"Land_Misc_Rubble_EP1", 
	//		"Land_Misc_IronPipes_EP1", 
	//		"Land_bags_stack_EP1", 
	//		"Land_Market_stalls_01_EP1", 
	//		"Land_bags_EP1", 
	//		"Land_Crates_stack_EP1",
	//		"Land_Misc_ConcBox_EP1",
	//		"Land_Misc_Well_C_EP1",
	//		"Land_Misc_Well_L_EP1",
	//		"Land_transport_crates_EP1",
	//		"Fort_Barricade_EP1",
	//		"UH60_wreck_EP1",
	//		"BMP2Wreck",
	//		"BRDMWreck",
	//		"HMMWVWreck",
	//		"LADAWreck",
	//		"Mi8Wreck",
	//		"SKODAWreck",
	//		"T72Wreck",
	//		"T72WreckTurret",
	//		"UAZWreck",
	//		"UH1Wreck",
	//		"UralWreck",
	//		"datsun01Wreck",
	//		"datsun02Wreck",
	//		"hiluxWreck"
	//];

	_iedobject = [
		"Land_transport_crates_EP1",
		"Land_Misc_Garb_Heap_EP1",
		"Land_tires_EP1",
		"Misc_TyreHeapEP1",
		"Land_Bag_EP1",
		"Land_Canister_EP1",
		"Land_Reservoir_EP1",
		"Land_Wicker_basket_EP1",
		"Land_Vase_loam_EP1",
		"Land_bags_stack_EP1",
		"Land_bags_EP1"
	];

	_position = _this select 0;
	_positions = [];

	_building = nearestObjects[_position,["Building"], 300];

	{
		if(random 1 > 0.9) then {
			_positions = _positions + [position _x];
		};
	}foreach _building;

	{
		_name = format["mrkied%1", wciedindex];
		wciedindex = wciedindex + 1;
		_position = _x findEmptyPosition [1,5];
		if(count _position > 0) then {
			_iedtype = _iedobject call BIS_fnc_selectRandom;
			_iedobject = _iedobject - [_iedtype];
			_object = _iedtype createVehicle _position;
			_object setpos _position;
			_object setdir (random 360);
			if(random 1 > 0.9) then {
				_marker = [_name, 0.5, _position, 'ColorRed', 'ICON', 'FDIAGONAL', 'dot', 0, '', false] call WC_fnc_createmarkerlocal;
				wcgarbage = [_object] spawn WC_fnc_createied;
			};
			wcobjecttodelete = wcobjecttodelete + [_object];
		};
		sleep 0.05;
	}foreach _positions;