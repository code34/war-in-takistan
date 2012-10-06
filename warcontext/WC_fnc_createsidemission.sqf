	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - create side mission
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private [
		"_vehicle", 
		"_location", 
		"_unit", 
		"_position", 
		"_group", 
		"_missiontype", 
		"_x", 
		"_building", 
		"_arrayofpos", 
		"_startposition", 
		"_index", 
		"_buildings", 
		"_missionname",
		"_missionnumber",
		"_missiontext",
		"_marker",
		"_count",
		"_watersafeposition"
		];

	_missionnumber	= _this select 0;
	_missionname	= _this select 1;

	_marker = ['sidezone', 100, getmarkerpos 'rescuezone', 'ColorRED', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarkerlocal;
	_marker2 = ["bombzone", _marker] call WC_fnc_copymarkerlocal;
	_marker2 setMarkerSizeLocal [300, 300];

	_position = [1,1,0];
	while { format ["%1", _position] ==  "[1,1,0]"} do {
		_position = ["sidezone", "onground", "onflat", "empty"] call WC_fnc_createpositioninmarker;
	};

	wcbonusfame = 0;
	wcbonusfuel = 0;
	wcbonuselectrical = 0;
	wcbonusnuclear = 0;

	switch (_missionnumber) do {
		case 0: {
			_missiontext = [_missionname, "Destroy a scud launcher"];
			_vehicle = createVehicle ["MAZ_543_SCUD_TK_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_vehicle action ["scudLaunch", _vehicle];
			_missiontype = "destroy";
			wcbonusfame = 0;
			wcbonusnuclear = 0.15;
		};

		case 1: {
			_missiontext = [_missionname, "Kill a gold trafficant"];
			_group = createGroup east;
			_vehicle = _group createUnit ["Functionary1_EP1", _position, [], 0, "NONE"];
			_buildings = nearestObjects [position _vehicle, ["House"], 350];
			_arrayofpos = [];
			{
				if(getdammage _x == 0) then {
					_index = 0;
					while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
						_position = _x buildingPos _index;
						_arrayofpos = _arrayofpos + [_position];
						_index = _index + 1;
						sleep 0.05;
					};
				};
			}foreach _buildings;
			wcgarbage = [_vehicle] spawn {
				private ["_unit", "_enemy"];
				_unit = _this select 0;
				while {alive _unit} do {
					_enemy = (nearestObjects [_unit, ["Man"], 150]) select 1;
					if(side _enemy in wcside) then {
						_unit dotarget _enemy;
						_unit dofire _enemy;
					};
					sleep 1;
				};
			};
			_position = _arrayofpos call BIS_fnc_selectRandom;
			_vehicle setpos _position;
			_vehicle setUnitPos "Up"; 
			_vehicle stop true;
			wcgarbage = [_vehicle, wcskill] spawn WC_fnc_setskill;
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "eliminate";
			wcbonusfame = -0.1;
		};

		case 2: {
			_missiontext = [_missionname, "Kill a nuclear scientist"];
			_group = createGroup east;
			_vehicle = _group createUnit ["Dr_Hladik_EP1", _position, [], 0, "NONE"];
			_buildings = nearestObjects [position _vehicle, ["House"], 350];
			_arrayofpos = [];
			{
				if(getdammage _x == 0) then {
					_index = 0;
					while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
						_position = _x buildingPos _index;
						_arrayofpos = _arrayofpos + [_position];
						_index = _index + 1;
						sleep 0.05;
					};
				};
			}foreach _buildings;
			wcgarbage = [_vehicle] spawn {
				private ["_unit", "_enemy"];
				_unit = _this select 0;
				while {alive _unit} do {
					_enemy = (nearestObjects [_unit, ["Man"], 150]) select 1;
					if(side _enemy in wcside) then {
						_unit dotarget _enemy;
						_unit dofire _enemy;
					};
					sleep 1;
				};
			};
			_position = _arrayofpos call BIS_fnc_selectRandom;
			_vehicle setpos _position;
			_vehicle setUnitPos "Up"; 
			_vehicle stop true;
			wcgarbage = [_vehicle, wcskill] spawn WC_fnc_setskill;
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "eliminate";
			wcbonusfame = -0.1;
		};

		case 3: {
			_missiontext = [_missionname,"Destroy the barracks location"];
			_vehicle = createVehicle ["Land_Barrack2_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0.1;
		};

		case 4: {
			_missiontext = [_missionname, "Destroy the ural refuel"];
			_vehicle = createVehicle ["UralRefuel_TK_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_vehicle setVehicleInit "this lock true;";
			processInitCommands;
			_missiontype = "destroy";
			wcbonusfame = 0;
			wcbonusfuel = -0.1;
		};

		case 5: {
			_missiontext = [_missionname, "Destroy the ural"];
			_vehicle = createVehicle ["Ural_ZU23_TK_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_vehicle setVehicleInit "this lock true;";
			processInitCommands;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 6: {
			_missiontext = [_missionname, "Kill a takistani commander"];
			_group = createGroup east;
			_vehicle = _group createUnit ["TK_Aziz_EP1", _position, [], 0, "NONE"];
			_buildings = nearestObjects [position _vehicle, ["House"], 350];
			_arrayofpos = [];
			{
				if(getdammage _x == 0) then {
					_index = 0;
					while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
						_position = _x buildingPos _index;
						//if (_position select 2 > 2) then {
							_arrayofpos = _arrayofpos + [_position];
						//};
						_index = _index + 1;
						sleep 0.05;
					};
				};
			}foreach _buildings;
			wcgarbage = [_vehicle] spawn {
				private ["_unit", "_enemy"];
				_unit = _this select 0;
				while {alive _unit} do {
					_enemy = (nearestObjects [_unit, ["Man"], 150]) select 1;
					if(side _enemy in wcside) then {
						_unit dotarget _enemy;
						_unit dofire _enemy;
					};
					sleep 1;
				};
			};
			_position = _arrayofpos call BIS_fnc_selectRandom;
			_vehicle setpos _position;
			_vehicle setUnitPos "Up"; 
			_vehicle stop true;
			wcgarbage = [_vehicle, wcskill] spawn WC_fnc_setskill;
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "eliminate";
			wcbonusfame = 0.1;
		};

		case 7: {
			_missiontext = [_missionname, "Destroy a bmp2 HQ"];
			_vehicle = createVehicle ["BMP2_HQ_TK_unfolded_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 8: {
			_missiontext = [_missionname, "Destroy a small fuel location"];
			_vehicle = createVehicle ["Land_Ind_TankSmall2_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
			wcbonusfuel = -0.1;
		};

		case 9: {
			_missiontext = [_missionname, "Destroy a big fuel location"];
			_vehicle = createVehicle ["Land_Fuel_tank_big", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
			wcbonusfuel = -0.1;
		};

		case 10: {
			_missiontext = [_missionname, "Destroy the smuggled cargo"];
			_vehicle = createVehicle ["Land_Misc_Cargo1E_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 11: {
			_missiontext = [_missionname,"Destroy the enemy airfac"];
			_vehicle = createVehicle ["TK_WarfareBAircraftFactory_Base_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = -0.1;
			wcbonuselectrical = -0.15;
		};

		case 12: {
			_missiontext = [_missionname,"Destroy a commando group"];
			_vehicle = createVehicle ["Mi17_TK_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_destroygroup;
			_vehicle setVehicleInit "this lock true;";
			processInitCommands;
			_missiontype = "destroygroup";
			wcbonusfame = 0;
		};

		case 13: {
			_missiontext = [_missionname, "Destroy a transport chopper"];
			_vehicle = createVehicle ["UH1H_TK_GUE_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_vehicle setVehicleInit "this lock true;";
			processInitCommands;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 14: {
			_missiontext = [_missionname, "Kill the spy"];
			_group = createGroup east;
			_vehicle = _group createUnit ["CIV_EuroMan01_EP1", _position, [], 0, "NONE"];
			_buildings = nearestObjects [position _vehicle, ["House"], 350];
			_arrayofpos = [];
			{
				if(getdammage _x == 0) then {
					_index = 0;
					while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
						_position = _x buildingPos _index;
						_arrayofpos = _arrayofpos + [_position];
						_index = _index + 1;
						sleep 0.05;
					};
				};
			}foreach _buildings;
			wcgarbage = [_vehicle] spawn {
				private ["_unit", "_enemy"];
				_unit = _this select 0;
				while {alive _unit} do {
					_enemy = (nearestObjects [_unit, ["Man"], 150]) select 1;
					if(side _enemy in wcside) then {
						_unit dotarget _enemy;
						_unit dofire _enemy;
					};
					sleep 1;
				};
			};
			_position = _arrayofpos call BIS_fnc_selectRandom;
			_vehicle setpos _position;
			_vehicle setUnitPos "Up"; 
			_vehicle stop true;
			wcgarbage = [_vehicle, wcskill] spawn WC_fnc_setskill;
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "eliminate";
			wcbonusfame = 0;
		};

		case 15: {
			_missiontext = [_missionname, "Destroy the radar"];
			_vehicle = createVehicle ["TK_GUE_WarfareBArtilleryRadar_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 16: {
			_missiontext = [_missionname, "Destroy the hospital"];
			_vehicle = createVehicle ["TK_GUE_WarfareBFieldhHospital_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = -0.1;
		};

		case 17: {
			_missiontext = [_missionname, "Destroy the heavy factory"];
			_vehicle = createVehicle ["TK_WarfareBHeavyFactory_Base_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 18: {
			_missiontext = [_missionname, "Eliminate suicide bomber"];
			_group = createGroup east;
			_type = ["TK_CIV_Takistani06_EP1", "TK_GUE_Bonesetter_EP1", "TK_CIV_Woman01_EP1", "TK_GUE_Warlord_EP1"] call BIS_fnc_selectRandom;
			_vehicle = _group createUnit [_type, _position, [], 0, "NONE"];
			_buildings = nearestObjects [position _vehicle, ["House"], 350];
			_arrayofpos = [];
			{
				if(getdammage _x == 0) then {
					_index = 0;
					while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
						_position = _x buildingPos _index;
						_arrayofpos = _arrayofpos + [_position];
						_index = _index + 1;
						sleep 0.05;
					};
				};
			}foreach _buildings;
			wcgarbage = [_vehicle] spawn {
				private ["_unit", "_enemy"];
				_unit = _this select 0;
				while {alive _unit} do {
					_enemy = (nearestObjects [_unit, ["Man"], 150]) select 1;
					if(side _enemy in wcside) then {
						_unit dotarget _enemy;
						_unit dofire _enemy;
					};
					sleep 1;
				};
			};
			_position = _arrayofpos call BIS_fnc_selectRandom;
			_vehicle setpos _position;
			_vehicle setUnitPos "Up"; 
			_vehicle stop true;
			wcgarbage = [_vehicle, wcskill] spawn WC_fnc_setskill;
			wcgarbage = [_vehicle] spawn WC_fnc_createied;
			_missiontype = "eliminate";
			wcbonusfame = 0.1;
		};

		case 19: {
			_missiontext = [_missionname, "Kill a war lord"];
			_group = createGroup east;
			_vehicle = _group createUnit ["TK_GUE_Warlord_EP1", _position, [], 0, "NONE"];
			_buildings = nearestObjects [position _vehicle, ["House"], 350];
			_arrayofpos = [];
			{
				if(getdammage _x == 0) then {
					_index = 0;
					if(getdammage _x == 0) then {
						while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
							_position = _x buildingPos _index;
							//if (_position select 2 > 2) then {
								_arrayofpos = _arrayofpos + [_position];
							//};
							_index = _index + 1;
							sleep 0.05;
						};
					};
				};
			}foreach _buildings;
			wcgarbage = [_vehicle] spawn {
				private ["_unit", "_enemy"];
				_unit = _this select 0;
				while {alive _unit} do {
					_enemy = (nearestObjects [_unit, ["Man"], 150]) select 1;
					if(side _enemy in wcside) then {
						_unit dotarget _enemy;
						_unit dofire _enemy;
					};
					sleep 1;
				};
			};
			_position = _arrayofpos call BIS_fnc_selectRandom;
			_vehicle setpos _position;
			_vehicle setUnitPos "Up"; 
			_vehicle stop true;
			wcgarbage = [_vehicle, wcskill] spawn WC_fnc_setskill;
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "eliminate";
			wcbonusfame = 0.1;
		};

		case 20: {
			_missiontext = [_missionname, "Kill a takistani officer"];
			_group = createGroup east;
			_vehicle = _group createUnit ["TK_Soldier_Officer_EP1", _position, [], 0, "NONE"];
			_buildings = nearestObjects [position _vehicle, ["House"], 350];
			_arrayofpos = [];
			{
				if(getdammage _x == 0) then {
					_index = 0;
					while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
						_position = _x buildingPos _index;
						//if (_position select 2 > 2) then {
							_arrayofpos = _arrayofpos + [_position];
						//};
						_index = _index + 1;
						sleep 0.05;
					};
				};
			}foreach _buildings;
			wcgarbage = [_vehicle] spawn {
				private ["_unit", "_enemy"];
				_unit = _this select 0;
				while {alive _unit} do {
					_enemy = (nearestObjects [_unit, ["Man"], 150]) select 1;
					if(side _enemy in wcside) then {
						_unit dotarget _enemy;
						_unit dofire _enemy;
					};
					sleep 1;
				};
			};
			_position = _arrayofpos call BIS_fnc_selectRandom;
			_vehicle setpos _position;
			_vehicle setUnitPos "Up"; 
			_vehicle stop true;
			wcgarbage = [_vehicle, wcskill] spawn WC_fnc_setskill;
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "eliminate";
			wcbonusfame = -0.1;
		};

		case 21: {
			_missiontext = [_missionname, "Destroy an AA pod"];
			_vehicle = createVehicle ["ZU23_TK_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 22: {
			_missiontext = [_missionname, "Destroy a missile launcher"];
			_vehicle = createVehicle ["GRAD_TK_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
			wcbonusnuclear = 0.15;
		};

		case 23: {
			_missiontext = [_missionname, "Defuse an IED"];
			_type = ["VolhaLimo_TK_CIV_EP1","LandRover_TK_CIV_EP1","UAZ_Unarmed_TK_CIV_EP1","Volha_2_TK_CIV_EP1","Volha_1_TK_CIV_EP1","Land_Misc_Garb_Heap_EP1", "Land_Misc_Rubble_EP1", "Land_Misc_IronPipes_EP1", "Land_bags_stack_EP1", "Land_Market_stalls_01_EP1", "Land_bags_EP1", "Land_Crates_stack_EP1","Land_Misc_ConcBox_EP1","Land_Misc_Well_C_EP1","Land_Misc_Well_L_EP1","Land_transport_crates_EP1","Fort_Barricade_EP1","UH60_wreck_EP1","C130J_wreck_EP1"] call BIS_fnc_selectRandom;
			_vehicle = createVehicle [_type, _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_createied;
			_missiontype = "ied";
			wcbonusfame = 0.1;
		};

		case 24: {
			_missiontext = [_missionname, "Destroy a radio tower"];
			_type = wcradiotype call BIS_fnc_selectRandom;
			_vehicle = createVehicle [_type, _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 25: {
			_missiontext = [_missionname, "Destroy an electrical station"];
			_vehicle = createVehicle ["PowGen_Big_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = -0.1;
			wcbonuselectrical = -0.15;
		};

		case 26: {
			_missiontext = [_missionname, "Destroy a ZSU"];
			_vehicle = createVehicle ["ZSU_TK_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 27: {
			_missiontext = [_missionname, "Destroy a T72"];
			_vehicle = createVehicle ["T72_TK_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 28: {
			_missiontext = [_missionname, "Liberate the hostage"];
			_group = createGroup west;
			_vehicle = _group createUnit ["Haris_Press_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_liberatehotage;
			_missiontype = "liberate";
			wcbonusfame = 0;
		};

		case 29: {
			_missiontext = [_missionname, "Destroy an UAV terminal"];
			_vehicle = createVehicle ["TK_WarfareBUAVterminal_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 30: {
			_missiontext = [_missionname, "Liberate an officer"];
			_group = createGroup west;
			_vehicle = _group createUnit ["UN_CDF_Soldier_Officer_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_liberatehotage;
			_missiontype = "liberate";
			wcbonusfame = 0;
		};

		case 31: {
			_missiontext = [_missionname, "Liberate a tourist"];
			_group = createGroup west;
			_vehicle = _group createUnit ["CIV_EuroWoman01_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_liberatehotage;
			_missiontype = "liberate";
			wcbonusfame = 0;
		};

		case 32: {
			_missiontext = [_missionname, "Sabotage a ZSU"];
			_vehicle = createVehicle ["ZSU_TK_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_sabotage;
			_missiontype = "sabotage";
			wcbonusfame = 0;
		};

		case 33: {
			_missiontext = [_missionname, "Sabotage a T72"];
			_vehicle = createVehicle ["T72_TK_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_sabotage;
			_missiontype = "sabotage";
			wcbonusfame = 0;
		};

		case 34: {
			_missiontext = [_missionname, "Sabotage a radio tower"];
			wcgarbage = [wcradio] spawn WC_fnc_sabotage;
			_missiontype = "sabotage";
			wcbonusfame = 0;
		};

		case 35: {
			_missiontext = [_missionname, "Steal a secret document"];
			_house = nearestObjects [_position, ["House"], 500];
			_house = _house call BIS_fnc_selectRandom;
			_vehicle = createVehicle ["EvMoscow", position _house, [], 0, "NONE"];
			_buildings = nearestObjects [position _vehicle, ["House"], 350];
			_arrayofpos = [];
			{
				if(getdammage _x == 0) then {
					_index = 0;
					while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
						_position = _x buildingPos _index;
						_arrayofpos = _arrayofpos + [_position];
						_index = _index + 1;
						sleep 0.05;
					};
				};
			}foreach _buildings;
			_position = _arrayofpos call BIS_fnc_selectRandom;
			_vehicle setpos _position;
			wcgarbage = [_vehicle] spawn WC_fnc_steal;
			_missiontype = "steal";
			wcbonusfame = 0;
		};

		case 36: {
			_missiontext = [_missionname, "Steal a BRDM2"];
			_vehicle = createVehicle ["BRDM2_TK_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_missiontype = "rob";
			wcbonusfame = 0;
		};

		case 37: {
			_missiontext = [_missionname, "Steal a BTR60"];
			_vehicle = createVehicle ["BTR60_TK_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_missiontype = "rob";
			wcbonusfame = 0;
		};

		case 38: {
			_missiontext = [_missionname, "Steal an Ural"];
			_vehicle = createVehicle ["UralRefuel_TK_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_missiontype = "rob";
			wcbonusfame = 0;
			wcbonusfuel = -0.1;
		};

		case 39: {
			_missiontext = [_missionname, "Capture a takistani commander"];
			_group = createGroup east;
			_vehicle = _group createUnit ["TK_Aziz_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_jail;
			_missiontype = "jail";
			wcbonusfame = 0;
		};

		case 40: {
			_missiontext = [_missionname, "Capture a takistani officer"];
			_group = createGroup east;
			_vehicle = _group createUnit ["TK_Soldier_Officer_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_jail;
			_missiontype = "jail";
			wcbonusfame = 0;
		};

		case 41: {
			_missiontext = [_missionname, "Capture a war lord"];
			_group = createGroup east;
			_vehicle = _group createUnit ["TK_GUE_Warlord_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_jail;
			_missiontype = "jail";
			wcbonusfame = 0.1;
		};

		case 42: {
			_missiontext = [_missionname, "Capture a civilian"];
			_group = createGroup east;
			_type = ["TK_CIV_Takistani01_EP1", "TK_CIV_Takistani02_EP1", "TK_CIV_Takistani03_EP1", "TK_CIV_Takistani04_EP1", "TK_CIV_Takistani05_EP1", "TK_CIV_Takistani06_EP1", "TK_CIV_Woman01_EP1", "TK_CIV_Woman02_EP1", "TK_CIV_Woman03_EP1", "TK_CIV_Worker01_EP1", "TK_CIV_Worker02_EP1"] call BIS_fnc_selectRandom;
			_vehicle = _group createUnit [_type, _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_jail;
			_missiontype = "jail";
			wcbonusfame = 0;
		};

		case 43: {
			_missiontext = [_missionname, "Retrieve an AH64"];
			_vehicle = createVehicle ["AH64D_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_varname="bonusah64";
			_vehicle setvehicleinit format["this setvehiclevarname %1;", _varname];
			processinitcommands;
			_missiontype = "rob";
			wcbonusfame = 0;
		};

		case 44: {
			_missiontext = [_missionname, "Retrieve an UH1"];
			_vehicle = createVehicle ["UH1H_TK_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_varname="bonusuh1";
			_vehicle setvehicleinit format["this setvehiclevarname %1;", _varname];
			processinitcommands;
			_missiontype = "rob";
			wcbonusfame = 0;
		};

		case 45: {
			_missiontext = [_missionname, "Retrieve an M1"];
			_vehicle = createVehicle ["M1A2_US_TUSK_MG_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_varname="bonusm1";
			_vehicle setvehicleinit format["this setvehiclevarname %1;", _varname];
			processinitcommands;
			_missiontype = "rob";
			wcbonusfame = 0;
		};

		case 46: {
			_missiontext = [_missionname, "Retrieve an MH6"];
			_vehicle = createVehicle ["MH6J_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_varname="bonusmh6";
			_vehicle setvehicleinit format["this setvehiclevarname %1;", _varname];
			processinitcommands;
			_missiontype = "rob";
			wcbonusfame = 0;
		};

		case 47: {
			_missiontext = [_missionname, "Destroy an ammo cache"];
			_vehicle = createVehicle ["TKVehicleBox_EP1", _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0.1;
		};

		case 48: {
			_missiontext = [_missionname, "Destroy a repair center"];
			_vehicle = createVehicle ["TK_GUE_WarfareBHeavyFactory_Base_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 49: {
			_missiontext = [_missionname,"Retrieve a Chinook"];
			_vehicle = createVehicle ["CH_47F_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_varname="bonuschinook";
			_vehicle setvehicleinit format["this setvehiclevarname %1;", _varname];
			processinitcommands;
			_missiontype = "rob";
			wcbonusfame = 0;
		};

		case 50: {
			_missiontext = [_missionname, "Kill a takistani woman civil"];
			_group = createGroup civilian;
			_vehicle = _group createUnit ["TK_CIV_Woman01_EP1", _position, [], 0, "NONE"];
			_buildings = nearestObjects [position _vehicle, ["House"], 350];
			_arrayofpos = [];
			{
				if(getdammage _x == 0) then {
					_index = 0;
					while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
						_position = _x buildingPos _index;
						//if (_position select 2 > 2) then {
							_arrayofpos = _arrayofpos + [_position];
						//};
						_index = _index + 1;
						sleep 0.05;
					};
				};
			}foreach _buildings;
			_position = _arrayofpos call BIS_fnc_selectRandom;
			_vehicle setpos _position;
			_vehicle setUnitPos "Up"; 
			_vehicle stop true;
			wcgarbage = [_vehicle, wcskill] spawn WC_fnc_setskill;
			_missiontype = "eliminate";
			wcbonusfame = -0.1;
		};

		case 51: {
			_vehicle = wcmissionvehicle;
			_name = getText (configFile >> "CfgVehicles" >> _vehicle >> "DisplayName");
			_missiontext = [_missionname, "Destroy a " + _name];
			_vehicle = createVehicle [_vehicle, _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 52: {
			_vehicle = wcmissionvehicle;
			_name = getText (configFile >> "CfgVehicles" >> _vehicle >> "DisplayName");
			_missiontext = [_missionname, "Rob a " + _name];
			_vehicle = createVehicle [_vehicle, _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_missiontype = "rob";
			wcbonusfame = 0;
		};

		case 53: {
			_vehicle = wcmissionvehicle;
			_name = getText (configFile >> "CfgVehicles" >> _vehicle >> "DisplayName");
			_missiontext = [_missionname, "Sabotage a " + _name];
			_vehicle = createVehicle [_vehicle, _position, [], 0, "NONE"];
			_camo = createVehicle ["Land_CamoNetB_EAST_EP1", [0,0,0], [], 0, "NONE"];
			_camo allowdammage false;
			_camo setdir getdir _vehicle;
			_camo setpos (position _vehicle);
			wcgarbage = [_vehicle] spawn WC_fnc_sabotage;
			_missiontype = "sabotage";
			wcbonusfame = 0;
		};

		case 54: {
			_missiontext = [_missionname, "Rescue a pilot"];
			_group = createGroup west;
			_vehicle2 = "UH60_wreck_EP1" createvehicle _position;
			_vehicle = _group createUnit ["US_Pilot_Light_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_liberatehotage;
			_missiontype = "liberate";
			wcbonusfame = 0;
		};

		case 55: {
			_missiontext = [_missionname, "Defend an area"];
			_vehicle = "Land_fortified_nest_big_EP1" createvehicle _position;
			_vehicle = "FlagCarrierUSA_EP1" createvehicle _position;
			_vehicle setVehicleInit "this addAction ['<t color=''#ff4500''>Defend the area</t>', 'warcontext\actions\WC_fnc_dobegindefend.sqf',[],6,false];";
			wcgarbage = [_vehicle] spawn WC_fnc_defend;
			processInitCommands;
			_missiontype = "defend";
			wcbonusfame = 0;
			wcradio setdamage 1;
		};

		case 56: {
			_missiontext = [_missionname,"Defend the barracks"];
			_vehicle = (nearestObjects [_position, ["Land_Mil_Barracks_i_EP1"], 400]) call BIS_fnc_selectRandom;
			_vehicle setVehicleInit "this addAction ['<t color=''#ff4500''>Defend the barrack</t>', 'warcontext\actions\WC_fnc_dobegindefend.sqf',[],6,false];";
			wcgarbage = [_vehicle] spawn WC_fnc_defend;
			processInitCommands;
			_missiontype = "defend";
			wcbonusfame = 0;
			wcradio setdamage 1;
		};

		case 57: {
			_missiontext = [_missionname, "Rescue a C130 pilot"];
			_group = createGroup west;
			_vehicle2 = "C130J_wreck_EP1" createvehicle _position;
			_vehicle = _group createUnit ["US_Pilot_Light_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_liberatehotage;
			_missiontype = "liberate";
			wcbonusfame = 0;
		};

		case 58: {
			_missiontext = [_missionname, "Retrieve an A10 aircraft"];
			_hangar = (nearestObjects [_position, ["Land_Mil_hangar_EP1"], 400]) call BIS_fnc_selectRandom;
			_vehicle = "A10_US_EP1" createvehicle position _hangar;
			_vehicle setdir (getdir _hangar + 180);
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_varname="bonusa10";
			_vehicle setvehicleinit format["this setvehiclevarname %1;", _varname];
			processinitcommands;
			_missiontype = "rob";
			wcbonusfame = 0;
		};

		case 59: {
			_missiontext = [_missionname, "Retrieve an AH6X"];
			_hangar = (nearestObjects [_position, ["Land_Mil_hangar_EP1"], 400]) call BIS_fnc_selectRandom;
			_vehicle = "AH6X_EP1" createvehicle position _hangar;
			_vehicle setdir (getdir _hangar + 180);
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_varname="bonusav8b";
			_vehicle setvehicleinit format["this setvehiclevarname %1;", _varname];
			processinitcommands;
			_missiontype = "rob";
			wcbonusfame = 0;
		};

		case 60: {
			_missiontext = [_missionname, "Retrieve an AH64D"];
			_hangar = (nearestObjects [_position, ["Land_Mil_hangar_EP1"], 400]) call BIS_fnc_selectRandom;
			_vehicle = "AH64D_EP1" createvehicle position _hangar;
			_vehicle setdir (getdir _hangar + 180);
			wcgarbage = [_vehicle] spawn WC_fnc_rob;
			_varname="bonusf35b";
			_vehicle setvehicleinit format["this setvehiclevarname %1;", _varname];
			processinitcommands;
			_missiontype = "rob";
			wcbonusfame = 0;
		};

		case 61: {
			_missiontext = [_missionname, "Destroy a SU25"];
			_hangar = (nearestObjects [_position, ["Land_Mil_hangar_EP1"], 400]) call BIS_fnc_selectRandom;
			_vehicle = "Su25_TK_EP1" createvehicle position _hangar;
			_vehicle setdir (getdir _hangar + 180);
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 62: {
			_missiontext = [_missionname, "Destroy a L39"];
			_hangar = (nearestObjects [_position, ["Land_Mil_hangar_EP1"], 400]) call BIS_fnc_selectRandom;
			_vehicle = "L39_TK_EP1" createvehicle position _hangar;
			_vehicle setdir (getdir _hangar + 180);
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 63: {
			_missiontext = [_missionname, "Defend an Oil Pump"];
			_vehicle = (nearestObjects [_position, ["Land_Ind_Oil_Pump_EP1"], 400]) call BIS_fnc_selectRandom;
			_vehicle setVehicleInit "this addAction ['<t color=''#ff4500''>Defend the barrack</t>', 'warcontext\actions\WC_fnc_dobegindefend.sqf',[],6,false];";
			wcgarbage = [_vehicle] spawn WC_fnc_defend;
			processInitCommands;
			_missiontype = "defend";
			wcbonusfame = 0;
			wcradio setdamage 1;
		};

		case 64: {
			_missiontext = [_missionname, "Heal a civilian"];
			_type = ["TK_CIV_Takistani01_EP1", "TK_CIV_Takistani02_EP1", "TK_CIV_Takistani03_EP1", "TK_CIV_Takistani04_EP1", "TK_CIV_Takistani05_EP1", "TK_CIV_Takistani06_EP1", "TK_CIV_Woman01_EP1", "TK_CIV_Woman02_EP1", "TK_CIV_Woman03_EP1", "TK_CIV_Worker01_EP1", "TK_CIV_Worker02_EP1"] call BIS_fnc_selectRandom;
			_group = createGroup civilian;
			_vehicle = _group createUnit [_type, _position, [], 0, "NONE"];
			wcgarbage = [_vehicle] spawn WC_fnc_heal;
			_missiontype = "heal";
			wcbonusfame = 0.1;
		};

		case 65: {
			_missiontext = [_missionname, "Destroy a fuel location"];
			_vehicle = (nearestObjects [_position, ["Land_Ind_FuelStation_Feed_EP1"], 400]) call BIS_fnc_selectRandom;
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "destroy";
			wcbonusfame = 0;
		};

		case 66: {
			_missiontext = [_missionname, "Build a MASH"];
			_vehicle = "Land_Dirthump01_EP1" createvehicle _position;
			wcgarbage = [_vehicle, "MASH_EP1"] spawn WC_fnc_build;
			_missiontype = "build";
			wcbonusfame = 0.1;
		};

		case 67: {
			_missiontext = [_missionname, "Build a military hospital"];
			_vehicle = "Land_Dirthump01_EP1" createvehicle _position;
			wcgarbage = [_vehicle, "TK_GUE_WarfareBFieldhHospital_Base_EP1"] spawn WC_fnc_build;
			_missiontype = "build";
			wcbonusfame = 0.1;
		};

		case 68: {
			_missiontext = [_missionname, "Build a radar"];
			_vehicle = "Land_Dirthump01_EP1" createvehicle _position;
			wcgarbage = [_vehicle, "TK_WarfareBAntiAirRadar_Base_EP1"] spawn WC_fnc_build;
			_missiontype = "build";
			wcbonusfame = 0.1;
		};

		case 69: {
			_missiontext = [_missionname, "Build a service point"];
			_vehicle = "Land_Dirthump01_EP1" createvehicle _position;
			wcgarbage = [_vehicle, "US_WarfareBVehicleServicePoint_EP1"] spawn WC_fnc_build;
			_missiontype = "build";
			wcbonusfame = 0.1;
		};

		case 70: {
			_missiontext = [_missionname, "Rescue 10 civilians"];
			_position = _position findEmptyPosition [10, wcdistance];
			if((count _position) == 0) then {
				diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CREATE MASH MISSION";
			};
			_vehicle = "MASH_EP1" createvehicle _position;
			wcgarbage = [_vehicle, 10] spawn WC_fnc_rescuecivil;
			_missiontype = "build";
			wcbonusfame = 0.1;
		};

		case 71: {
			_missiontext = [_missionname, "Secure an Airfield zone"];
			_vehicle = (nearestObjects [_position, ["Land_Mil_hangar_EP1"], 400]) call BIS_fnc_selectRandom;
			wcgarbage = [_vehicle] spawn WC_fnc_securezone;
			_missiontype = "secure";
			wcbonusfame = 0;
		};

		case 72: {
			_missiontext = [_missionname, "Secure an Oil Pump zone"];
			_vehicle = (nearestObjects [_position, ["Land_Ind_Oil_Pump_EP1"], 400]) call BIS_fnc_selectRandom;
			wcgarbage = [_vehicle] spawn WC_fnc_securezone;
			_missiontype = "secure";
			wcbonusfame = 0;
		};

		case 73: {
			_missiontext = [_missionname,"Bring an ammo truck"];
			_vehicle = createVehicle ["MtvrReammo_DES_EP1", getmarkerpos "convoystart", [], 0, "NONE"];
			_varname = "ammotruck";
			_vehicle setvehicleinit format["this setvehiclevarname %1;", _varname];
			processinitcommands;
			_unit = createVehicle ["TK_WarfareBBarracks_Base_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_vehicle, _unit] spawn WC_fnc_bringvehicle;
			_missiontype = "bring";
			wcbonusfame = 0;
		};

		case 74: {
			_missiontext = [_missionname,"Build a bunker"];
			_vehicle = "Land_Dirthump01_EP1" createvehicle _position;
			wcgarbage = [_vehicle, "Land_fortified_nest_big_EP1"] spawn WC_fnc_build;
			_missiontype = "build";
			wcbonusfame = 0.1;
		};

		case 75: {
			_missiontext = [_missionname,"Escort a medic on battlefield"];
			_group = createGroup civilian;
			_unit = _group createUnit ["Dr_Hladik_EP1", getmarkerpos "convoystart", [], 0, "NONE"];
			_unit setVehicleInit "this addAction ['<t color=''#ff4500''>Follow me</t>', 'warcontext\actions\WC_fnc_dofollowme.sqf',[],-1,false, true];";
			processinitcommands;
			_vehicle = createVehicle ["MASH_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_unit, position _vehicle] spawn WC_fnc_bringunit;
			wcgarbage = [_unit] spawn WC_fnc_createmedic;
			_missiontype = "bringunit";
			wcbonusfame = 0;
		};

		case 76: {
			_missiontext = [_missionname,"Recording a conversation"];
			_group = createGroup east;
			_vehicle = _group createUnit ["TK_Soldier_Officer_EP1", _position, [], 0, "NONE"];
			_vehicle2 = _group createUnit ["TK_GUE_Warlord_EP1", _position, [], 0, "NONE"];
			wcgarbage = [_group] spawn WC_fnc_record;
			_missiontype = "record";
			wcbonusfame = 0;
		};

		case 77: {
			_missiontext = [_missionname, "Secure a Control Tower"];
			_vehicle = (nearestObjects [_position, ["Land_Mil_ControlTower_EP1", "Land_Mil_ControlTower"], 400]) call BIS_fnc_selectRandom;
			_position = position _vehicle;
			_group = createGroup west;
			{
				_unit = _group createUnit [_x, _position, [], 20, "NONE"];
			}foreach ["CZ_Special_Forces_Scout_DES_EP1","CZ_Special_Forces_MG_DES_EP1","CZ_Special_Forces_DES_EP1","CZ_Special_Forces_TL_DES_EP1"];
			wcgarbage = [_group, 50] spawn WC_fnc_patrol;
			(leader _group) setVehicleInit "this addAction ['<t color=''#ff4500''>Replace the guard</t>', 'warcontext\actions\WC_fnc_dobeginguard.sqf',[],6,false];";
			processInitCommands;
			_missiontype = "defend";
			wcbonusfame = 0;			
		};

		case 100: {
			_missiontext = [_missionname," Kill the enemy leader"];
			_vehicle = imam;
			_vehicle allowdammage true;
			_vehicle addweapon "AKS_74";
			_vehicle addmagazine "30Rnd_545x39_AK";
			_vehicle addEventHandler ['Fired', '(_this select 0) setvehicleammo 1;'];
			_position = _position findEmptyPosition [3,100];
			if((count _position) == 0) then {
				diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CREATE LEADER MISSION";
				_position = _position findEmptyPosition [3, wcdistance];
			};
			_vehicle setpos _position;
			_vehicle setvehicleinit "this allowdammage true;";
			processInitCommands;
			wcgarbage = [(group _vehicle), 300] spawn WC_fnc_patrol;
			wcgarbage = [_vehicle, wcskill] spawn WC_fnc_setskill;
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
			_missiontype = "eliminate";
			wcbonusfame = 0;
		};
	};

	_minute = [format["%1", (date select 4)]] call WC_fnc_feelwithzero;
	_hour = [format["%1", (date select 3)]] call WC_fnc_feelwithzero;
	_day = [format["%1", (date select 2)]] call WC_fnc_feelwithzero;
	_month = [format["%1", (date select 1)]] call WC_fnc_feelwithzero;

	_date = _hour + ":" + _minute + " " + _day  + "/" + _month + "/" + format["%1", (date select 0)];
	_missiontext = [_date]  + _missiontext;

	diag_log format ["WARCONTEXT: MISSION:%1 TYPE:%2 DESCRIPTION: %3", _missionnumber, _missiontype, _missiontext];

	// for debug purpose 
	wctarget = _vehicle;

	sleep 30;

	wcobjective = [wcobjectiveindex, _vehicle, _missionnumber, _missionname, _missiontext];
	["wcobjective", "client"] call WC_fnc_publicvariable;

	if!(isDedicated) then {
		if(vehicle player == player) then {
		 	wcanim = [(wcobjective select 1)] spawn WC_fnc_camfocus;
		};
	};

	if(wcwithmarkerongoal == 2) then {
		"operationtext" setmarkerpos _position;
	};

	switch (_missiontype) do {
		case "destroy": {
			_vehicle removeAllEventHandlers "HandleDamage";
			_vehicle addeventhandler ['HandleDamage', {
				if (_this select 2 > wcdammagethreshold) then {
					(_this select 0) removeAllEventHandlers "HandleDamage";
					wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
					if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; };
					["wcmessageW", "client"] call WC_fnc_publicvariable;
					wcmissionsuccess = true;
					wcobjectiveindex = wcobjectiveindex + 1;
					(_this select 0) setdamage 1;
					wcleveltoadd = 1;
					wcfame = wcfame + wcbonusfame;
					wcenemyglobalelectrical = wcenemyglobalelectrical + wcbonuselectrical;
					wcenemyglobalfuel = wcenemyglobalfuel + wcbonusfuel;
					wcnuclearprobability = wcnuclearprobability + wcbonusnuclear;
				};
			}];

		};

		case "eliminate": {
			_vehicle removeAllEventHandlers "HandleDamage";
			_vehicle addeventhandler ['HandleDamage', {
				if(isplayer (_this select 3)) then {
					(_this select 0) setdamage 1;
				};
			}];
			_vehicle addeventhandler ['killed', {
				wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
				if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
				wcmissionsuccess = true;
				wcobjectiveindex = wcobjectiveindex + 1;
				wcleveltoadd = 1;
				wcfame = wcfame + wcbonusfame;
				wcenemyglobalelectrical = wcenemyglobalelectrical + wcbonuselectrical;
				wcenemyglobalfuel = wcenemyglobalfuel + wcbonusfuel;
				wcnuclearprobability = wcnuclearprobability + wcbonusnuclear;
			}];
		};

		case "ied": {
			_startposition = position _vehicle;
			sleep 10;
			waituntil {!(_vehicle getvariable "wciedactivate")};
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; } else {["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			wcleveltoadd = 1;
			wcfame = wcfame + wcbonusfame;
			wcenemyglobalelectrical = wcenemyglobalelectrical + wcbonuselectrical;
			wcenemyglobalfuel = wcenemyglobalfuel + wcbonusfuel;
			wcnuclearprobability = wcnuclearprobability + wcbonusnuclear;
		};

		case "jail": {
			_vehicle removeAllEventHandlers "HandleDamage";
			_vehicle addeventhandler ['HandleDamage', {
				private ["_distance"];
				if(isplayer (_this select 3)) then {
					//arcade = 1
					if(wckindofgame == 1) then {
						(_this select 0) setdamage (getdammage (_this select 0) + 0.1);
					} else {
						(_this select 0) setdamage 1;
					};
				};
			}];
		};

		case "sabotage": {

		};

		case "steal": {

		};

		case "rob": {

		};

		case "defend": {

		};

		case "build": {

		};

		case "secure": {

		};

		case "destroygroup" : {

		};

		case "bring" : {

		};

		case "bringunit" : {

		};
	};

	// create radio tower near side goal
	_position = [_position, wcradiodistminofgoal, wcradiodistmaxofgoal] call WC_fnc_createpositionaround;
	wcgarbage = [_position] spawn WC_fnc_createradio;

	// create an electrical generator
	_position = [_position, wcgeneratordistminofgoal, wcgeneratordistmaxofgoal] call WC_fnc_createpositionaround;
	wcgarbage = [_position] spawn WC_fnc_creategenerator;