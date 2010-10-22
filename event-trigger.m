/*
 *  event-trigger.c
 *  CouchMouse
 *
 *  Created by Friedrich Gräter on 21.10.10.
 * Published under the terms of the GNU General Public License v2.
 *
 */
#include "event-trigger.h"

void postKeyEvent(CGKeyCode keyCode, BOOL isDown)
{
	CGEventRef theEvent = CGEventCreateKeyboardEvent(NULL, keyCode, isDown);
	CGEventPost(kCGHIDEventTap, theEvent);
	CFRelease(theEvent);
}

void postMouseEvent(CGEventType type, const CGPoint point, CGMouseButton button)
{
	CGEventRef theEvent = CGEventCreateMouseEvent(NULL, type, point, button);
	CGEventSetType(theEvent, type);
	CGEventPost(kCGHIDEventTap, theEvent);
	CFRelease(theEvent);
}

void postMouseMove(CGPoint point)
{
	postMouseEvent(kCGEventMouseMoved, point, -1);
}

void postMouseButtonEvent(CGEventType type, CGMouseButton button)
{
	CGEventRef ourEvent = CGEventCreate(NULL);
	CGPoint point = CGEventGetLocation(ourEvent);
	
	postMouseEvent(type, point, button);
}
