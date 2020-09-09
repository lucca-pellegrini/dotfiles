/* user and group to drop privileges to */
static const char *user  = "nietzsche";
static const char *group = "nietzsche";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
	{ "init",    STRING,  &colorname[INIT] },
	{ "input",   STRING,  &colorname[INPUT] },
	{ "failed",  STRING,  &colorname[FAILED] },
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* time in seconds before the monitor shuts down */
static const int monitortime = 28800;

/* allow control key to trigger fail on clear */
static const int controlkeyclear = 1;

/* default message */
static const char * message = "Computer locked.";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "-xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso10646-1";
