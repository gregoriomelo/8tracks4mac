#import "UCTrackPlayer.h"

@implementation UCTrackPlayer {
    BOOL _isPlaying;
}

static UCTrackPlayer *_player = nil;
NSSound *soundPlayer = nil;

+ (UCTrackPlayer *)player {
    @synchronized ([UCTrackPlayer class]) {
        if (!_player) {
            _player = [[self alloc] init];
        }

        return _player;
    }
}

+ (id)alloc {
    @synchronized ([UCTrackPlayer class]) {
        _player = [super alloc];
        return _player;
    }
}

- (id)init {
    self = [super init];
    if (self != nil) {
        soundPlayer = [[NSSound alloc] init];
    }

    return self;
}

- (void)playTrackData:(NSData *)trackData {
    [self initializeSoundPlayerWithTrackData:trackData];
    [self playTrack];
    [self defineTrackLength];
}

- (void)defineTrackLength {
    _currentTrackLength = [[NSNumber numberWithDouble:[soundPlayer duration]] integerValue];
}

- (void)initializeSoundPlayerWithTrackData:(NSData *)trackData {
    if (soundPlayer) {
        [soundPlayer stop];
    }

    soundPlayer = [[NSSound alloc] initWithData:trackData];
}

- (void)playTrack {
    [soundPlayer play];
    _isPlaying = true;
}

- (void)resumeOrPause {
    if (_isPlaying) {
        [soundPlayer pause];
        _isPlaying = false;
    } else {
        [soundPlayer resume];
        _isPlaying = true;
    }
}

@end