#import "UCTrackPlayer.h"
#import "UCTrackDownloader.h"

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

- (void)startPlayingMix:(UCMix *)mix withToken:(UCToken *)token {
    _currentTrack = [[[UCRemoteCall alloc] init] trackFromMix:mix andToken:token];

    UCTrackDownloader *trackDownloader = [[UCTrackDownloader alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackHasFinishedDownloading:) name:TRACK_HAS_FINISHED_DOWNLOADING object:trackDownloader];

    [trackDownloader downloadTrack:_currentTrack];
}

- (void)trackHasFinishedDownloading:(NSNotification *)note {
    [self initializeSoundPlayerWithTrackData:note];
    [self playDownloadedSong];
    [self defineTrackLengthFromDownloadedData];

}

- (void)defineTrackLengthFromDownloadedData {
    [_currentTrack setLengthInSeconds:[[NSNumber numberWithDouble:[soundPlayer duration]] integerValue]];
}

- (void)initializeSoundPlayerWithTrackData:(NSNotification *)note {
    NSData *trackData = [[note userInfo] objectForKey:@"trackData"];

    soundPlayer = [[NSSound alloc] initWithData:trackData];
}

- (void)playDownloadedSong {
    [soundPlayer play];
    _isPlaying = true;
}

- (void)playOrPause {
    if (_isPlaying) {
        [soundPlayer pause];
        _isPlaying = false;
    } else {
        [soundPlayer resume];
        _isPlaying = true;
    }
}

@end