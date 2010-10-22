//
//  CouchMouseMenuController.m
//  CouchMouse
//
//  Created by Friedrich Gräter on 21.10.10.
//  Published under the terms of the GNU General Public License v2.
//

#import "CouchMouseMenuController.h"

@implementation CouchMouseMenuController

#pragma mark Initialization
-(void) initializeStatusMenu
{
	statusItem = [[[NSStatusBar systemStatusBar] 
				   statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setHighlightMode:YES];
	[statusItem setAttributedTitle:[NSString 
						  stringWithString:@"⌻"]]; 
	[statusItem setEnabled:YES];
	
	[statusItem setMenu: statusMenu];
}

-(void) awakeFromNib
{
	[self initializeStatusMenu];
	
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(inputModeChangeListener:)
	 name:InputModeChangedEvent
	 object:configuration];
}

#pragma mark Input mode handling
-(void) updateInputModeSelection
{
	int mode = configuration.inputMode;
	
	[disabledModeItem setState:NSOffState];
	[keyboardModeItem setState:NSOffState];	
	[mouseModeItem setState:NSOffState];
	
	switch (mode) {
		case DisabledState:
			[disabledModeItem setState:NSOnState];
			break;
			
		case KeyboardState:
			[keyboardModeItem setState:NSOnState];
			break;
			
		case MouseState:
			[mouseModeItem setState:NSOnState];
			break;			
	}
}

-(void) inputModeChangeListener:(NSNotification *)notification
{
	[self updateInputModeSelection];
}

#pragma mark Menu Handling

-(IBAction) setDisabledMode:(id)menuItem
{
	[configuration setInputMode: DisabledState];
}

-(IBAction) setMouseMode:(id)menuItem
{
	[configuration setInputMode: MouseState];
}

-(IBAction) setKeyboardMode:(id)menuItem
{
	[configuration setInputMode: KeyboardState];
}

-(IBAction) aboutApplication:(id)menuItem
{
	[NSApp orderFrontStandardAboutPanel: self];	
}

-(IBAction) quitApplication:(id)menuItem
{
	[NSApp terminate:self];
}

@end
