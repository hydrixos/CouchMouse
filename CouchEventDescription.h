//
//  CouchEventDescription.h
//  CouchMouse
//
//  Created by Friedrich Gräter on 21.10.10.
//  Published under the terms of the GNU General Public License v2.
//
#import <Cocoa/Cocoa.h>
#import "MultiClickRemoteBehavior.h"

@interface CouchEventDescription : NSObject {
	RemoteControlEventIdentifier	buttonPressed;
	BOOL							pressedDown;
	unsigned int					clickCount;
	
	float							cyclesSinceStarted;
}

@property (assign) RemoteControlEventIdentifier buttonPressed;
@property (assign) BOOL pressedDown;
@property (assign) unsigned int clickCount;
@property (assign) float cyclesSinceStarted;

@end
