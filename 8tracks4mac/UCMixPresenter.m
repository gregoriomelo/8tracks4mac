#import "UCMixPresenter.h"
#import "UCAppDelegate.h"

@implementation UCMixPresenter {
    UCRemoteCaller *_remoteCaller;
    UCTrackPlayer *_player;
    UCToken *_token;
    UCMix *_currentMix;
    UCTrackReporter *_trackReporter;
    UCTrack *_currentTrack;
    UCAppDelegate *_ui;
}

- (id)init {
    self = [super init];

    _player = [UCTrackPlayer player];
    [_player setDelegate:self];

    return self;
}

- (id)initWithRemoteCaller:(UCRemoteCaller *)remoteCaller andWindow:(UCAppDelegate *)ui {
    self = [self init];

    _remoteCaller = remoteCaller;
    _ui = ui;

    return self;
}

- (NSString *)findMixesWithTag:(NSString *)tag1 andTag:(NSString *)tag2 {
    return [_remoteCaller findMixesWithTag:tag1 andTag:tag2];
}

- (UCMix *)detailsOfMix:(NSInteger)mixId {
    return [_remoteCaller detailsOfMix:mixId];
}

- (void)startPlayingMix:(UCMix *)mix {
    _currentMix = mix;

    if (!_token) {
        _token = [_remoteCaller playToken];
    }

    _currentTrack = [_remoteCaller trackFromMix:_currentMix withToken:_token];

    [self startDownloadingTrack:_currentTrack];
}

- (void)startDownloadingTrack:(UCTrack *)track {
    _currentTrack = track;

    UCTrackDownloader *trackDownloader = [UCTrackDownloader new];
    [trackDownloader setDelegate:self];
    [trackDownloader downloadTrack:track];
}

- (void)initializeReporterOfTrack:(UCTrack *)track {
     _trackReporter = [UCTrackReporter initWithReport:[UCTrackReport initWithPlayToken:_token andMix:_currentMix andTrack:track] andRemoteCaller:[UCRemoteCaller new]];
    [_trackReporter startReceivingNotifications];
}

- (void)resumeOrPause {
    [_player resumeOrPause];
}

- (void)skipCurrentSong {
    UCTrack *nextTrack = [_remoteCaller skipWithinMix:_currentMix withToken:_token];

    [self startDownloadingTrack:nextTrack];

}

- (void)hasFinishedDownloadingTrack:(NSData *)trackData {
    NSLog(@"Finished downloading song.");
    [_player playTrackData:trackData];

    [_currentTrack setLengthInSeconds:[_player currentTrackLength]];

    [self initializeReporterOfTrack:_currentTrack];
}

- (void)isDownloadingTrack:(UCDownloadProgress *)downloadProgress {
    [_ui updateDownloadingStatus:downloadProgress];
}

- (void)hasChangedCurrentTime:(NSInteger)currentTime {
    [[_ui message] setStringValue:[NSString stringWithFormat:@"%ld", currentTime]];
}

- (void)isPlaying {

}

- (void)isPaused {

}

- (void)hasFinishedPlaying {
    NSLog(@"Has finished playing.");
    UCTrack *nextTrack = [_remoteCaller nextWithinMix:_currentMix withToken:_token];

    [self startDownloadingTrack:nextTrack];
}

@end