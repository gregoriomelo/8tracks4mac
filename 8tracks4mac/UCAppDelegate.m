#import "UCAppDelegate.h"
#import "UCRemoteCall.h"
#import "UCTrackPlayer.h"

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
    UCToken *token = [[[UCRemoteCall alloc] init] playToken];
    
    [_message setStringValue:[NSString stringWithFormat:@"%ld", [token id]]];
}

- (IBAction)findMixes:(id)sender {
    NSString *mixes = [[[UCRemoteCall alloc] init] findMixesWithTag:[_tag1 stringValue] andTag:[_tag2 stringValue]];

    [_message setStringValue:mixes];
}

- (IBAction)detailsOfMix:(id)sender {
    UCMix *mix = [[[UCRemoteCall alloc] init] detailsOfMix:[_mixId intValue]];

    [_message setStringValue:[mix description]];
}

- (IBAction)playMix:(id)sender {
    UCTrackPlayer *player = [UCTrackPlayer player];

    UCRemoteCall *remoteCaller = [[UCRemoteCall alloc] init];
    UCMix *mix = [remoteCaller detailsOfMix:[_mixId intValue]];

    [player playTrackFromMix:mix withToken:[remoteCaller playToken]];
}

- (IBAction)playOrPause:(id)sender {
    [[UCTrackPlayer player] playOrPause];
}

@end
