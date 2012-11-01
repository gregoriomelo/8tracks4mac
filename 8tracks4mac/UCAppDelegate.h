//
//  UCAppDelegate.h
//  8tracks4mac
//
//  Created by gmelo on 31/10/12.
//  Copyright (c) 2012 umbucaja. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface UCAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *message;

-(IBAction)push:(id)sender;

@end
