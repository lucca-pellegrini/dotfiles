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

/* allow control key to trigger fail on clear */
static const int controlkeyclear = 1;

/* default message */
static const char * message = "This computer is LOCKED";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "-misc-hack-medium-r-normal--0-0-0-0-p-0-iso8859-16";
