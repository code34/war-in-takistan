// Spectating Script for Armed Assault
// by Kegetys <kegetys [ät] dnainternet.net>

#include "common.hpp"
#define BORDERSIZE		0.06
#define BORDERXSIZE		0.015
#define CMENUWIDTH		0.19
#define TMENUWIDTH		0.200
#define MENUHEIGHT		0.30
#define MAPWIDTH		0.3
#define MAPHEIGHT		0.30
#define MAPTXTSIZE		0.02
#define ELOGWIDTH		0.900
#define ELOGHEIGHT		0.0
#define IDC_MAIN		55001
#define IDC_CAMERA		55002
#define IDC_TARGET		55003
#define IDC_NAME		55004
#define IDC_MENUCAM		55005
#define IDC_MENUTGT		55006
#define IDC_MENUCAMB	55007
#define IDC_MENUTGTB	55008
#define IDC_BG1			55009
#define IDC_BG2			55010
#define IDC_TITLE		55011
#define IDC_HELP		55012
#define IDC_MAP			55013
#define IDC_MAPFULL		55014
#define IDC_MAPFULLBG	55015
#define IDC_EVENTLOG	50016
#define IDC_DEBUG		55100
#define IDC_BIRDMAP		50017
#define COL_ORANGE {1, 0.5, 0, 1}
#define COL_GRAY {0.2, 0.2, 0.2, 1}

class rscSpectate {
	idd = IDC_MAIN;
	movingEnable = false;
	class controls {
		class mouseHandler: KEGsRscControlsGroup {
			class ScrollBar {
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
				arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
				arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
				border = "\ca\ui\data\ui_border_scroll_ca.paa";
			};
			onMouseMoving = "[""MouseMoving"",_this] call spectate_events";
			onMouseButtonDown = "[""MouseButtonDown"",_this] call spectate_events";
			onMouseButtonUp = "[""MouseButtonUp"",_this] call spectate_events";
			onMouseZChanged = "[""MouseZChanged"",_this] call spectate_events";
			idc = 123;
			x = 0; y = 0;
			w = 1; h = 1;
			colorBackground[] = {0.2, 0, 0, 0};
		};
		class BackgroundTop: KEGsRscText {
			idc = IDC_BG1;
			x = -3; y = -1;
			w = 7; h = BORDERSIZE+1;
			colorBackground[] = {0, 0, 0, 1};
		};
		class BackgroundBottom: BackgroundTop {
			idc = IDC_BG2;
			y = 1-BORDERSIZE;
		};
		class title : BackgroundTop {
			idc = IDC_TITLE;
			colorBackground[] = {0, 0, 0, 0};
			text = "SPECTATING";
			style = 2;
			sizeEx = 0.035;
			colorText[] = {1, 0, 0, 1};
			shadow = true;
			y = 0;
			h = BORDERSIZE;
			font = "Zeppelin32";
		};
		class menuCameras : KEGsRscText {
			idc = IDC_MENUCAMB;
			style = ST_HUD_BACKGROUND;
			x = BORDERXSIZE;	y = BORDERSIZE;
			w = CMENUWIDTH;		h = MENUHEIGHT;
			text = "";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class menuCamerasLB : KEGsRscListBox {
			class ScrollBar {
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
				arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
				arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
				border = "\ca\ui\data\ui_border_scroll_ca.paa";
			};
			onLBSelChanged = "_this call KEGs_menucamslbchange";
			autoScrollRewind=0;
			autoScrollDelay=5;
			autoScrollSpeed=-1;
			maxHistoryDelay=1;
			idc = IDC_MENUCAM;
			x = BORDERXSIZE;	y = BORDERSIZE;
			w = CMENUWIDTH;		h = MENUHEIGHT;
			colorSelect[] = COL_ORANGE;
			colorSelect2[] = COL_ORANGE;
			colorSelectBackground[] = COL_GRAY;
			colorSelectBackground2[] = COL_GRAY;
			sizeEx = 0.025;
		};
		class menuTargets : KEGsRscText {
			idc = IDC_MENUTGTB;
			style = ST_HUD_BACKGROUND;
			x = 1-BORDERXSIZE-TMENUWIDTH;
			y = BORDERSIZE;
			w = TMENUWIDTH;	h = MENUHEIGHT;
			text = "";
			colorBackground[] = {0, 0, 0, 0.7};
		};
		class menuTargetsLB : KEGsRscListBox {
			class ScrollBar {
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
				arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
				arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
				border = "\ca\ui\data\ui_border_scroll_ca.paa";
			};
			autoScrollRewind=0;
			autoScrollDelay=5;
			autoScrollSpeed=-1;
			maxHistoryDelay=1;
			idc = IDC_MENUTGT;
			x = 1-BORDERXSIZE-TMENUWIDTH;
			y = BORDERSIZE;
			w = TMENUWIDTH;	h = MENUHEIGHT;
			colorSelect[] = COL_ORANGE;
			colorSelect2[] = COL_ORANGE;
			colorSelectBackground[] = COL_GRAY;
			colorSelectBackground2[] = COL_GRAY;
			colorScrollbar[] = COL_ORANGE;
			colorText[] = {1, 1, 1, 1};
			sizeEx = 0.025;
			period = 0;
		};
		class tCamera : KEGsRscActiveText {
			idc = IDC_CAMERA;
			x = BORDERXSIZE; y = 0;	w = 1-(2*BORDERXSIZE); h = BORDERSIZE;
			text = "Camera";
			style = 0;
			sizeEx = 0.025;
			color[] = {1, 1, 1, 0.9};
			shadow = true;
			font = "Zeppelin32";
			onMouseButtonUp = "[""ToggleCameraMenu"",0] call spectate_events";
		};
		class tTarget : tCamera {
			idc = IDC_TARGET;
			text = "Target";
			style = 1;
			onMouseButtonUp = "[""ToggleTargetMenu"",0] call spectate_events";
		};
		class tName : KEGsRscText {
			idc = IDC_NAME;
			x = BORDERXSIZE;y= 1-BORDERSIZE; w = 1-(BORDERXSIZE); h = BORDERSIZE;
			text = "Unknown";
			style = 0;
			sizeEx = 0.015;
			colorText[] = {1, 1, 1, 0.9};
			font = "Zeppelin32";
		};
		class tHelp : KEGsRscText {
			type = 13;
			idc = IDC_HELP;
			x = BORDERXSIZE*3;y=BORDERSIZE*3; w = 1-(2*BORDERXSIZE*3); h = 1-(2*BORDERSIZE*2);
			text = "";
			style = 2;
			sizeEx = 0.025;
			size = 0.025;
			colorText[] = {1, 1, 1, 1};
			color[] = {0, 0, 0, 1};
			font = "LucidaConsoleB";
			class Attributes{
				font = "Bitstream";
				color = "#ffffff";
				align = "left";
				shadow = true;
			};
		};
		class tDebug : tCamera {
			idc = IDC_DEBUG;
			text = "";
			style = 2;
			x = 0; y = 0;
			w = 1; h = 1;
			action ="";
		};
		class map : KEGsRscMapControl {
			colorOutside[] = {0,0,0,1};
			colorRailWay[] = {0,0,0,1};
			maxSatelliteAlpha = 0;
			alphaFadeStartScale = 1;
			alphaFadeEndScale = 1.1;
			class Task : Task {
				icon = "\ca\ui\data\map_waypoint_ca.paa";
				size = 20;
				color[] = {0,0.9,0,1};
				importance = "1.2 * 16 * 0.05";
				coefMin = 0.9;
				coefMax = 4;
			};
			class CustomMark : CustomMark {
				icon = "\ca\ui\data\map_waypoint_ca.paa";
				color[] = {0,0,1,1};
				size = 18;
				importance = 1;
				coefMin = 1;
				coefMax = 1;
			};
			idc = IDC_MAP;
			x = 1-MAPWIDTH;y=1-MAPHEIGHT;
			w = MAPWIDTH; h = MAPHEIGHT;
			colorBackground[] = {0.7, 0.7, 0.7, 0.75};
			sizeExLabel = MAPTXTSIZE;
			sizeExGrid = MAPTXTSIZE;
			sizeExUnits = MAPTXTSIZE;
			sizeExNames = MAPTXTSIZE;
			sizeExInfo = MAPTXTSIZE;
			sizeExLevel = MAPTXTSIZE;
			showCountourInterval = "false";
			onMouseZChanged = "[""MouseZChangedminimap"",_this] call spectate_events";
			class Command : Command {
				icon = "#(argb,8,8,3)color(1,1,1,1)";
				color[] = {0, 0, 0, 1};
				size = 18;
				importance = 1;
				coefMin = 1;
				coefMax = 1;
			};
			class ActiveMarker : ActiveMarker {
				color[] = {0.3, 0.1, 0.9, 1};
				size = 50;
			};
		};
		class mapFullBG : BackgroundTop {
			idc = IDC_MAPFULLBG;
			x = -3;y=-3;
			w = 9;h=9;
			colorBackground[] = {0, 0, 0, 1};
		};
		class mapFull : map {
			colorOutside[] = {0,0,0,1};
			colorRailWay[] = {0,0,0,1};
			maxSatelliteAlpha = 0;
			alphaFadeStartScale = 1;
			alphaFadeEndScale = 1.1;
			showCountourInterval = "true";
			idc = IDC_MAPFULL;
			x = 0;y=BORDERSIZE;
			w = 1;h=1-(BORDERSIZE*2);
			colorBackground[] = {0.85, 0.85, 0.85, 1};
		};
		class mapFullEventLog : KEGsRscListBox {
			class ScrollBar {
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
				arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
				arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
				border = "\ca\ui\data\ui_border_scroll_ca.paa";
			};
			autoScrollRewind=0;
			autoScrollDelay=5;
			autoScrollSpeed=-1;
			maxHistoryDelay=1;
			idc = IDC_EVENTLOG;
			x = 0;	y = 1-ELOGHEIGHT;
			w = ELOGWIDTH;		h = ELOGHEIGHT;
			colorText[] = {1, 1, 1, 0};
			colorSelect[] = {1, 1, 1, 0};
			colorSelect2[] = {1, 1, 1, 0};
			colorSelectBackground[] = {1, 1, 1, 0};
			colorSelectBackground2[] = {1, 1, 1, 0};
			colorBackground[] = {0, 0, 0, 0.5};
			colorScrollbar[] = {1, 1, 1, 0};
			sizeEx = 0.021;
		};
	};
};

class rscSpectateBirdMap {
	idd = IDC_BIRDMAP;
	movingEnable = false;
	class controls {
		class map : KEGsRscMapControl {
			colorOutside[] = {0,0,0,1};
			colorRailWay[] = {0,0,0,1};
			maxSatelliteAlpha = 0;
			alphaFadeStartScale = 1;
			alphaFadeEndScale = 1.1;
			class Task : Task {
				icon = "\ca\ui\data\map_waypoint_ca.paa";
				size = 20;
				color[] = {0,0.9,0,1};
				importance = "1.2 * 16 * 0.05";
				coefMin = 0.9;
				coefMax = 4;
			};
			class CustomMark : CustomMark {
				icon = "\ca\ui\data\map_waypoint_ca.paa";
				color[] = {0,0,1,1};
				size = 18;
				importance = 1;
				coefMin = 1;
				coefMax = 1;
			};
			idc = IDC_MAP;
			x = 1-MAPWIDTH;y=1-MAPHEIGHT;
			w = MAPWIDTH; h = MAPHEIGHT;
			colorBackground[] = {0.7, 0.7, 0.7, 0.75};
			sizeExLabel = MAPTXTSIZE;
			sizeExGrid = MAPTXTSIZE;
			sizeExUnits = MAPTXTSIZE;
			sizeExNames = MAPTXTSIZE;
			sizeExInfo = MAPTXTSIZE;
			sizeExLevel = MAPTXTSIZE;
			showCountourInterval = "false";

			class Command : Command {
				icon = "#(argb,8,8,3)color(1,1,1,1)";
				color[] = {0, 0, 0, 1};
				size = 18;
				importance = 1;
				coefMin = 1;
				coefMax = 1;
			};
			class ActiveMarker : ActiveMarker {
				color[] = {0.3, 0.1, 0.9, 1};
				size = 50;
			};
		};
		class BackgroundTop: KEGsRscText {
			idc = IDC_BG1;
			x = -3; y = -1;
			w = 7; h = BORDERSIZE+1;
			colorBackground[] = {0, 0, 0, 1};
		};
		class mapFullBG : BackgroundTop {
			idc = IDC_MAPFULLBG;
			x = -3;y=-3;
			w = 9;h=9;
			colorBackground[] = {0, 0, 0, 1};
		};
		class mapFull : map {
			colorOutside[] = {0,0,0,1};
			colorRailWay[] = {0,0,0,1};
			maxSatelliteAlpha = 0;
			alphaFadeStartScale = 1;
			alphaFadeEndScale = 1.1;
			showCountourInterval = "true";
			idc = IDC_MAPFULL;
			x = 0;y=BORDERSIZE;
			w = 1;h=1-(BORDERSIZE*2);
			colorBackground[] = {0.85, 0.85, 0.85, 1};
		};
	};
};