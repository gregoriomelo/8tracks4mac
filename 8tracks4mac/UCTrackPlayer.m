#import "UCTrackPlayer.h"

static float const TIMER_TIME_INTERVAL = 0.5;

@implementation UCTrackPlayer {
    BOOL _isPlaying;
    BOOL mustKeepWatchingTimer;
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
    [soundPlayer setDelegate:self];
}

- (void)playTrack {
    [soundPlayer play];
    _isPlaying = true;

    mustKeepWatchingTimer = true;
    [self startWatchingCurrentTime];
}

- (void)resumeOrPause {
    if (_isPlaying) {
        [self pause];
    } else {
        [self resume];
    }
}

- (void)resume {
    [soundPlayer resume];
    _isPlaying = true;
    [self startWatchingCurrentTime];
}

- (void)pause {
    [soundPlayer pause];
    _isPlaying = false;
    mustKeepWatchingTimer = false;
}

- (void)sound:(NSSound *)sound didFinishPlaying:(BOOL)isTrackFinishedPlaying {
    if (isTrackFinishedPlaying) {
        [_delegate hasFinishedPlaying];
    }
}

- (void)startWatchingCurrentTime {
    mustKeepWatchingTimer = true;
    NSTimer *timer = [NSTimer timerWithTimeInterval:TIMER_TIME_INTERVAL target:self selector:@selector(updateCurrentTime:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
}

- (void)updateCurrentTime:(NSTimer *)timer {
    if (!mustKeepWatchingTimer) {
        [timer invalidate];
    } else if ([soundPlayer isPlaying]) {
        [_delegate hasChangedCurrentTime:[[NSNumber numberWithDouble:[soundPlayer currentTime]] integerValue]];
    }
}

@end