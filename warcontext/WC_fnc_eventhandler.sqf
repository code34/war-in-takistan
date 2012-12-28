	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// Warcontext - async event handler - message queue between clients & server

	private ["_variable", "_variablename"];

	wcqueue = [];

	WC_fnc_publicvariable = {
		private ["_variablename", "_variablevalue", "_type", "_playerid"];

		_variablename = _this select 0;
		_variablevalue =  call compile format["%1", _variablename];
		_type = _this select 1;
		_playerid = _this select 2;

		wcaddqueue = [_variablename, _variablevalue, _type];
		if(isserver and local player) then {
			wcqueue = wcqueue + [wcaddqueue];
		};

		switch (_type) do {
			case "server": {
				publicvariableserver "wcaddqueue";
			};

			case "client": {
				if(!isnil "_playerid") then {
					_playerid publicvariableclient "wcaddqueue";
				} else {
					publicvariable "wcaddqueue";
				};
			};

			default {
				publicvariable "wcaddqueue";
			};
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
		sleep 0.1;
	};

