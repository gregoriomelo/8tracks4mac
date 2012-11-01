//
//  UCAppDelegate.m
//  8tracks4mac
//
//  Created by gmelo on 31/10/12.
//  Copyright (c) 2012 umbucaja. All rights reserved.
//

#import "UCAppDelegate.h"
#import "UCRemoteCall.h"

@implementation UCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)push:(id)sender
{
    NSString *mixes = [[[UCRemoteCall alloc] init] mixes];
    
    NSLog(@"pushed");
    [_message setStringValue:mixes];
}

@end
