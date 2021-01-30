/*
 *  getxkbmap - query currently active X keyboard layout
 *  © 2021 Lucca M. A. Pellegrini <luccapellegrini@e.email>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

#include <stdio.h>
#include <string.h>

#include <X11/XKBlib.h>
#include <X11/extensions/XKBrules.h>

unsigned char
xkb_get_group(Display *display, unsigned device_id)
{
	XkbStateRec state;
	XkbGetState(display, device_id, &state);
	return state.group;
}

char *
xkb_get_layouts(Display *display)
{
	XkbRF_VarDefsRec vd;
	if (!XkbRF_GetNamesProp(display, NULL, &vd))
		return NULL;
	return vd.layout;
}

int
main(void)
{
	Display *display;
	int group;
	char *layout;
	char *tok;
	int i;

	if ((display = XOpenDisplay(NULL)) == NULL) {
		fputs("XOpenDisplay(): Failed to open display\n", stderr);
		return -1;
	}

	group = (int) xkb_get_group(display, XkbUseCoreKbd);

	if ((layout = xkb_get_layouts(display)) == NULL) {
		fputs("XkbRF_GetNamesProp() failed\n", stderr);
		return -1;
	}

	tok = strtok(layout, ",");
	for (i = 0; i < group; ++i) {
		if ((tok = strtok(NULL, ",")) == NULL) {
			fputs("Failed to identify layout\n", stderr);
			return -1;
		}
	}

	printf("%s", tok);

	XCloseDisplay(display);
	return 0;
}
