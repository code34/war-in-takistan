		// -----------------------------------------------
		// Author: team  code34 nicolas_boiteux@yahoo.fr
		// WARCONTEXT - Description: Handler for all enemy units
		// -----------------------------------------------	

		private ["_vehicle"];

		_vehicle = _this select 0;

		_vehicle addeventhandler ['killed', {
			_this spawn WC_fnc_garbagecollector; 
		}];

		if(isnil "mando_missile_init_done") then {
			_vehicle removeAllEventHandlers "HandleDamage";
		};

		_vehicle addeventhandler ['HandleDamage', {
			private ["_name", "_gunner", "_commander"];
			if(side(_this select 3) in [west, civilian]) then {
				if ((_this select 2) > wcdammagethreshold) then {
					(_this select 0) removeAllEventHandlers "HandleDamage";
					(_this select 0) setHit [(_this select 1), (_this select 2)];
					if(damage (_this select 0) > 0.9) then {
						(_this select 0) setdamage 1;
						wcnumberofkilledofmissionV = wcnumberofkilledofmissionV + 1;
					};
				};
				_name = currentMagazine (_this select 3);
				_name = getText (configFile >> "CfgMagazines" >> _name >> "displayNameShort");
				if!(_name == "SD") then {
					_gunner = gunner (_this select 0);
					_commander = commander (_this select 0);
					{
						_x reveal (_this select 3);
						_x dotarget (_this select 3);
						_x dofire (_this select 3);
					}foreach [_gunner, _commander];
				};
			};
		}];

		_vehicle addEventHandler ['Fired', '
			_increase = ceil(random 5);
			if((wcalert + _increase) < 101) then {
				wcalert = wcalert + _increase;
			} else {
				wcalert = 100;
			};
		'];

		_vehicle addeventhandler ['FiredNear', {
			private ["_gunner", "_commander"];
			if(side(_this select 1) in [west, civilian]) then {
				_gunner = gunner (_this select 0);
				_commander = commander (_this select 0);
				{
					_x reveal (_this select 1);
					_x dotarget (_this select 1);
					_x dofire (_this select 1);
				}foreach [_gunner, _commander];
			};
		}];

		wcvehicles = wcvehicles + [_vehicle];