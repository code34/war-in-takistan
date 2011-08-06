scriptName "Functions\systems\fn_RESPECT.sqf";
/*
	File: RESTECP
	Author: Karel Moricky

	Description:
	RESpect - The Effective Calculation Process.

	Parameter(s):
	_this select 0: String - Mode


	* SET - set respect default values
		 o _this select 1: Nothing or Object
		 o Returned value: Array with zero respect values (if Object is passed as argument, 1 is on place of object's faction).
	* ADD - add respect values depending on global town respect
		 o _this select 1: Object - Unit to which is given respect from assigned town with random difference defined in third argument.
		 o _this select 2: Number - Range of random difference.
		 o Returned value: Unit's respect values. 
	* MODIFY - change givern respect value
		 o _this select 1: Object - Unit of which respect value will be changed.
		 o _this select 2: String - Faction of which respect will be changed.
		 o _this select 3: String - Code which defines formula for change (current respect value is stored in variable _r) - e.g. "_r / 2"
		 o Returned value: Modified respect value. 
	* KILLED - Modify global town respect after civilian has been killed.
		 o _this select 1: Object - Units's killer
		 o _this select 2: Object - Town logic
		 o _this select 3: Number - Optional - change coeficient
		 o Returned value: Modified town respect value. 

*/
private ["_result","_array","_factions","_factionsCount","_who","_range","_twn","_whorespect","_twnrespect","_faction","_value","_newrespect","_r"];
_result = -1;

switch (_this select 0) do {

	//-----------------------------------------------------------------------------------------------	
	//--- SET ---------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------
	case "SET": {
		_array = [];
		_factions = [] call BIS_fnc_getFactions;
		_factionsCount = count _factions;
		for "_i" from 0 to (_factionsCount - 1) do {
			_array set [_i,0];
		};
		//--- Second param - Unit
		if (count _this > 1) then {
			_who = _this select 1;
			_faction = [_who] call BIS_fnc_getFactions;
			if (_faction >= 0) then {
				_array set [_faction,1];
				_who setvariable ["respect",_array,true];
			};

		};
		_result = _array;
	};


	//-----------------------------------------------------------------------------------------------	
	//--- ADD ---------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------
	case "ADD": {
		_who = _this select 1;
		_range = _this select 2;
		_twn = _who getvariable "ALICE_twn";
		_whorespect = [];
		_twnrespect = _twn getvariable "respect";
		if!(typeName _twnrespect == "ARRAY") then { _twnrespect = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];};
		{
			_whorespect = _whorespect + [_x - (_range / 2) + random _range];
		} foreach _twnrespect;
		_who setvariable ["respect",_whorespect,true];
		_result = _whorespect;
	};


	//-----------------------------------------------------------------------------------------------	
	//--- MODIFY ------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------
	case "MODIFY": {
		private ["_who","_faction","_value","_respect","_newrespect"];
		_who = _this select 1;
		_faction = _this select 2;
		_value = _this select 3;

		if (typename _faction == "OBJECT") then {_faction = [_who] call BIS_fnc_getFactions};
		if (typename _faction == "STRING") then {_faction = [_faction] call BIS_fnc_getFactions};
		if (typename _value == "SCALAR") then {_value = "+" + str(_value)};

		_respect = +(_who getvariable "respect");
		if (isnil "_respect") then {_respect = ["SET",_who] call BIS_fnc_respect};
		_newrespect = -1;
		_r = _respect select _faction;
		call compile format ["_newrespect = %1",_value];
		if (_newrespect > +1) then {_newrespect = +1};
		if (_newrespect < -1) then {_newrespect = -1};

		_respect set [_faction,_newrespect];
		_who setvariable ["respect",_respect,true];
		_result = _newrespect;

		//--- Event Handler
		_code = _who getvariable "respect_handler";
		if (!isnil "_code") then {
			[_who,_faction,_r,_newrespect] spawn _code;
		};
	};


	//-----------------------------------------------------------------------------------------------	
	//--- AFTER DEATH -------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------
	case "KILLED": {
		private ["_twn","_who","_whoRespect","_twnRespect","_factions","_faction","_neighbors","_coef","_changeNeighbors"];
		_who = _this select 1;
		_twn = _this select 2;
		_changeNeighbors = if (count _this > 3) then {_this select 3} else {false};
		_coef = if (count _this > 4) then {_this select 4} else {2 + random 4};

		_whoRespect = +(_who getvariable "respect");
		_twnRespect = +(_twn getvariable "respect");
		if (isnil "_whoRespect") then {_whoRespect = ["SET",_who] call BIS_fnc_respect};


		_factions = [] call BIS_fnc_getFactions;
		for "_i" from 0 to (count _factions - 1) do {


			[
				"MODIFY",
				_twn,
				_i,
				format ["_r - %1 * %2",_whorespect select _i,_coef]
			] call BIS_fnc_respect;
		};
		//if (cheat6) then {hint format ["Before:\n%1\n\nAfter:\n%2\n\nKiller's respect:\n%3",_twnRespect,_twn getvariable "respect",_whoRespect]};
		_result = +(_twn getvariable "respect");

		//--- Modify respect also for neighbors
		_neighbors = +(_twn getvariable "neighbors");

		if (_changeNeighbors && !isnil "_neighbors") then {
			["MODIFY",_who,_who,"_r * 9/10"] call BIS_fnc_respect;
			{
				["KILLED",_who,_x,false,_coef / 2] call BIS_fnc_respect;
			} foreach _neighbors;
		};
	};


	//-----------------------------------------------------------------------------------------------	
	//--- DEFAULT -----------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------
	default {hintc "NO RESTECP!\nError in respect evaluation script."};

};

_result;