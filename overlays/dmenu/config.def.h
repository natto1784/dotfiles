/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 1;                    /* -c option; centers dmenu on screen */
static int min_width = 500;                    /* minimum width when centered */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Consolas:pixelsize=15"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#bbbbbb", "#1d2021" },
	[SchemeSel] = { "#1d2021", "#ebdbb2" },
//	[SchemeSelHighlight] = { "#000080", "#ebdbb2" },
//	[SchemeNormHighlight] = { "#ffc978", "#1d2021" },
	[SchemeOut] = { "#000000", "#00ffff" },
//	Settings[SchemeOutHighlight] = { "#ffc978", "#00ffff" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
/* Size of the window border */
static const unsigned int border_width = 4;
