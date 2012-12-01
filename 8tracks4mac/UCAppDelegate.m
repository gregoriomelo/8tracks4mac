#import "UCAppDelegate.h"

@implementation UCAppDelegate {
    UCMixPresenter *mixPresenter;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    mixPresenter = [[UCMixPresenter alloc] initWithRemoteCaller:[UCRemoteCaller new] andWindow:self];
}

- (IBAction)findMixes:(id)sender {
    NSString *mixes = [mixPresenter findMixesWithTag:[_tag1 stringValue] andTag:[_tag2 stringValue]];

    [_message setStringValue:mixes];
}

- (IBAction)detailsOfMix:(id)sender {
    UCMix *mix = [[UCRemoteCaller new] detailsOfMix:[_mixId intValue]];

    [_message setStringValue:[mix description]];
}

- (IBAction)playMix:(id)sender {
    UCMix *mix = [mixPresenter detailsOfMix:[_mixId integerValue]];

    [mixPresenter startPlayingMix:mix];
}

- (IBAction)resumeOrPause:(id)sender {
    [mixPresenter resumeOrPause];
}

- (IBAction)skipCurrentSong:(id)sender {
    [mixPresenter skipCurrentSong];
}

- (void)updateDownloadingStatus:(UCDownloadProgress *)progress {
    if ([progress isComplete]) {
        [_downloadingStatus setStringValue:@"Buffering complete"];
    } else {
        [_downloadingStatus setStringValue:[NSString stringWithFormat:@"Buffering: %ld%%", [[progress value] integerValue]]];
    }
}

@end
