	// ANTI-TURNOVER TANK v1.0, By Miguel Rodriguez (mgllgm@hotmail.com - Murcielago_ESP)
	// sanity vehicle by code34

	private ["_vehicle", "_vel", "_dir", "_velocidad"];
	
	_vehicle = _this select 0;
	
	while {alive(_vehicle)} do {
		_vel = velocity _vehicle;
		_dir = direction _vehicle;
		_velocidad = (velocity _vehicle select 2);
		
		If ((vectorUp _vehicle select 2) < 0.55) Then {
			_vehicle setVectorUp [(vectorUp _vehicle select 0)*0.5, (vectorUp _vehicle select 1)*0.5, 0.60];
		};
		
		If ( (((velocity _vehicle select 2) - _velocidad > 4)) ) Then {
			_vehicle setPos [ getPos _vehicle select 0, getPos _vehicle select 1, 0.5]; 
			_vehicle setVelocity [((_vel select 0)+(sin _dir))*0.5,((_vel select 1)+(cos _dir))*0.5,0];
		};
		sleep 0.5;
	};


