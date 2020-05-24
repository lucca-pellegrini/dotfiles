/* user and group to drop privileges to */
static const char *user  = "jan";
static const char *group = "jan";

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
