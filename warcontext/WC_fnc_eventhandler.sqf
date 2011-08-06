	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// Warcontext - async event handler

	private ["_variable", "_variablename"];

	wcqueue = [];

	WC_fnc_publicvariable = {
		private ["_variablename", "_variablevalue", "_type"];

		_variablename = _this select 0;
		_variablevalue =  call compile format["%1", _variablename];
		_type = _this select 1;

		wcaddqueue = [_variablename, _variablevalue, _type];
		if(isserver and local player) then {
			wcqueue = wcqueue + [wcaddqueue];
		} else {
			publicvariable "wcaddqueue";
		};
	};

	"wcaddqueue" addPublicVariableEventHandler {
		// insert message in the queue if its for server or everybody
		if(isserver) then {
			if( ((wcaddqueue select 2) == "server") or ((wcaddqueue select 2) == "all") ) then {
				wcqueue = wcqueue + [wcaddqueue];
			};
		};

		// insert message in the queue if its for client or everybody
		if(local player) then {
			if( ((wcaddqueue select 2) == "client") or ((wcaddqueue select 2) == "all") ) then {
				wcqueue = wcqueue + [wcaddqueue];
			};
		};
	};

	while { true } do {
		waituntil {count wcqueue > 0};
		_variablename = (wcqueue select 0) select 0;
		_variable = (wcqueue select 0) select 1;
		call compile format["wcgarbage = [_variable] spawn WC_fnc_netcode_%1;", _variablename];
		wcqueue set [0,-1]; 
		wcqueue = wcqueue - [-1];
	};

