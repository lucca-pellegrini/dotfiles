/* See LICENSE file for copyright and license details. */

/* appearance */
static       char font[]        = "monospace:size=9";
static       char* normbgcolor  = "#161821";
static       char* normfgcolor  = "#c6c8d1";
static       char* selbgcolor   = "#84a0c6";
static       char* selfgcolor   = "#161821";
static       char* urgbgcolor   = "#e27878";
static       char* urgfgcolor   = "#161821";
static const char before[]      = "<";
static const char after[]       = ">";
static const char titletrim[]   = "...";
static const int  tabwidth      = 200;
static const Bool foreground    = True;
static       Bool urgentswitch  = False;

/*
 * Where to place a new tab when it is opened. When npisrelative is True,
 * then the current position is changed + newposition. If npisrelative
 * is False, then newposition is an absolute position.
 */
static int  newposition   = 1;
static Bool npisrelative  = True;

#define SETPROP(p) { \
        .v = (char *[]){ "/bin/sh", "-c", \
                "prop=\"`xwininfo -children -id $1 | grep '^     0x' |" \
                "sed -e's@^ *\\(0x[0-9a-f]*\\) \"\\([^\"]*\\)\".*@\\1 \\2@' |" \
                "xargs -0 printf %b | dmenu -l 10 -w $1`\" &&" \
                "xprop -id $1 -f $0 8s -set $0 \"$prop\"", \
                p, winid, NULL \
        } \
}

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		{ "font",       STRING,  &font },
		{ "background", STRING,  &normbgcolor },
		{ "foreground", STRING,  &normfgcolor },
		{ "selbgcolor", STRING,  &selbgcolor },
		{ "selfgcolor", STRING,  &selfgcolor },
		{ "urgbgcolor", STRING,  &urgbgcolor },
		{ "urgfgcolor", STRING,  &urgfgcolor },
};

#define MODKEY ControlMask|Mod1Mask
static Key keys[] = {
	/* modifier             key        function     argument */
	{ MODKEY,               XK_Return, focusonce,   { 0 } },
	{ MODKEY,               XK_Return, spawn,       { 0 } },

	{ MODKEY,               XK_j,      rotate,      { .i = +1 } },
	{ MODKEY,               XK_k,      rotate,      { .i = -1 } },
	{ MODKEY,               XK_h,      movetab,     { .i = -1 } },
	{ MODKEY,               XK_l,      movetab,     { .i = +1 } },
	{ MODKEY,               XK_Tab,    rotate,      { .i = 0 } },

	/* { MODKEY,               XK_grave,  spawn,       SETPROP("_TABBED_SELECT_TAB") }, */
	{ MODKEY,               XK_1,      move,        { .i = 0 } },
	{ MODKEY,               XK_2,      move,        { .i = 1 } },
	{ MODKEY,               XK_3,      move,        { .i = 2 } },
	{ MODKEY,               XK_4,      move,        { .i = 3 } },
	{ MODKEY,               XK_5,      move,        { .i = 4 } },
	{ MODKEY,               XK_6,      move,        { .i = 5 } },
	{ MODKEY,               XK_7,      move,        { .i = 6 } },
	{ MODKEY,               XK_8,      move,        { .i = 7 } },
	{ MODKEY,               XK_9,      move,        { .i = 8 } },
	{ MODKEY,               XK_0,      move,        { .i = 9 } },

	{ MODKEY,               XK_q,      killclient,  { 0 } },

	{ MODKEY,               XK_u,      focusurgent, { 0 } },
	{ MODKEY|ShiftMask,     XK_u,      toggle,      { .v = (void*) &urgentswitch } },

	{ MODKEY,               XK_F11,    fullscreen,  { 0 } },

	{ ControlMask,          XK_Alt_L,     showbar,    { .i = 1 } },
	{ Mod1Mask,             XK_Control_L, showbar,    { .i = 1 } },
};

static Key keyreleases[] = {
	/* modifier             key            function     argument */
	{ MODKEY,               XK_Alt_L,     showbar,    { .i = 0 } },
	{ MODKEY,               XK_Control_L, showbar,    { .i = 0 } },
};
