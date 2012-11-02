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
    
    [_message setStringValue:mixes];
}

- (IBAction)playToken:(id)sender
{
    NSString *playToken = [[[UCRemoteCall alloc] init] playToken];
    
    [_message setStringValue:playToken];
}

- (IBAction)findMixes:(id)sender {
    NSString *mixes = [[[UCRemoteCall alloc] init] findMixesWithTag:[_tag1 stringValue] andTag:[_tag2 stringValue]];

    [_message setStringValue:mixes];
}

@end
