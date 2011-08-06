	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// Warfare from Benny modified for warcontext 
	// -----------------------------------------------
	private ["_position", "_target"];

	_position = _this select 0;
	_target = "Fuel_can" createvehiclelocal _position;

	//--- Nuke blast.
	if (player distance _target < 3000) then {
		"dynamicBlur" ppEffectEnable true;
		"dynamicBlur" ppEffectAdjust [1];
		"dynamicBlur" ppEffectCommit 1;
		playsound "Nuke";
		addCamShake [25, 10, 25];
	};

	_Cone = "#particlesource" createVehicleLocal getPos _target;
	_Cone setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 10, [0, 0, 0],
					[0, 0, 0], 0, 1.275, 1, 0, [40,80], [[0.25, 0.25, 0.25, 0], [0.25, 0.25, 0.25, 0.5], 
					[0.25, 0.25, 0.25, 0.5], [0.25, 0.25, 0.25, 0.05], [0.25, 0.25, 0.25, 0]], [0.25], 0.1, 1, "", "", _target];
	_Cone setParticleRandom [2, [1, 1, 30], [1, 1, 30], 0, 0, [0, 0, 0, 0.1], 0, 0];
	_Cone setParticleCircle [10, [-10, -10, 20]];
	_Cone setDropInterval 0.005;
	
	_top = "#particlesource" createVehicleLocal getPos _target;
	_top setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 3, 48, 0], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 80], 0, 1.7, 1, 0, [180,150,180], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", _target];
	_top setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top setDropInterval 0.001;
	
	_top2 = "#particlesource" createVehicleLocal getPos _target;
	_top2 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 3, 112, 0], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 20], 0, 1.7, 1, 0, [80,80,100], [[1, 1, 1, 0.5],[1, 1, 1, 0]], [0.07], 1, 1, "", "", _target];
	_top2 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top2 setDropInterval 0.002;
	
	_smoke = "#particlesource" createVehicleLocal getPos _target;
	_smoke setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 80], 0, 1.7, 1, 0, [40,50,60], 
					[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", _target];
	_smoke setParticleRandom [0, [10, 10, 15], [15, 15, 7], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_smoke setDropInterval 0.002;
	
	_Wave = "#particlesource" createVehicleLocal getPos _target;
	_Wave setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], 
					[0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", _target];
	_Wave setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
	_Wave setParticleCircle [50, [-80, -80, 2.5]];
	_Wave setDropInterval 0.0002;
	
	_light = "#lightpoint" createVehicleLocal [((getPos _target select 0)),(getPos _target select 1),((getPos _target select 2)+500)];
	_light setLightAmbient[1500, 1200, 1000];
	_light setLightColor[1500, 1200, 1000];
	_light setLightBrightness 100000.0;
	
	if (player distance _target < 3000) then {
		"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [0.8, 15, 0, [0.5, 0.5, 0.5, 0], [0.0, 0.0, 0.6, 2],[0.3, 0.3, 0.3, 0.1]];"colorCorrections" ppEffectCommit 0.4;
		 
		"dynamicBlur" ppEffectAdjust [0.5];
		"dynamicBlur" ppEffectCommit 3;
	
		sleep 0.1;
	
		_xHandle = [] Spawn
		{
			Sleep 4;
			"colorCorrections" ppEffectAdjust [1.0, 0.5, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];
			"colorCorrections" ppEffectCommit 7;
		};
	
		"dynamicBlur" ppEffectAdjust [2];
		"dynamicBlur" ppEffectCommit 1;
	
		"dynamicBlur" ppEffectAdjust [0.5];
		"dynamicBlur" ppEffectCommit 4;
	};
	_light setLightBrightness 100000.0;
	
	sleep 3.5;
	
	_Wave setDropInterval 0.001;

	deleteVehicle _top;

	sleep 11;
	
	if (player distance _target < 4000) then {
		"colorCorrections" ppEffectAdjust [1, 1, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];"colorCorrections" ppEffectCommit 1; "colorCorrections" ppEffectEnable TRUE;
		"dynamicBlur" ppEffectAdjust [0];
		"dynamicBlur" ppEffectCommit 1;
	};
	
	sleep 0.6;
	deleteVehicle _light;
	sleep 4;

	deleteVehicle _top2;
	
	_Cone setDropInterval 0.01;
	_Wave setDropInterval 0.001;
	
	_smoke setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 80], 0, 1.7, 1, 0, [150,150,150], 
					[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", _target];
	_smoke setDropInterval 0.01;
	
	_smoke2 = "#particlesource" createVehicleLocal getPos _target;
	_smoke2 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 900],
					[0, 0, 25], 0, 1.7, 1, 0, [160,180,170], 
					[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", _target];
	_smoke2 setParticleRandom [0, [10, 10, 15], [15, 15, 7], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_smoke2 setDropInterval 0.01;
	
	sleep 5;
	//deleteVehicle _top5;
	_Cone setDropInterval 0.02;
	_Wave setDropInterval 0.01;
	
	sleep 5;
	deleteVehicle _smoke2;
	sleep 10;
	deleteVehicle _Wave;
	deleteVehicle _cone;
	deleteVehicle _smoke;
	sleep 20;