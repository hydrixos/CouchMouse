//
//  CouchMouseAppDelegate.h
//  CouchMouse
//
//  Created by Friedrich Gräter on 03.10.10.
//  Published under the terms of the GNU General Public License v2.
//

#import <Cocoa/Cocoa.h>

@interface CouchMouseAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
