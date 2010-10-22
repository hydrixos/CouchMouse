//
//  CouchMouseMenuController.h
//  CouchMouse
//
//  Created by Friedrich Gräter on 21.10.10.
//  Published under the terms of the GNU General Public License v2.
//
#import <Cocoa/Cocoa.h>
#import "CouchMouseConfiguration.h"

@interface CouchMouseMenuController : NSObject {
	IBOutlet CouchMouseConfiguration *configuration;
	
	IBOutlet NSMenu *statusMenu;
	IBOutlet NSMenuItem *disabledModeItem;
	IBOutlet NSMenuItem *mouseModeItem;
	IBOutlet NSMenuItem *keyboardModeItem;

	NSStatusItem *statusItem;
}

-(void) initializeStatusMenu;
-(void) awakeFromNib;

-(IBAction) setDisabledMode:(id)menuItem;
-(IBAction) setMouseMode:(id)menuItem;
-(IBAction) setKeyboardMode:(id)menuItem;
-(IBAction) quitApplication:(id)menuItem;

@end
