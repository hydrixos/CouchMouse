/*
 *  event-trigger.h
 *  CouchMouse
 *
 *  Created by Friedrich Gräter on 21.10.10.
 *  Published under the terms of the GNU General Public License v2.
 *
 */
#import <Cocoa/Cocoa.h>

enum {
	kVK_Enter                     = 0x24,
	kVK_Escape                    = 0x35,
	kVK_LeftArrow                 = 0x7B,
	kVK_RightArrow                = 0x7C,
	kVK_DownArrow                 = 0x7D,
	kVK_UpArrow                   = 0x7E
};

void postKeyEvent(CGKeyCode keyCode, BOOL isDown);

void postMouseEvent(CGEventType type, const CGPoint point, CGMouseButton button);
void postMouseMove(CGPoint point);
void postMouseButtonEvent(CGEventType type, CGMouseButton button);