#import "UCTrackPlayer.h"


@implementation UCTrackPlayer

static UCTrackPlayer *_player = nil;
NSSound *soundPlayer = nil;
BOOL isPlaying = false;

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

-(id)init {
    self = [super init];
    if (self != nil) {
        soundPlayer = [[NSSound alloc] init];
    }

    return self;
}

- (void)playTrackFromMix:(UCMix *)mix withToken:(UCToken *)token {
    UCTrack *track = [[[UCRemoteCall alloc] init] trackFromMix:mix andToken:token];

    NSURL *url = [NSURL URLWithString:[track url]];

    soundPlayer = [[NSSound alloc] initWithContentsOfURL:url byReference:NO];
    [soundPlayer play];
    isPlaying = true;
}

- (void)playOrPause {
    if (isPlaying) {
        [soundPlayer pause];
        isPlaying = false;
    } else {
        [soundPlayer resume];
        isPlaying = true;
    }
}
@end