//
//  CouchMouseConfigurationController.m
//  CouchMouse
//
//  Created by Friedrich Gräter on 21.10.10.
//  Published under the terms of the GNU General Public License v2.
//

#import "CouchMouseConfigurationController.h"


@implementation CouchMouseConfigurationController

- (void) awakeFromNib
{
	buttonCodes = [[NSMapTable mapTableWithStrongToStrongObjects] retain]; 
				
	[buttonCodes setObject: [NSNumber numberWithInteger: kRemoteButtonPlus] forKey: upButton];
	[buttonCodes setObject: [NSNumber numberWithInteger: kRemoteButtonMinus] forKey: downButton];
	[buttonCodes setObject: [NSNumber numberWithInteger: kRemoteButtonLeft] forKey: leftButton];
	[buttonCodes setObject: [NSNumber numberWithInteger: kRemoteButtonRight] forKey: rightButton];
	[buttonCodes setObject: [NSNumber numberWithInteger: kRemoteButtonPlay] forKey: playButton];
	[buttonCodes setObject: [NSNumber numberWithInteger: kRemoteButtonMenu] forKey: menuButton];

}

- (IBAction) showConfigurationDialog: (id)sender
{
	[configurationDialog center];
	[configurationDialog makeKeyAndOrderFront: self];
	[NSApp activateIgnoringOtherApps:YES];

	mouseSpeedSlider.floatValue = configuration.mouseVelocity;
}

- (void) deactivateKeyCatching
{
	setupButtonCode = nil;
	[keyboardMessage setTitleWithMnemonic: @""];
}

- (void) keyUp:(NSEvent *)theEvent
{
	if (setupButtonCode != nil) {
		[configuration setupRemoteButton: setupButtonCode withKeyCode: (CGKeyCode)theEvent.keyCode];
		[self deactivateKeyCatching];
	}
}

- (BOOL)resignFirstResponder
{
	[self deactivateKeyCatching];
	return YES;
}

- (IBAction) changeKey: (NSButton*)sender
{
	NSNumber *buttonCode = [buttonCodes objectForKey: sender];
	NSLog(@"Button Code: %@ from %@\n", buttonCode, sender);
	[keyboardMessage setTitleWithMnemonic: @"Please enter now a key for this button."];
	[configurationDialog makeFirstResponder: self];
	setupButtonCode = buttonCode;
}

- (IBAction) changedMouseSpeed: (id)sender
{
	configuration.mouseVelocity = mouseSpeedSlider.floatValue;
}

@end
