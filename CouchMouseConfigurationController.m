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
	buttonKeys = [[NSMapTable mapTableWithStrongToStrongObjects] retain]; 
				
	[buttonKeys setObject: [NSNumber numberWithInteger: kRemoteButtonPlus] forKey: upButton];
	[buttonKeys setObject: [NSNumber numberWithInteger: kRemoteButtonMinus] forKey: downButton];
	[buttonKeys setObject: [NSNumber numberWithInteger: kRemoteButtonLeft] forKey: leftButton];
	[buttonKeys setObject: [NSNumber numberWithInteger: kRemoteButtonRight] forKey: rightButton];
	[buttonKeys setObject: [NSNumber numberWithInteger: kRemoteButtonPlay] forKey: playButton];
	[buttonKeys setObject: [NSNumber numberWithInteger: kRemoteButtonMenu] forKey: menuButton];

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
	setupKeyCode = nil;
	[keyboardMessage setTitleWithMnemonic: @""];
}

- (void) keyUp:(NSEvent *)theEvent
{
	if (setupKeyCode != nil) {
		[configuration setupRemoteButton: setupKeyCode withKeyCode: theEvent.keyCode];
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
	NSNumber *keyCode = [buttonKeys objectForKey: sender];
	
	[keyboardMessage setTitleWithMnemonic: @"Please enter now a key for this button."];
	[configurationDialog makeFirstResponder: self];
	setupKeyCode = keyCode;
}

- (IBAction) changedMouseSpeed: (id)sender
{
	configuration.mouseVelocity = mouseSpeedSlider.floatValue;
}

@end
