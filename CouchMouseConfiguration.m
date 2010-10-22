//
//  CouchMouseConfiguration.m
//  CouchMouse
//
//  Created by Friedrich Gräter on 21.10.10.
//  Published under the terms of the GNU General Public License v2.
//
#import "CouchMouseConfiguration.h"
#include "event-trigger.h"

@implementation CouchMouseConfiguration

@synthesize inputMode, mouseVelocity;

-(void) dealloc
{
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) awakeFromNib
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *defaultKeys = [NSDictionary dictionaryWithObjectsAndKeys:
								 [NSNumber numberWithInteger: kVK_DownArrow], [NSString stringWithFormat: @"button-%i", kRemoteButtonMinus],
								 [NSNumber numberWithInteger: kVK_UpArrow], [NSString stringWithFormat: @"button-%i", kRemoteButtonPlus], 
								 [NSNumber numberWithInteger: kVK_LeftArrow], [NSString stringWithFormat: @"button-%i", kRemoteButtonLeft], 
								 [NSNumber numberWithInteger: kVK_RightArrow], [NSString stringWithFormat: @"button-%i", kRemoteButtonRight], 
								 [NSNumber numberWithInteger: kVK_Enter], [NSString stringWithFormat: @"button-%i", kRemoteButtonPlay], 
								 [NSNumber numberWithInteger: kVK_Escape], [NSString stringWithFormat: @"button-%i", kRemoteButtonMenu], 
								 
								 [NSNumber numberWithInteger: kVK_DownArrow], [NSString stringWithFormat: @"button-%i", kRemoteButtonMinus_Hold], 
								 [NSNumber numberWithInteger: kVK_UpArrow], [NSString stringWithFormat: @"button-%i", kRemoteButtonPlus_Hold], 
								 [NSNumber numberWithInteger: kVK_LeftArrow], [NSString stringWithFormat: @"button-%i", kRemoteButtonLeft_Hold], 
								 [NSNumber numberWithInteger: kVK_RightArrow], [NSString stringWithFormat: @"button-%i", kRemoteButtonRight_Hold], 
								 [NSNumber numberWithInteger: kVK_Enter], [NSString stringWithFormat: @"button-%i", kRemoteButtonPlay_Hold], 
								 [NSNumber numberWithInteger: kVK_Escape], [NSString stringWithFormat: @"button-%i", kRemoteButtonMenu_Hold], 
								 
								 nil
								 ];
	NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
								 defaultKeys, @"keyCodes",
								 [NSNumber numberWithInteger: DisabledState], @"inputMode",
								 [NSNumber numberWithFloat: 5.0f], @"mouseVelocity",
								 nil
								 ];
	
	[defaults registerDefaults:appDefaults];
}

- (CouchMouseInputMode) inputMode
{
	return [[NSUserDefaults standardUserDefaults] integerForKey: @"inputMode"];
}

- (void) setInputMode: (CouchMouseInputMode)mode
{
	[[NSUserDefaults standardUserDefaults] setInteger: mode forKey: @"inputMode"];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:InputModeChangedEvent object:self];
}


- (float) mouseVelocity
{
	return [[NSUserDefaults standardUserDefaults] floatForKey: @"mouseVelocity"];
}

-(void) setMouseVelocity:(float)velocity
{
	[[NSUserDefaults standardUserDefaults] setFloat: velocity forKey: @"mouseVelocity"];
}

- (CGKeyCode) getKeyCodeForRemoteButton: (int) buttonKey
{
	NSNumber *key = [[[NSUserDefaults standardUserDefaults] dictionaryForKey: @"keyCodes"] objectForKey: [NSString stringWithFormat: @"button-%i", (NSInteger)buttonKey]];

	if (key != nil)
		return [key intValue];
	else
		return 0;
}

- (void) setupRemoteButton: (NSNumber*) buttonKey withKeyCode: (unsigned short)keyCode
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary *keyCodes = [NSMutableDictionary dictionaryWithDictionary: [defaults dictionaryForKey: @"keyCodes"]];
	
	[keyCodes setObject: [NSNumber numberWithInteger: (NSInteger)keyCode] forKey: buttonKey];

	[defaults setObject: keyCodes forKey: @"keyCodes"];
}

@end
