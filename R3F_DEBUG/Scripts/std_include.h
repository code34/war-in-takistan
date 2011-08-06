/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100913
********************************************************************************************/

#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUT_BUTTON  16

#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_List_N_Box       102

#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0c

#define ST_TYPE           0xF0
#define ST_SINGLE         0
#define ST_MULTI          16
#define ST_TITLE_BAR      32
#define ST_PICTURE        48
#define ST_FRAME          64
#define ST_BACKGROUND     80
#define ST_GROUP_BOX      96
#define ST_GROUP_BOX2     112
#define ST_HUD_BACKGROUND 128
#define ST_TILE_PICTURE   144
#define ST_WITH_RECT      160
#define ST_LINE           176

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

#define LB_TEXTURES       0x10
#define LB_MULTI          0x20


#define Color_KackG 				{0.36, 0.4, 0.38, 1}
#define Color_KackY					{0.8, 0.7, 0.6, 1}
#define Color_KackB 				{0.51, 0.48, 0.46, 1}
#define Color_WhiteDark 			{1, 1, 1, 0.5}
#define Color_White					{1, 1, 1, 1}
#define Color_Black 				{0, 0, 0, 1}
#define Color_Gray 					{1, 1, 1, 0.5}
#define Color_GrayLight 			{0.6, 0.6, 0.6, 1}
#define Color_GrayDark 				{0.2, 0.2, 0.2, 1}
#define Color_DarkRed 				{0.5, 0.1, 0, 0.5}
#define Color_Green 				{0.8, 0.9, 0.4, 1}
#define Color_Orange 				{0.9, 0.45, 0.1, 1}
#define Color_Red 					{0.9, 0.2, 0.2, 1}
#define Color_Blue 					{0.2, 0.2, 0.9, 1}
#define Color_NoColor				{0, 0, 0, 0}

#define TextSize_IGUI_normal 		0.023
#define TextSize_small 				0.022
#define TextSize_normal 			0.024
#define TextSize_medium 			0.027
#define TextSize_large  			0.057

#define FontHTML			"Zeppelin32"
#define FontM				"Zeppelin32"

class R3F_DEBUG_RscText
{
	type = CT_STATIC;
	idc = -1;
	style = ST_LEFT;
	x = 0.0;
	y = 0.0;
	w = 0.3;
	h = 0.03;
	sizeEx = 0.023;
	colorBackground[] = {0.5, 0.5, 0.5, 0.75};
	colorText[] = { 0, 0, 0, 1 };
	font = FontM;
	text = "";
};

class R3F_DEBUG_RscTitle : R3F_DEBUG_RscText
{
	type = CT_STATIC;
	colorBackground[] = { 0 , 0.2471 , 0, 0 };
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.03;
	style = ST_LEFT + ST_SHADOW;
	color[] = Color_White;
	colorText[] = Color_White;
	sizeEx = 0.03; 
	text = "";
};

class R3F_DEBUG_RscBtn
{
	idc = -1;
	type = 16;
	style = 0;
	
	text = "btn";
	action = "";

	x = 0;
	y = 0;
	
	w = 0.23;
	h = 0.104575;

	size = 0.03921;
	sizeEx = 0.03921;

	color[] = {0.543, 0.5742, 0.4102, 1.0};
	color2[] = {0.95, 0.95, 0.95, 1};
	colorBackground[] = {1, 1, 1, 1};
	colorbackground2[] = {1, 1, 1, 0.4};
	colorDisabled[] = {1, 1, 1, 0.25};
	periodFocus = 1.2;
	periodOver = 0.8;
	
	class HitZone 
	{
		left = 0.004;
		top = 0.029;
		right = 0.004;
		bottom = 0.029;
	};
	
	class ShortcutPos 
	{
		left = 0.0145;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	
	class TextPos 
	{
		left = 0.05;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	

	textureNoShortcut = "";
	animTextureNormal = "\ca\ui\data\ui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\ui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_default_ca.paa";
	period = 0.4;
	font = FontM;


	soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
	soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
	
	class Attributes 
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	
	class AttributesImage 
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
};

class R3F_DEBUG_RscMap : R3F_DEBUG_RscText
{
	idc = -1;
    type = CT_MAP_MAIN;
    style =ST_PICTURE;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	
    colorBackground[] = Color_White;
    colorText[] = Color_Black;
    colorSea[] = {0.56, 0.80, 0.98, 0.50};
    colorForest[] = {0.60, 0.80, 0.20, 0.50};
    colorRocks[] = {0.50, 0.50, 0.50, 0.50};
    colorCountlines[] = {0.65, 0.45, 0.27, 0.50};
    colorMainCountlines[] = {0.65, 0.45, 0.27, 1.00};
    colorCountlinesWater[] = {0.00, 0.53, 1.00, 0.50};
    colorMainCountlinesWater[] = {0.00, 0.53, 1.00, 1.00};
    colorForestBorder[] = {0.40, 0.80, 0.00, 1.00};
    colorRocksBorder[] = {0.50, 0.50, 0.50, 1.00};
    colorPowerLines[] = {0.00, 0.00, 0.00, 1.00};
    colorNames[] = {0.00, 0.00, 0.00, 1.00};
    colorInactive[] = {1.00, 1.00, 1.00, 0.50};
    colorLevels[] = {0.00, 0.00, 0.00, 1.00};
    colorRailWay[] = {0.00, 0.00, 0.00, 1.00};
    colorOutside[] = {0.00, 0.00, 0.00, 1.00};

    font = "TahomaB";
    sizeEx = 0.040000;

    stickX[] = {0.20, {"Gamma", 1.00, 1.50} };
    stickY[] = {0.20, {"Gamma", 1.00, 1.50} };
    ptsPerSquareSea = 6;
    ptsPerSquareTxt = 8;
    ptsPerSquareCLn = 8;
    ptsPerSquareExp = 8;
    ptsPerSquareCost = 8;
    ptsPerSquareFor = "4.0f";
    ptsPerSquareForEdge = "10.0f";
    ptsPerSquareRoad = 2;
    ptsPerSquareObj = 10;

	fontLabel = "Zeppelin32";
	sizeExLabel = 0.034000;
	fontGrid = "Zeppelin32";
	sizeExGrid = 0.034000;
	fontUnits = "Zeppelin32";
	sizeExUnits = 0.034000;
	fontNames = "Zeppelin32";
	sizeExNames = 0.056000;
	fontInfo = "Zeppelin32";
	sizeExInfo = 0.034000;
	fontLevel = "Zeppelin32";
	sizeExLevel = 0.034000;
    
    maxSatelliteAlpha = 0; 
    alphaFadeStartScale = 1.0; 
    alphaFadeEndScale = 1.1;

    showCountourInterval=2;
    scaleDefault = 0.5;
    onMouseButtonClick = "";
    onMouseButtonDblClick = "";
	
	text = "\ca\ui\data\map_background2_co.paa";

	class CustomMark {
		icon = "\ca\ui\data\map_waypoint_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};

	class Legend {
		x = -1;
		y = -1;
		w = 0.340000;
		h = 0.152000;
		font = "Zeppelin32";
		sizeEx = 0.039210;
		colorBackground[] = {0.906000, 0.901000, 0.880000, 0.800000};
		color[] = {0, 0, 0, 1};
	};

	class Bunker {
		icon = "\ca\ui\data\map_bunker_ca.paa";
        color[] = {0, 0.900000, 0, 1};
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};

	class Bush {
		icon = "\ca\ui\data\map_bush_ca.paa";
		color[] = {0.550000, 0.640000, 0.430000, 1};
		size = 14;
		importance = "0.2 * 14 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};

	class BusStop {
		icon = "\ca\ui\data\map_busstop_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 10;
		importance = "1 * 10 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};

	class Command {
		icon = "\ca\ui\data\map_waypoint_ca.paa";
		color[] = {0, 0.900000, 0, 1};
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};

	class Cross {
		icon = "\ca\ui\data\map_cross_ca.paa";
        color[] = {0, 0.900000, 0, 1};
		size = 16;
		importance = "0.7 * 16 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};

	class Fortress {
		icon = "\ca\ui\data\map_bunker_ca.paa";
        color[] = {0, 0.900000, 0, 1};
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};

	class Fuelstation {
		icon = "\ca\ui\data\map_fuelstation_ca.paa";
        color[] = {0, 0.900000, 0, 1};
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.750000;
		coefMax = 4;
	};

	class Fountain {
		icon = "\ca\ui\data\map_fountain_ca.paa";
		color[] = {0, 0.350000, 0.700000, 1};
		size = 12;
		importance = "1 * 12 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};

	class Hospital {
		icon = "\ca\ui\data\map_hospital_ca.paa";
		color[] = {0.780000, 0, 0.050000, 1};
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.500000;
		coefMax = 4;
	};

	class Chapel {
		icon = "\ca\ui\data\map_chapel_ca.paa";
        color[] = {0, 0.900000, 0, 1};
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};

	class Church {
		icon = "\ca\ui\data\map_church_ca.paa";
        color[] = {0, 0.900000, 0, 1};
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};

	class Lighthouse {
		icon = "\ca\ui\data\map_lighthouse_ca.paa";
		color[] = {0.780000, 0, 0.050000, 1};
		size = 20;
		importance = "3 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};

	class Quay {
		icon = "\ca\ui\data\map_quay_ca.paa";
        color[] = {0, 0.900000, 0, 1};
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.500000;
		coefMax = 4;
	};

	class Rock {
		icon = "\ca\ui\data\map_rock_ca.paa";
        color[] = {0, 0.900000, 0, 1};
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};

	class Ruin {
		icon = "\ca\ui\data\map_ruin_ca.paa";
		color[] = {0.780000, 0, 0.050000, 1};
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
	};

	class SmallTree {
		icon = "\ca\ui\data\map_smalltree_ca.paa";
		color[] = {0.550000, 0.640000, 0.430000, 1};
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};

	class Stack {
		icon = "\ca\ui\data\map_stack_ca.paa";
        color[] = {0, 0.900000, 0, 1};
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};

	class Tree {
		icon = "\ca\ui\data\map_tree_ca.paa";
		color[] = {0.550000, 0.640000, 0.430000, 1};
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};

	class Tourism {
		icon = "\ca\ui\data\map_tourism_ca.paa";
		color[] = {0.780000, 0, 0.050000, 1};
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.700000;
		coefMax = 4;
	};

	class Transmitter {
		icon = "\ca\ui\data\map_transmitter_ca.paa";
        color[] = {0, 0.900000, 0, 1};
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};

	class ViewTower {
		icon = "\ca\ui\data\map_viewtower_ca.paa";
        color[] = {0, 0.900000, 0, 1};
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.500000;
		coefMax = 4;
	};

	class Watertower {
		icon = "\ca\ui\data\map_watertower_ca.paa";
		color[] = {0, 0.350000, 0.700000, 1};
		size = 32;
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};

	class Waypoint {
		icon = "\ca\ui\data\map_waypoint_ca.paa";
        size = 20;
        color[] = {0, 0.900000, 0, 1};
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};

	class Task {
		icon = "\ca\ui\data\ui_taskstate_current_CA.paa";
		iconCreated = "\ca\ui\data\ui_taskstate_new_CA.paa";
		iconCanceled = "#(argb,8,8,3)color(0,0,0,0)";
		iconDone = "\ca\ui\data\ui_taskstate_done_CA.paa";
		iconFailed = "\ca\ui\data\ui_taskstate_failed_CA.paa";
		color[] = {0.863,0.584,0,1};
		colorCreated[] = {0.95,0.95,0.95,1};
		colorCanceled[] = {0.606,0.606,0.606,1};
		colorDone[] = {0.424,0.651,0.247,1};
		colorFailed[] = {0.706,0.0745,0.0196,1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};

	class WaypointCompleted {
		icon = "\ca\ui\data\map_waypoint_completed_ca.paa";
        size = 20;
        color[] = {0, 0.900000, 0, 1};
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};

	class ActiveMarker {
		icon = "\ca\ui\data\map_waypoint_completed_ca.paa";
        size = 20;
        color[] = {0, 0.900000, 0, 1};
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};
};

class R3F_DEBUG_Editor
{
	access = 0;
	type = CT_EDIT;
	h = 0.04;
	colorBackground[] = Color_Black;
	colorText[] = Color_White;
	colorSelection[] = Color_Black;
	text = "";
	size = 0.2;
	style = ST_LEFT + ST_MULTI;
	font = FontM;
	sizeEx = TextSize_small;
	autocomplete = true;
};

class R3F_DEBUG_List
{
	type = CT_LISTBOX;
	style = ST_LEFT;
	idc = -1;
	text = "";
	w = 0.275;
	h = 0.04;
	colorSelect[] = Color_White;
	colorText[] = Color_White;
	colorBackground[] = {0.95,0.95,0.95,1};
	colorSelectBackground[] = Color_Black;
	colorScrollbar[] = Color_GrayDark;
	arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
	arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	rowHeight = 0.03;
	color[] = Color_White;
	colorActive[] = {0,0,0,1};
	colorDisabled[] = {0,0,0,0.3};
	font = "Zeppelin32";
	sizeEx = 0.029;
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
    autoScrollDelay = 5;
    autoScrollRewind = 0;
	class ScrollBar
	{
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
};

class R3F_DEBUG_Edit
{
	access = 0;
	type = CT_EDIT;
	h = 0.04;
	colorBackground[] = Color_Black;
	colorText[] = Color_White;
	colorSelection[] = Color_Black;
	autocomplete = "";
	text = "";
	size = 0.2;
	style = ST_LEFT;
	font = FontM;
	sizeEx = TextSize_small;
};

class  R3F_DEBUG_StructuredText
{ 
	idc = -1; 
	type = CT_STRUCTURED_TEXT; 
	style = ST_LEFT; 
	colorBackground[] = { 1, 1, 1, 1 };
	x = 0.1;
	y = 0.1;
	w = 0.3;
	h = 0.1;
	size = 0.018;
	text = "";
	class Attributes {
		font = "TahomaB";
		color = "#000000";
		align = "center";
		valign = "middle";
		shadow = false;
		shadowColor = "#ff0000";
		size = "1"; 
	}; 
};