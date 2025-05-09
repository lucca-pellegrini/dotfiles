/* user and group to drop privileges to */
static const char *user  = "luc";
static const char *group = "luc";

static const char *colorname[NUMCOLS] = {
	[BACKGROUND] = "black",   /* after initialization */
	[INIT]       = "#AAAAAA",   /* after initialization */
	[INPUT]      = "#005577",   /* during input */
	[FAILED]     = "#CC3333",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* default message */
static const char * message = "";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "-xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso10646-1";

/* allow control key to trigger fail on clear */
static const int controlkeyclear = 1;

 /* insert grid pattern with scale 1:1, the size can be changed with logosize */
 static const int logosize = 75;
 static const int logow    = 12; /* grid width and height for right center alignment*/
 static const int logoh    = 6;

 static XRectangle rectangles[9] = {
 	/* x	y	w	h */
 	{ 0,	3,	1,	3 },
 	{ 1,	3,	2,	1 },
 	{ 0,	5,	8,	1 },
 	{ 3,	0,	1,	5 },
 	{ 5,	3,	1,	2 },
 	{ 7,	3,	1,	2 },
 	{ 8,	3,	4,	1 },
 	{ 9,	4,	1,	2 },
 	{ 11,	4,	1,	2 },

 };
