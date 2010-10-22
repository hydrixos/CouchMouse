//
//  CouchMouseController.m
//  CouchMouse
//
//  Created by Friedrich Gräter on 03.10.10.
//  Published under the terms of the GNU General Public License v2.
//
#import "event-trigger.h"
#import "CouchMouseController.h"

#define TIMER_RESOLUTION	0.001f

@implementation CouchMouseController

#pragma mark Initialization functions

-(void) initializeAppleRemote
{
	remoteControl = [[[AppleRemote alloc] initWithDelegate: self] retain];
	
	remoteBehavior = [MultiClickRemoteBehavior new];		
	[remoteBehavior setDelegate: self];
	[remoteControl setDelegate: remoteBehavior];
	[remoteBehavior setSimulateHoldEvent: YES];
}

-(void) awakeFromNib
{
	[self initializeAppleRemote];
	
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(inputModeChangeListener:)
	 name:InputModeChangedEvent
	 object:configuration];
}

#pragma mark Input mode handling

-(void) inputModeChangeListener:(NSNotification *)notification
{
	switch (configuration.inputMode) {
		case DisabledState:
			[remoteControl stopListening: self];
			break;
			
		case KeyboardState:
			[remoteControl startListening: self];
			break;
			
		case MouseState:
			[remoteControl startListening: self];
			break;			
	}
}

#pragma mark Update timer

-(void) timerHandler:(NSTimer *) timer
{
	CouchEventDescription *eventDescription = [timer userInfo];
	
	eventDescription.cyclesSinceStarted += 1;
	
	[self dispatchRemoteButtonEvent: eventDescription];
}

-(void) setupRepeatTimerWithEventDescription: (CouchEventDescription*)eventDescription
{
	if (eventDescription.pressedDown) {
		float interval;
		
		switch (configuration.inputMode) {
			case DisabledState:
				interval = 0.0f;
				break;
				
			case KeyboardState:
				interval = 1.0f;
				break;
				
			case MouseState:
				interval = TIMER_RESOLUTION * (10.0f - configuration.mouseVelocity);
				break;			
		}
		
		if (repeatTimer == nil) {
			repeatTimer = [NSTimer scheduledTimerWithTimeInterval: interval target: self selector: @selector(timerHandler:) userInfo: eventDescription repeats: YES ];
		}
	}
	else {
		if (repeatTimer != nil) {
			[repeatTimer invalidate];
			repeatTimer = nil;
		}
	}
}

#pragma mark Remote button delegate

- (void) remoteButton: (RemoteControlEventIdentifier)buttonIdentifier pressedDown: (BOOL) pressedDown clickCount: (unsigned int)clickCount
{
	CouchEventDescription *eventDescription = [[CouchEventDescription alloc] init];
	
	eventDescription.buttonPressed = buttonIdentifier;
	eventDescription.pressedDown = pressedDown;
	eventDescription.clickCount = clickCount;
	eventDescription.cyclesSinceStarted = 0;
	
	[self setupRepeatTimerWithEventDescription: eventDescription];
	[self dispatchRemoteButtonEvent: eventDescription];
}

- (void) dispatchRemoteButtonEvent: (CouchEventDescription*)eventDescription
{
	switch (configuration.inputMode) {
		case DisabledState:
			break;
			
		case KeyboardState:
			[self handleKeyboardRequest: eventDescription];
			break;
			
		case MouseState:			
			[self handleMouseRequest: eventDescription];
			break;			
	}
}

#pragma mark Handling keyboard requests

-(void) handleKeyboardRequest: (CouchEventDescription*)eventDescription
{
	NSNumber *pressedKey = [NSNumber numberWithInteger: eventDescription.buttonPressed];
	int keyCode = [configuration getKeyCodeForRemoteButton: [pressedKey intValue]];
	
	if (keyCode != 0)
		postKeyEvent(keyCode, eventDescription.pressedDown);
}

#pragma mark Handling Mouse requests

-(void) handleMouseRequest: (CouchEventDescription*)eventDescription
{
	switch (eventDescription.buttonPressed) {
		case kRemoteButtonRight:
		case kRemoteButtonRight_Hold:
			if (eventDescription.pressedDown)
				[self moveMouseToX: 1 toY: 0];
			break;
			
		case kRemoteButtonLeft:
		case kRemoteButtonLeft_Hold:
			if (eventDescription.pressedDown)
				[self moveMouseToX: -1 toY: 0];
			break;
		
		case kRemoteButtonPlus:
		case kRemoteButtonPlus_Hold:
			if (eventDescription.pressedDown)
				[self moveMouseToX: 0 toY: -1];
			break;
		
		case kRemoteButtonMinus:
		case kRemoteButtonMinus_Hold:			
			if (eventDescription.pressedDown)
				[self moveMouseToX: 0 toY: 1];
			break;
			
		case kRemoteButtonPlay:
		case kRemoteButtonPlay_Hold:
			if (eventDescription.pressedDown)
				[self downMouse: kCGMouseButtonLeft];
			else
				[self upMouse: kCGMouseButtonLeft];
			break;
			
		case kRemoteButtonMenu:
		case kRemoteButtonMenu_Hold:
			if (eventDescription.pressedDown)
				[self downMouse: kCGMouseButtonRight];
			else
				[self upMouse: kCGMouseButtonRight];
			break;
			
		default:
			break;
	}
}

-(void) moveMouseToX: (int)toX toY:(int)toY
{
	float newX, newY;
	CGEventRef ourEvent = CGEventCreate(NULL);
	CGPoint point = CGEventGetLocation(ourEvent);
	
	newX = point.x + toX * 1;
	newY = point.y + toY * 1;

	if (newX < 0) newX = 0;
	if (newY < 0) newY = 0;
	
	postMouseMove(CGPointMake(newX, newY));		
}

- (void) downMouse: (CGMouseButton)button
{
	if (button == kCGMouseButtonLeft)
		postMouseButtonEvent(kCGEventLeftMouseDown, kCGMouseButtonLeft);
	else
		postMouseButtonEvent(kCGEventRightMouseDown, kCGMouseButtonRight);
}

- (void) upMouse: (CGMouseButton) button
{
	if (button == kCGMouseButtonLeft)
		postMouseButtonEvent(kCGEventLeftMouseUp, kCGMouseButtonLeft);
	else
		postMouseButtonEvent(kCGEventRightMouseUp, kCGMouseButtonRight);
}

@end
