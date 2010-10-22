//
//  CouchMouseConfiguration.h
//  CouchMouse
//
//  Created by Friedrich Gräter on 21.10.10.
//  Published under the terms of the GNU General Public License v2.
//
#import <Cocoa/Cocoa.h>
#import "RemoteControl.h"

typedef enum {
	DisabledState,
	KeyboardState,
	MouseState
}CouchMouseInputMode;

#define InputModeChangedEvent		@"inputModeChanged"

@interface CouchMouseConfiguration : NSObject {
}

@property (readwrite,getter=inputMode,setter=setInputMode:,nonatomic) CouchMouseInputMode inputMode;

@property (readwrite,getter=mouseVelocity,setter=setMouseVelocity:) float mouseVelocity;

-(void) setInputMode:(CouchMouseInputMode)mode;

-(CGKeyCode) getKeyCodeForRemoteButton: (int) buttonKey;
-(void) setupRemoteButton: (NSNumber*) buttonKey withKeyCode: (unsigned short)keyCode;

-(void) awakeFromNib;

@end
