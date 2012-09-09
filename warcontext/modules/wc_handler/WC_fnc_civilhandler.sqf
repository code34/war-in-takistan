		// -----------------------------------------------
		// Author: team  code34 nicolas_boiteux@yahoo.fr
		// WARCONTEXT - Description: Handler for all civil
		// -----------------------------------------------	

		private ["_group"];

		_group = _this select 0;

		{
			wcgarbage = [_x, wcskill] spawn WC_fnc_setskill;

			_x addEventHandler ['HandleDamage', {
				if!((_this select 0) == (_this select 3)) then {
					(_this select 0) setdamage (0.5 + (random 0.5));
				};
			}];
	
			_x addeventhandler ['killed', {
				wcgarbage = _this spawn WC_fnc_garbagecollector;
				if((name (_this select 1)) in wcinteam) then {
					wcnumberofkilledofmissionC = wcnumberofkilledofmissionC + 1;
					wccivilkilled =  wccivilkilled + 1;
					["wccivilkilled", "client"] call WC_fnc_publicvariable;
					wcfame = wcfame - random (0.1);
				};
			}];
	
			_x addeventhandler ['FiredNear', {
				(_this select 0) playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon';
				(_this select 0) stop true;
			}];


			// unlimited ammo for civilians
			if!((typeof _x) in wccivilwithoutweapons) then {
				_x addEventHandler ['Fired', '(_this select 0) setvehicleammo 1;'];
			};
			sleep 0.1;
		} foreach (units _group);