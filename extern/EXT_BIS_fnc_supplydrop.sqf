/*
	File: supplydrop.sqf
	Author: Vilem

	Description:
	Script for para-drop of objects. Spawns waitUntil that handles ground hit (detaching of object from parachute). Used by supplydrop service.

	Parameter(s):
	1: <object> air unit
	2: <string> object class that will be dropped (use: "reammobox" or "land" for dropping ammobox/car appropriate to side of air vehicle)
	
	Returns:
	N/A
*/



/////* SMOKE*/////

FNC_SMOKE = {
  [_this select 0,[0.45,0.67,0.5,0]] spawn {
  	_sh=_this select 0;
  	_col=_this select 1;
  	_c1=_col select 0;
  	_c2=_col select 1;
  	_c3=_col select 2;
  	
  	sleep (20+random 1);
  	_source = "#particlesource" createVehicleLocal getpos _sh;
  	_source setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 20, [0, 0, 0],
  					[0.2, 0.1, 0.1], 0, 1.277, 1, 0.025, [0.1, 2, 6], [[_c1, _c2, _c3, 0.2], [_c1, _c2, _c3, 0.05], [_c1, _c2, _c3, 0]],
  					 [1.5,0.5], 1, 0.04, "", "", _sh];
  	_source setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
  	_source setDropInterval 0.50;
  	
  	_source2 = "#particlesource" createVehicleLocal getpos _sh;
  	_source2 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 12, 8, 0], "", "Billboard", 1, 20, [0, 0, 0],
  					[0.2, 0.1, 0.1], 0, 1.277, 1, 0.025, [0.1, 2, 6], [[_c1, _c2, _c3, 1], [_c1, _c2, _c3, 0.5], [_c1, _c2, _c3, 0]],
  					 [0.2], 1, 0.04, "", "", _sh];
  	_source2 setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.2], 0, 0, 360];
  	_source2 setDropInterval 0.50;
  	
  	sleep (50+random 5);
  	deletevehicle _source;
  };
};

/////* SMOKE-END*/////






scriptName "Functions\systems\fn_supplydrop.sqf";
if (isNil  {(_this select 0)}) exitWith {};
if (isNull (_this select 0)) exitWith {};

private ["_side","_paraSize","_paraName","_paraPos","_veh","_dropPos","_dropHeight","_pos","_classNameToDrop","_classNameToDropOrig","_cargoPos","_cargoRelPos","_crate","_para"];
_paraSize = 1; //0...small 1...medium (default) 2...big     //TODO: 0 - set other _cargoRelPos (parachute hits crate and disappears)

_veh = _this select 0;
_dropPos = position (_this select 0);
sleep 0.02;

if (count _this < 1) then {_classNameToDrop = "land";} else {_classNameToDrop = _this select 1;};
   		
_classNameToDropOrig = _classNameToDrop;
if (_classNameToDrop == "reammobox") then  	
{
  _classNameToDrop = "USBasicAmmunitionBox";
  if ((side _veh) == east) then {_classNameToDrop = "RUBasicAmmunitionBox"}; //RULaunchersBox //RUOrdnanceBox //RUBasicWeaponsBox //RUSpecialWeaponsBox //RUVehicleBox
  if ((side _veh) == resistance) then {_classNameToDrop = "GuerillaCacheBox"}; //SpecialWeaponsBox
};
	
if (_classNameToDrop == "land") then
{    
 _paraSize = 2; //big chute
 
 _classNameToDrop = "HMMWV_M2"; //HMMWV
 if ((side _veh) == east) then {_classNameToDrop = "UAZ_MG_INS"}; //RULaunchersBox //RUOrdnanceBox //RUBasicWeaponsBox //RUSpecialWeaponsBox //RUVehicleBox
 if ((side _veh) == resistance) then {_classNameToDrop = "UAZ_MG_INS"}; //SpecialWeaponsBox    
};

_paraName = "";
switch (_paraSize) do 
{    
  _side = side _veh;
  if (!(_side in ["East","West"])) then {_side = "West";};
  	case 0: {_paraName = format["Parachute%1",_side],;}; //ParachuteMediumEast or ParachuteMediumWest not "FLY" (that spawns 150 m above ground) }; 
  	case 1: {_paraName = format["ParachuteMedium%1",_side];}; //ParachuteMediumEast or ParachuteMediumWest not "FLY" (that spawns 150 m above ground) }; 
  	case 2: {_paraName = format["ParachuteBig%1",_side];};
  	
	default {debugLog format ["DROP_ ERROR: Wrong _paraSize"];};
};

//debugLog format["SUPPLYDROP_ Pos cargoRelPos _cargoPos %1",[_pos,_cargoRelPos, _cargoPos]];


_pos = [(_dropPos select 0), (_dropPos select 1), (_dropPos select 2) - 30];

//_smoke = "SmokeShellGreen" createvehicle [(_dropPos select 0),(_dropPos select 1),0]

debugLog format["DROP_ side %1 para %2 size %3",_side,_para, _paraSize];   

_cargoRelPos = [0,0,0];
_cargoPos = [(_pos select 0) + (_cargoRelPos select 0), (_pos select 1) + (_cargoRelPos select 1), (_pos select 2) + (_cargoRelPos select 2)];

_crate = createvehicle [_classNameToDrop,_cargoPos,[],0,"NONE"];		
_crate setVelocity [(((velocity _veh) select 0) / 2),(((velocity _veh) select 1) / 2),((velocity _veh) select 2)-25];
_crate setDir (direction _veh);



debugLog format["SUPPLYDROP_ Pos cargoRelPos _cargoPos actpos %1",[_pos,_cargoRelPos, _cargoPos, position _crate]];


if (_classNameToDropOrig != "reammobox") then 
  {sleep 0.7;} //a bit of delay (cannot be used for ammoboxes (wrong simulation))
  else
  {[_crate] call FNC_SMOKE;}; //ammoboxes smoke

_cratePos = position _crate;

if ((_cratePos select 2)< 0) then {_cratePos = _cargoPos;}; //HACK: ammoboxes are created under ground
_pos = _cratePos;

_paraPos = [(_pos select 0) + (_cargoRelPos select 0), (_pos select 1) + (_cargoRelPos select 1), (_pos select 2) + (_cargoRelPos select 2)];
_para = createvehicle [_paraName, _paraPos ,[],0,"NONE"]; //not "FLY" (that spawns 150 m above ground)
_para setDir (direction _veh);
_para setVelocity [((velocity _crate) select 0),((velocity _crate) select 1) ,((velocity _crate) select 2) ];

_crate attachTo [_para,[0,0,0],"paraEnd"]; 
debugLog format["DROP_  -> pos %1 %2",position _para,_classNameToDrop];

sleep 1.0;

[_crate, _para,_classNameToDrop] spawn {
	_crate = _this select 0;
	_para = _this select 1;
	_classNameToDrop = _this select 2;
 	private ["_groundHitPos"];
	_groundHitPos = [1,1,1];

	if ((_crate isKindOf "ReammoBox")) then {
	  	//ammocrates ignore setvelocity - let them go more close to ground, ammocrates also have bad position -> using _para above ground instead also
	  	WaitUntil {
			if(!isNil "_para") then {
				_groundHitPos = position _para
			};
			groundHitPos = _groundHitPos;
			debugLog format ["SUPPLYD ROP_ crate flying down: %1", ((position _crate) select 2)]; 
			(((((position _crate) select 2) < 0.1) && (((position _crate) select 2) >= 0.0)) || ((position _para) select 2 < 3)  || (isNil "_para"))
		};
	  	detach _crate; 
	  	debugLog format ["SUPPLYD ROP_ ground hit: %1", ((position _crate) select 2)];
	
	  	private ["_crateDir"];
	  	_crateDir = direction _crate;
	  	deleteVehicle _crate;
	  	
	  	_crate = createvehicle [_classNameToDrop,[_groundHitPos select 0, _groundHitPos select 1, 0.0],[],0,"NONE"];		
	  	_crate setDir _crateDir;
	  	
	  	crateDebug = _crate;
	} else {
	  	WaitUntil {
			debugLog format ["SUPPLYD ROP_ crate flying down: %1", ((position _crate) select 2)];
			((((position _crate) select 2) < 0.6) || (isNil "_para"))
		};
	  	detach _crate;
	  	_crate SetVelocity [0,0,-5];           
	  	debugLog format ["SUPPLYD ROP_ ground hit: %1", ((position _crate) select 2)];
	  	sleep 0.3;
	  	_crate setPos [(position _crate) select 0, (position _crate) select 1, 0.6];
	};
};
debugLog format ["SUPPLYDROP_ on ground: %1", ((position _crate) select 2)];

_crate;
