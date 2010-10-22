//
//  CouchMouseConfigurationController.h
//  CouchMouse
//
//  Created by Friedrich Gräter on 21.10.10.
//  Published under the terms of the GNU General Public License v2.
//

#import <Cocoa/Cocoa.h>
#import "CouchMouseConfiguration.h"

@interface CouchMouseConfigurationController : NSResponder {
	@private 
		NSMapTable *buttonCodes;
		NSNumber *setupButtonCode;
	
	@public
		IBOutlet CouchMouseConfiguration *configuration;
	
		IBOutlet NSWindow *configurationDialog;
		IBOutlet NSButton *upButton;
		IBOutlet NSButton *downButton;
		IBOutlet NSButton *rightButton;
		IBOutlet NSButton *leftButton;
		IBOutlet NSButton *playButton;
		IBOutlet NSButton *menuButton;	

		IBOutlet NSSlider *mouseSpeedSlider;
	
		IBOutlet NSTextField *keyboardMessage;
	
}

- (IBAction) showConfigurationDialog: (id)sender;

- (IBAction) changeKey: (NSButton*)sender;

- (IBAction) changedMouseSpeed: (id)sender;

@end
