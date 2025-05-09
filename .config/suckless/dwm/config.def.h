/* See LICENSE file for copyright and license details. */

#include <stdlib.h>

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 20;       /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "JetBrainsMono Nerd Font Propo:size=9" };
static const char dmenufont[]       = "JetBrainsMono Nerd Font Propo:size=10";
static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]            = "#005577";
static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

/* tagging */
static const char *tags[] = { "", "", "", "󰷝", "", "󰮃", "𝅘𝅥𝅮", "󱋊", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class         instance    title       tags mask    iscentered    isfloating    isterminal    noswallow    monitor */
	{ "LibreWolf",   NULL,       NULL,       1 << 2,      0,            0,            0,           -1,           -1 },
	{ "Element",     NULL,       NULL,       1 << 7,      0,            0,            0,           -1,           -1 },
	{ "Signal",      NULL,       NULL,       1 << 7,      0,            0,            0,           -1,           -1 },
	{ "Telegram",    NULL,       NULL,       1 << 7,      0,            0,            0,           -1,           -1 },
	{ "WhatsApp",    NULL,       NULL,       1 << 7,      0,            0,            0,           -1,           -1 },
	{ "KeePassXC",   NULL,       NULL,       1 << 8,      0,            0,            0,           -1,           -1 },
	{ NULL,       "float",       NULL,            0,      1,            1,            0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "",      monocle },   /* first entry is default */
	{ "🖽",      tile },
	{ "",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
	{ MOD, XK_j,     ACTION##stack, {.i = INC(+1) } }, \
	{ MOD, XK_k,     ACTION##stack, {.i = INC(-1) } }, \
	{ MOD, XK_grave, ACTION##stack, {.i = PREVSEL } }, \
	/*{ MOD, XK_f,     ACTION##stack, {.i = 0 } },*/
	/*{ MOD, XK_x,     ACTION##stack, {.i = -1 } },*/

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-w", "245", "-x", "10", "-y", "30" };
static const char *termcmd[]  = { "alacritty", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_b,      togglebar,      {0} },

  /* realod colorscheme */
	{ MODKEY,                       XK_F5,     xrdb,           {.v = NULL } },

	/* layouts */
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_f,      togglefullscr,  {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_space,  zoom,           {0} },

	/* window managment */
	STACKKEYS(MODKEY,                          focus)
	STACKKEYS(MODKEY|ShiftMask,                push)

	{ MODKEY|ControlMask,           XK_j,      shiftview,      {.i = +1 } },
	{ MODKEY|ControlMask,           XK_k,      shiftview,      {.i = -1 } },

	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1 } },

	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },

	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },

	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },

	/* monitors */
	{ MODKEY,                       XK_Left,   focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_Right,  focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Left,   tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Right,  tagmon,         {.i = +1 } },

	/* gaps */
	{ MODKEY|ControlMask,           XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY|ControlMask,           XK_equal,  setgaps,        {.i = +1 } },
	{ MODKEY|ControlMask,           XK_0,      setgaps,        {.i = 0  } },

	/* programs */
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_x,      spawn,          SHCMD("xkill") },
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_c,      spawn,          SHCMD("clipmenu") },

	{ MODKEY|ALTKEY,                XK_f,      spawn,          SHCMD("st -e vf") },
	{ MODKEY|ALTKEY,                XK_m,      spawn,          SHCMD("st -n float -g 120x36 -e ncmpcpp") },
	{ MODKEY|ALTKEY,                XK_v,      spawn,          SHCMD("st -e vim") },
	{ MODKEY|ALTKEY,                XK_a,      spawn,          SHCMD("st -e alsamixer") },
	{ MODKEY|ALTKEY,                XK_p,      spawn,          SHCMD("st -e pulsemixer") },
	{ MODKEY|ALTKEY,                XK_w,      spawn,          SHCMD("dmenuqbpm") },

	/* scripts */
	{ MODKEY|ControlMask,           XK_q,      spawn,          SHCMD("prompt 'Shutdown computer?' 'shutdown -h now'") },
	{ MODKEY|ControlMask,           XK_x,      spawn,          SHCMD("prompt 'Lock screen' 'slock & mpc pause'") },
	{ MODKEY|ControlMask,           XK_BackSpace, spawn,       SHCMD("prompt 'Reboot computer?' 'reboot'") },

	{ MODKEY|ControlMask,           XK_d,      spawn,          SHCMD("dmenuducky") },
	{ MODKEY|ControlMask,           XK_i,      spawn,          SHCMD("dmenuunicode") },
	{ MODKEY|ControlMask,           XK_o,      spawn,          SHCMD("dmenunewtab") },
	{ MODKEY|ControlMask,           XK_n,      spawn,          SHCMD("dmenuiwd") },
	{ MODKEY|ControlMask,           XK_m,      spawn,          SHCMD("dmenumount") },
	{ MODKEY|ControlMask,           XK_u,      spawn,          SHCMD("dmenuumount") },
	{ MODKEY|ControlMask,           XK_e,      spawn,          SHCMD("dmenueject") },
	{ MODKEY|ControlMask,           XK_t,      spawn,          SHCMD("dmenutmux") },
	{ MODKEY,                       XK_End,    spawn,          SHCMD("dmenuscreen") },
	{ MODKEY,                       XK_p,      spawn,          SHCMD("dmenumonitor") },
	{ MODKEY,                       XK_Insert, spawn,          SHCMD("showclip") },
	{ MODKEY,                       XK_Escape, spawn,          SHCMD("dmenupower") },
	{ MODKEY|ControlMask,           XK_Insert, spawn,          SHCMD("blaze") },
	{ MODKEY|ControlMask,           XK_w,      spawn,          SHCMD("blaze -s") },
	{ MODKEY|ControlMask,           XK_Delete, spawn,          SHCMD("dmenureload") },
	{ MODKEY|ControlMask,           XK_p,      spawn,          SHCMD("passmenu2 --type") },
	{ MODKEY|ALTKEY,                XK_k,      spawn,          SHCMD("keepassmenu") },
	{ MODKEY|ALTKEY,                XK_t,      spawn,          SHCMD("keepassotp") },
	{ MODKEY|ShiftMask,             XK_g,      spawn,          SHCMD("genpass") },
	{ MODKEY|ControlMask,           XK_g,      spawn,          SHCMD("genpass '' bex base58 -w0") },
	{ MODKEY|ALTKEY,                XK_g,      spawn,          SHCMD("gendicewarepass") },
	{ MODKEY|ControlMask,           XK_c,      spawn,          SHCMD("dmenucloak") },
	{ MODKEY|ControlMask,           XK_a,      spawn,          SHCMD("dmenuaudio") },
	{ MODKEY,                       XK_F12,    spawn,          SHCMD("dmenusteam") },
	{ MODKEY|ShiftMask,             XK_F12,    spawn,          SHCMD("steam -shutdown") },
	{ MODKEY,                       XK_Pause,  spawn,          SHCMD("nyrna --toggle") },

	/* media */
	{ (unsigned int)NULL,           XF86XK_AudioMute, spawn,   SHCMD("amixer sset Master toggle") },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          SHCMD("mpc toggle") },

	{ MODKEY,                       XK_comma,  spawn,          SHCMD("mpc prev; dunstify \"$(mpc current)\"") },
	{ MODKEY|ShiftMask,             XK_comma,  spawn,          SHCMD("mpc seek 0%") },
	{ MODKEY,                       XK_period, spawn,          SHCMD("mpc next; dunstify \"$(mpc current)\"") },
	{ MODKEY|ShiftMask,             XK_period, spawn,          SHCMD("mpc repeat")  },

	{ MODKEY,                       XK_bracketleft,    spawn,  SHCMD("mpc seek -10") },
	{ MODKEY|ShiftMask,             XK_bracketleft,    spawn,  SHCMD("mpc seek -60") },
	{ MODKEY,                       XK_bracketright,   spawn,  SHCMD("mpc seek +10") },
	{ MODKEY|ShiftMask,             XK_bracketright,   spawn,  SHCMD("mpc seek +60") },

	/* volume */
	{ MODKEY|ShiftMask,             XK_equal,                spawn, SHCMD("volume mpc up")  },
	{ MODKEY|ShiftMask,             XK_minus,                spawn, SHCMD("volume mpc down")  },
	{ (unsigned int)NULL,           XF86XK_AudioRaiseVolume, spawn, SHCMD("volume alsa up") },
	{ (unsigned int)NULL,           XF86XK_AudioLowerVolume, spawn, SHCMD("volume alsa down") },

	/* backlight */
	{ (unsigned int)NULL,           XF86XK_MonBrightnessUp,   spawn, SHCMD("brightness up")   },
	{ (unsigned int)NULL,           XF86XK_MonBrightnessDown, spawn, SHCMD("brightness down") },

	/* workspaces */
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	/*{ MODKEY|ShiftMask,             XK_BackSpace, quit,        {0} },*/
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

void
setlayoutex(const Arg *arg)
{
	setlayout(&((Arg) { .v = &layouts[arg->i] }));
}

void
viewex(const Arg *arg)
{
	view(&((Arg) { .ui = 1 << arg->ui }));
}

void
viewall(const Arg *arg)
{
	view(&((Arg){.ui = ~0}));
}

void
toggleviewex(const Arg *arg)
{
	toggleview(&((Arg) { .ui = 1 << arg->ui }));
}

void
tagex(const Arg *arg)
{
	tag(&((Arg) { .ui = 1 << arg->ui }));
}

void
toggletagex(const Arg *arg)
{
	toggletag(&((Arg) { .ui = 1 << arg->ui }));
}

void
tagall(const Arg *arg)
{
	tag(&((Arg){.ui = ~0}));
}

/* signal definitions */
/* signum must be greater than 0 */
/* trigger signals using `xsetroot -name "fsignal:<signame> [<type> <value>]"` */
static Signal signals[] = {
	/* signum           function */
	{ "focusmon",       focusmon },
	{ "focusstack",     focusstack },
	{ "incnmaster",     incnmaster },
	{ "killclient",     killclient },
	{ "quit",           quit },
	{ "setlayout",      setlayout },
	{ "setlayoutex",    setlayoutex },
	{ "setmfact",       setmfact },
	{ "tag",            tag },
	{ "tagall",         tagall },
	{ "tagex",          tagex },
	{ "tagmon",         tagmon },
	{ "togglebar",      togglebar },
	{ "togglefloating", togglefloating },
	{ "toggletag",      tag },
	{ "toggletagex",    toggletagex },
	{ "toggleview",     view },
	{ "toggleviewex",   toggleviewex },
	{ "view",           view },
	{ "viewall",        viewall },
	{ "viewex",         viewex },
	{ "xrdb",           xrdb },
	{ "zoom",           zoom },
};

// vim: ft=ch
