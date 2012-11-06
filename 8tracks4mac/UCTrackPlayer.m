#import "UCTrackPlayer.h"


@implementation UCTrackPlayer

- (void)playTrackFromMix:(UCMix *)mix withToken:(UCToken *)token {
    UCTrack *track = [[[UCRemoteCall alloc] init] trackFromMix:mix andToken:token];

    NSURL *url = [NSURL URLWithString:[track url]];

    NSSound *player = [[NSSound alloc] initWithContentsOfURL:url byReference:NO];
    [player play];
}

@end