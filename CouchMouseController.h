//
//  CouchMouseController.h
//  CouchMouse
//
//  Created by Friedrich Gräter on 03.10.10.
//  Published under the terms of the GNU General Public License v2.
//

#import <Cocoa/Cocoa.h>

#import "CouchMouseConfiguration.h"

#import "AppleRemote.h"
#import "MultiClickRemoteBehavior.h"
#import "CouchEventDescription.h"

@interface CouchMouseController : NSObject {
	IBOutlet CouchMouseConfiguration *configuration;
	
	NSTimer *repeatTimer;
	
	AppleRemote *remoteControl;
	MultiClickRemoteBehavior* remoteBehavior;
}

-(void) initializeAppleRemote;

-(void) dispatchRemoteButtonEvent: (CouchEventDescription*)eventDescription;
-(void) handleKeyboardRequest: (CouchEventDescription*)eventDescription;
-(void) handleMouseRequest: (CouchEventDescription*)eventDescription;

-(void) moveMouseToX: (int)toX toY:(int)toY;
-(void) downMouse: (CGMouseButton)button;
-(void) upMouse: (CGMouseButton)button;

@end
