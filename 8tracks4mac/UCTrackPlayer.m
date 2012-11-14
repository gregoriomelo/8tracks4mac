#import "UCTrackPlayer.h"


@implementation UCTrackPlayer

static UCTrackPlayer *_player = nil;

+ (UCTrackPlayer *)player {
    @synchronized ([UCTrackPlayer class]) {
        if (!_player) {
            _player = [[self alloc] init];
        }

        return _player;
    }
}

+(id)alloc {
    @synchronized ([UCTrackPlayer class]) {
        _player = [super alloc];
        return _player;
    }
}

- (void)playTrackFromMix:(UCMix *)mix withToken:(UCToken *)token {
    UCTrack *track = [[[UCRemoteCall alloc] init] trackFromMix:mix andToken:token];

    NSURL *url = [NSURL URLWithString:[track url]];

    NSSound *player = [[NSSound alloc] initWithContentsOfURL:url byReference:NO];
    [player play];
}

@end