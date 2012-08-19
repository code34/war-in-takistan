		// -----------------------------------------------
		// Author: team  code34 nicolas_boiteux@yahoo.fr
		// warcontext - Do light depending overcast
		// -----------------------------------------------	
	
		private [
			"_density", 
			"_light"
		];

		while { true } do {
			_density = overcast;
			if(vehicle player == player) then {
				_light = 1.4 - _density;
			} else {
				if((vehicle player) isKindOf "Air") then {
					_light = 1.6 - _density;
				};
			};

			if!(wcplayerinnuclearzone) then {
				if(wcwithlight == 1) then {
					"colorCorrections" ppEffectEnable true; 
					"colorCorrections" ppEffectAdjust [1, _light, 0, [0, 0.0, 0.0,0], [1, 1, 1, 1],  [0.0001, 1, 0.01, 1]];   
					"colorCorrections" ppEffectCommit 1;
				};
				if(wcwithinjuredeffect == 1) then {
					sleep (10 - ((getdammage player) * 10));
					if(getdammage player > 0.2) then {
						"colorCorrections" ppEffectEnable true; 
						"colorCorrections" ppEffectAdjust [1,_light,0,[1,0,0,0],[0.6,0,0,0],[1,0,0,0]];   
						"colorCorrections" ppEffectCommit 1;
						sleep 1;
					};
				};
			} else {
				sleep 1;
			};
		};