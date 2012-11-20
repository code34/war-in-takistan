	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// Delete of mission list, all missions in safe zone

	wcallbaracks = nearestObjects [wcmapcenter, wckindofbarracks, 20000];
	{
		wcallbaracks = [wcallbaracks, _x, wcalertzonesize] call WC_fnc_farofpos;
	}foreach wcsecurezone;
	if(count(wcallbaracks) == 0) then {
		wcmissiondone = wcmissiondone + [56];
	};
	
	wcallhangars = nearestObjects [wcmapcenter, wckindofhangars, 20000];
	{
		wcallhangars = [wcallhangars, _x, wcalertzonesize] call WC_fnc_farofpos;
	}foreach wcsecurezone;
	if(count(wcallhangars) == 0) then {
		wcmissiondone = wcmissiondone + [12,43,44,46,49,58,59,60,61,62,71];
	};
	
	wcalloilpumps = nearestObjects [wcmapcenter, wckindofoilpumps, 20000];
	{
		wcalloilpumps = [wcalloilpumps, _x, wcalertzonesize] call WC_fnc_farofpos;
	}foreach wcsecurezone;
	if(count(wcalloilpumps) == 0) then {
		wcmissiondone = wcmissiondone + [63,72];
	};
	
	wcallfuelstations = nearestObjects [wcmapcenter, wckindoffuelstations, 20000];
	{
		wcallfuelstations = [wcallfuelstations, _x, wcalertzonesize] call WC_fnc_farofpos;
	}foreach wcsecurezone;
	if(count(wcallfuelstations) == 0) then {
		wcmissiondone = wcmissiondone + [65];
	};
	
	wcallcontroltowers = nearestObjects [wcmapcenter, wckindofcontroltowers, 20000];
	{
		wcallcontroltowers = [wcallcontroltowers, _x, wcalertzonesize] call WC_fnc_farofpos;
	}foreach wcsecurezone;
	if(count(wcallcontroltowers) == 0) then {
		wcmissiondone = wcmissiondone + [77];
	};