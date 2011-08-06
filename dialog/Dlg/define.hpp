#define WCTEXTWIDTH			0.3
#define WCTEXTW				0.8
#define WCTEXTY				0.04
#define	WCSLIDERX			0.81
#define	WCSLIDERY			0.08
#define	WCSLIDERWIDTH			0.28
#define	WCTIMEX				0.8
#define	WCTIMEY				0.12
#define	WCTIMEWIDTH			0.30
#define CT_STATIC			0
#define CT_BUTTON			1
#define CT_EDIT				2
#define CT_SLIDER			3
#define CT_COMBO			4
#define CT_LISTBOX			5
#define CT_TOOLBOX			6
#define CT_CHECKBOXES		7
#define CT_PROGRESS			8
#define CT_HTML				9
#define CT_STATIC_SKEW		10
#define CT_ACTIVETEXT		11
#define CT_TREE				12
#define CT_STRUCTURED_TEXT	13 
#define CT_3DSTATIC			20
#define CT_3DACTIVETEXT		21
#define CT_3DLISTBOX		22
#define CT_3DHTML			23
#define CT_3DSLIDER			24
#define CT_3DEDIT			25
#define CT_OBJECT			80
#define CT_OBJECT_ZOOM		81
#define CT_OBJECT_CONTAINER	82
#define CT_OBJECT_CONT_ANIM	83
#define CT_USER				99

// Static styles
#define ST_HPOS				0x0F
#define ST_LEFT				0
#define ST_RIGHT			1
#define ST_CENTER			2
#define ST_UP				3
#define ST_DOWN				4
#define ST_VCENTER			5

#define ST_TYPE				0xF0
#define ST_SINGLE			0
#define ST_MULTI			16
#define ST_TITLE_BAR		32
#define ST_PICTURE			48
#define ST_FRAME			64
#define ST_BACKGROUND		80
#define ST_GROUP_BOX		96
#define ST_GROUP_BOX2		112
#define ST_HUD_BACKGROUND	128
#define ST_TILE_PICTURE		144
#define ST_WITH_RECT		160
#define ST_LINE				176

#define ST_SHADOW			256
#define ST_NO_RECT			512

#define ST_TITLE			ST_TITLE_BAR + ST_CENTER

#define FontHTML			"Zeppelin32"
#define FontM				"Zeppelin32"

#define Dlg_ROWS			36
#define Dlg_COLS			90

#define Dlg_CONTROLHGT		((100/Dlg_ROWS)/100)
#define Dlg_COLWIDTH		((100/Dlg_COLS)/100)

#define Dlg_TEXTHGT_MOD		0.9
#define Dlg_ROWSPACING_MOD	1.3

#define Dlg_ROWHGT			(Dlg_CONTROLHGT*Dlg_ROWSPACING_MOD)
#define Dlg_TEXTHGT			(Dlg_CONTROLHGT*Dlg_TEXTHGT_MOD)

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
#define CT_SHORTCUTBUTTON   16
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
#define CT_LISTNBOX         102

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar 
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4

class RscText
{
	access = 0;
	type = 0;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {0.8784,0.8471,0.651,1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 2;
	font = "Zeppelin32";
	SizeEx = 0.03921;
};
class RscStructuredText
{
	access = 0;
	type = 13;
	idc = -1;
	style = 0;
	colorText[] = {0.8784,0.8471,0.651,1};
	class Attributes
	{
		font = "Zeppelin32";
		color = "#e0d8a6";
		align = "center";
		shadow = 1;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = 0.03921;
	shadow = 2;
};
class RscPicture
{
	access = 0;
	type = 0;
	idc = -1;
	style = 48;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
};
class RscEdit
{
	access = 0;
	type = 2;
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	colorBackground[] = {0,0,0,1};
	colorText[] = {0.95,0.95,0.95,1};
	colorSelection[] = {0.8784,0.8471,0.651,1};
	autocomplete = "";
	text = "";
	size = 0.2;
	style = "0x00 + 0x40";
	font = "Zeppelin32";
	shadow = 2;
	sizeEx = 0.03921;
};
class RscCombo
{
	access = 0;
	type = 4;
	style = 0;
	colorSelect[] = {0.023529,0,0.0313725,1};
	colorText[] = {0.023529,0,0.0313725,1};
	colorBackground[] = {0.95,0.95,0.95,1};
	colorScrollbar[] = {0.023529,0,0.0313725,1};
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 1;
	class ScrollBar
	{
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		shadow = 0;
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	shadow = 0;
	colorSelectBackground[] = {0.8784,0.8471,0.651,1};
	arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
	arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	color[] = {0,0,0,0.6};
	colorActive[] = {0,0,0,1};
	colorDisabled[] = {0,0,0,0.3};
	font = "Zeppelin32";
	sizeEx = 0.03921;
};
class RscListBox
{
	access = 0;
	type = 5;
	w = 0.4;
	h = 0.4;
	rowHeight = 0;
	colorText[] = {0.8784,0.8471,0.651,1};
	colorScrollbar[] = {0.95,0.95,0.95,1};
	colorSelect[] = {0.95,0.95,0.95,1};
	colorSelect2[] = {0.95,0.95,0.95,1};
	colorSelectBackground[] = {0,0,0,1};
	colorSelectBackground2[] = {0.8784,0.8471,0.651,1};
	colorBackground[] = {0,0,0,1};
	soundSelect[] = {"",0.1,1};
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	class ScrollBar
	{
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		shadow = 0;
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
	style = 16;
	font = "Zeppelin32";
	shadow = 2;
	sizeEx = 0.03921;
	color[] = {1,1,1,1};
	period = 1.2;
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
};
class RscButton
{
	access = 0;
	type = 1;
	text = "";
	colorText[] = {0.8784,0.8471,0.651,1};
	colorDisabled[] = {0.4,0.4,0.4,1};
	colorBackground[] = {1,0.537,0,0.5};
	colorBackgroundDisabled[] = {0.95,0.95,0.95,1};
	colorBackgroundActive[] = {1,0.537,0,1};
	colorFocused[] = {1,0.537,0,1};
	colorShadow[] = {0.023529,0,0.0313725,1};
	colorBorder[] = {0.023529,0,0.0313725,1};
	soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
	soundPush[] = {"\ca\ui\data\sound\new1",0,0};
	soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
	soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "Zeppelin32";
	sizeEx = 0.03921;
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
};
class RscShortcutButton
{
	type = 16;
	x = 0.1;
	y = 0.1;
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
	shortcuts[] = {};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] = {0.8784,0.8471,0.651,1};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {1,1,1,1};
	colorBackground2[] = {1,1,1,0.4};
	class Attributes
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	idc = -1;
	style = 0;
	default = 0;
	shadow = 2;
	w = 0.183825;
	h = 0.104575;
	periodFocus = 1.2;
	periodOver = 0.8;
	animTextureNormal = "\ca\ui\data\ui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\ui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_default_ca.paa";
	period = 0.4;
	font = "Zeppelin32";
	size = 0.03921;
	sizeEx = 0.03921;
	text = "";
	soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
	soundPush[] = {"\ca\ui\data\sound\new1",0,0};
	soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
	soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
	action = "";
	class AttributesImage
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
	};
};
class RscShortcutButtonMain
{
	idc = -1;
	style = 0;
	default = 0;
	w = 0.313726;
	h = 0.104575;
	color[] = {0.8784,0.8471,0.651,1};
	colorDisabled[] = {1,1,1,0.25};
	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0.0204;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	class TextPos
	{
		left = 0.08;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	animTextureNormal = "\ca\ui\data\ui_button_main_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_main_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_main_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_main_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\ui_button_main_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_main_normal_ca.paa";
	period = 0.5;
	font = "Zeppelin32";
	size = 0.03921;
	sizeEx = 0.03921;
	text = "";
	soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
	soundPush[] = {"\ca\ui\data\sound\new1",0,0};
	soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
	soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
	action = "";
	class Attributes
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class AttributesImage
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "false";
	};
};
class RscFrame
{
	type = 0;
	idc = -1;
	style = 64;
	shadow = 2;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "Zeppelin32";
	sizeEx = 0.02;
	text = "";
};
class RscSlider
{
	access = 0;
	type = 3;
	style = 1024;
	w = 0.3;
	color[] = {1,1,1,0.8};
	colorActive[] = {1,1,1,1};
	shadow = 0;
	h = 0.025;
};
class RscMapControl 
	{
		type = 101;
		moveOnEdges = 1;
		sizeEx = 0.025;
		style = 48;
		x = 0.2;
		y = 0.2;
		w = 0.2;
		h = 0.2;
		ptsPerSquareSea = 8;
		ptsPerSquareTxt = 10;
		ptsPerSquareCLn = 10;
		ptsPerSquareExp = 10;
		ptsPerSquareCost = 10;
		ptsPerSquareFor = "6.0f";
		ptsPerSquareForEdge = "15.0f";
		ptsPerSquareRoad = "3f";
		ptsPerSquareObj = 15;
		showCountourInterval = "false";
		maxSatelliteAlpha = 0.75;
		alphaFadeStartScale = 0.15;
		alphaFadeEndScale = 0.29;
		colorLevels[] = {0.65, 0.6, 0.45, 1};
		colorSea[] = {0.46, 0.65, 0.74, 0.5};
		colorForest[] = {0.45, 0.64, 0.33, 0.5};
		colorRocks[] = {0, 0, 0, 0.3};
		colorCountlines[] = {0.85, 0.8, 0.65, 1};
		colorMainCountlines[] = {0.45, 0.4, 0.25, 1};
		colorCountlinesWater[] = {0.25, 0.4, 0.5, 0.3};
		colorMainCountlinesWater[] = {0.25, 0.4, 0.5, 0.9};
		colorPowerLines[] = {0.1, 0.1, 0.1, 1};
		colorRailWay[] = {0.8, 0.2, 0, 1};
		colorForestBorder[] = {0, 0, 0, 0};
		colorRocksBorder[] = {0, 0, 0, 0};
		colorNames[] = {0.1, 0.1, 0.1, 0.9};
		colorInactive[] = {1, 1, 1, 0.5};
		colorText[] = {0, 0, 0, 1};
		colorBackground[] = {0.8, 0.8, 0.8, 1};
		font = "EtelkaNarrowMediumPro";
		colorOutside[] = {0, 0, 0, 1};
		fontLabel = "Zeppelin32";
		sizeExLabel = 0.034;
		fontGrid = "Zeppelin32";
		sizeExGrid = 0.03;
		fontUnits = "Zeppelin32";
		sizeExUnits = 0.034;
		fontNames = "Zeppelin32";
		sizeExNames = 0.056;
		fontInfo = "Zeppelin32";
		sizeExInfo = 0.034;
		fontLevel = "Zeppelin32";
		sizeExLevel = 0.024;
		text = "\ca\ui\data\map_background2_co.paa";
	
	class Task 
	{
		icon = "\ca\ui\data\ui_taskstate_current_CA.paa";
		iconCreated = "\ca\ui\data\ui_taskstate_new_CA.paa";
		iconCanceled = "#(argb,8,8,3)color(0,0,0,0)";
		iconDone = "\ca\ui\data\ui_taskstate_done_CA.paa";
		iconFailed = "\ca\ui\data\ui_taskstate_failed_CA.paa";
		color[] = {0.863, 0.584, 0.0, 1};
		colorCreated[] = {0.95, 0.95, 0.95, 1};
		colorCanceled[] = {0.606, 0.606, 0.606, 1};
		colorDone[] = {0.424, 0.651, 0.247, 1};
		colorFailed[] = {0.706, 0.0745, 0.0196, 1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class CustomMark 
	{
		icon = "\ca\ui\data\map_waypoint_ca.paa";
		color[] = {0.6471, 0.6706, 0.6235, 1.0};
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class Legend 
	{
		x = "SafeZoneX";
		y = "SafeZoneY";
		w = 0.34;
		h = 0.152;
		font = "Zeppelin32";
		sizeEx = 0.03921;
		colorBackground[] = {0.906, 0.901, 0.88, 0};
		color[] = {0, 0, 0, 1};
	};
	
	class Bunker
	{
		icon = "\ca\ui\data\map_bunker_ca.paa";
		size = 14;
		color[] = {0, 0, 1, 1};
		importance = 1.5 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Bush 
	{
		icon = "\ca\ui\data\map_bush_ca.paa";
		color[] = {0.55, 0.64, 0.43, 1};
		size = 14;
		importance = 0.2 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class BusStop
	{
		icon = "\ca\ui\data\map_busstop_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 12;
		importance = 1 * 10 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Command 
	{
		icon = "\ca\ui\data\map_waypoint_ca.paa";
		color[] = {0, 0.9, 0, 1};
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class Cross 
	{
		icon = "\ca\ui\data\map_cross_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 0.7 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Fortress
	{
		icon = "\ca\ui\data\map_bunker_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Fuelstation 
	{
		icon = "\ca\ui\data\map_fuelstation_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.75;
		coefMax = 4;
	};
	
	class Fountain
	{
		icon = "\ca\ui\data\map_fountain_ca.paa";
		color[] = {0.2, 0.45, 0.7, 1};
		size = 11;
		importance = 1 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Hospital 
	{
		icon = "\ca\ui\data\map_hospital_ca.paa";
		color[] = {0.78, 0, 0.05, 1};
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Chapel
	{
		icon = "\ca\ui\data\map_chapel_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 16;
		importance = 1 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Church
	{
		icon = "\ca\ui\data\map_church_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Lighthouse
	{
		icon = "\ca\ui\data\map_lighthouse_ca.paa";
		size = 14;
		color[] = {0, 0.9, 0, 1};
		importance = 3 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Quay 
	{
		icon = "\ca\ui\data\map_quay_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Rock 
	{
		icon = "\ca\ui\data\map_rock_ca.paa";
		color[] = {0.1, 0.1, 0.1, 0.8};
		size = 12;
		importance = 0.5 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Ruin 
	{
		icon = "\ca\ui\data\map_ruin_ca.paa";
		size = 16;
		color[] = {0, 0.9, 0, 1};
		importance = 1.2 * 16 * 0.05;
		coefMin = 1;
		coefMax = 4;
	};
	
	class SmallTree
	{
		icon = "\ca\ui\data\map_smalltree_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 12;
		importance = 0.6 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Stack 
	{
		icon = "\ca\ui\data\map_stack_ca.paa";
		size = 20;
		color[] = {0, 0.9, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Tree
	{
		icon = "\ca\ui\data\map_tree_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 12;
		importance = 0.9 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Tourism 
	{
		icon = "\ca\ui\data\map_tourism_ca.paa";
		size = 16;
		color[] = {0.78, 0, 0.05, 1};
		importance = 1 * 16 * 0.05;
		coefMin = 0.7;
		coefMax = 4;
	};
	
	class Transmitter
	{
		icon = "\ca\ui\data\map_transmitter_ca.paa";
		color[] = {0, 0.9, 0, 1};
		size = 20;
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class ViewTower
	{
		icon = "\ca\ui\data\map_viewtower_ca.paa";
		color[] = {0, 0.9, 0, 1};
		size = 16;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Watertower 
	{
		icon = "\ca\ui\data\map_watertower_ca.paa";
		color[] = {0.2, 0.45, 0.7, 1};
		size = 20;
		importance = 1.2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Waypoint
	{
		icon = "\ca\ui\data\map_waypoint_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 14;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class WaypointCompleted
	{
		icon = "\ca\ui\data\map_waypoint_completed_ca.paa";
		color[] = {0, 0, 1, 1};
		size = 14;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class ActiveMarker
	{
		icon = "";
		color[] = {0, 0, 1, 1};
		size = 14;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
};

class RscIGUIShortcutButton : RscShortcutButton 
	{
		w = 0.183825;
		h = 0.0522876;
		style = 2;
		color[] = {1, 1, 1, 1};
		color2[] = {1, 1, 1, 0.85};
		colorBackground[] = {1, 1, 1, 1};
		colorbackground2[] = {1, 1, 1, 0.85};
		colorDisabled[] = {1, 1, 1, 0.4};
	
	class HitZone 
	{
		left = 0.002;
		top = 0.003;
		right = 0.002;
		bottom = 0.016;
	};
	
	class ShortcutPos 
	{
		left = -0.006;
		top = -0.007;
		w = 0.0392157;
		h = 0.0522876;
	};
	
	class TextPos 
	{
		left = 0.02;
		top = 0.0;
		right = 0.002;
		bottom = 0.016;
	};
		animTextureNormal = "\ca\ui\data\igui_button_normal_ca.paa";
		animTextureDisabled = "\ca\ui\data\igui_button_disabled_ca.paa";
		animTextureOver = "\ca\ui\data\igui_button_over_ca.paa";
		animTextureFocused = "\ca\ui\data\igui_button_focus_ca.paa";
		animTexturePressed = "\ca\ui\data\igui_button_down_ca.paa";
		animTextureDefault = "\ca\ui\data\igui_button_normal_ca.paa";
	
	class Attributes 
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "center";
		shadow = "true";
	};
};
	
class New_Btn 
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
		font = "Zeppelin32";
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
	
class RscXSliderH 
{
	idc = -1;
	type = 43;
	style = 0x400  + 0x10;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.4;
	color[] = {1, 1, 1, 0.4};
	colorActive[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.2};
	arrowEmpty = "\ca\ui\data\ui_arrow_left_ca.paa";
	arrowFull = "\ca\ui\data\ui_arrow_left_active_ca.paa";
	border = "\ca\ui\data\ui_border_frame_ca.paa";
	thumb = "\ca\ui\data\ui_slider_bar_ca.paa";
};

class RscClickableText 
	{
		idc = -1;
		type = 11;
		style = 48 + 0x800;
		color[] = {0.75,0.75,0.75,1};
		colorActive[] = {1,1,1,1};
		colorBackground[] = {0.6, 0.8392, 0.4706, 1.0};
		colorBackgroundSelected[] = {0.6, 0.8392, 0.4706, 1.0};
		colorFocused[] = {0.0, 0.0, 0.0, 0};
		font = "Zeppelin32";
		sizeEx = 0.03921;
		soundClick[] = {"ui\ui_ok",0.2,1};
		soundDoubleClick[] = {"", 0.1, 1};
		soundEnter[] = {"ui\ui_over",0.2,1};
		soundEscape[] = {"ui\ui_cc",0.2,1};
		soundPush[] = {, 0.2, 1};
		w = 0.275;
		h = 0.04;
		text = "";
	};

