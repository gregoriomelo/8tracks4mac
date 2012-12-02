#import "UCMixPresenter.h"
#import "UCAppDelegate.h"

@implementation UCMixPresenter {
    UCRemoteCaller *_remoteCaller;
    UCTrackPlayer *_player;
    UCToken *_token;
    UCMix *_currentMix;
    UCTrackReporter *_trackReporter;
    UCTrackReport *_currentTrackReport;
    UCTrack *_currentTrack;
    UCAppDelegate *_ui;
}

- (id)initWithWindow:(UCAppDelegate *)ui {
    self = [super init];

    _player = [UCTrackPlayer player];
    [_player setDelegate:self];
    _remoteCaller = [UCRemoteCaller new];
    _trackReporter = [[UCTrackReporter alloc] initWithRemoteCaller:_remoteCaller];
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

    [self resetReporting];
}

- (void)isDownloadingTrack:(UCDownloadProgress *)downloadProgress {
    [_ui updateDownloadingStatus:downloadProgress];
}

- (void)hasChangedCurrentTime:(NSInteger)currentTime {
    [[_ui message] setStringValue:[NSString stringWithFormat:@"%ld", currentTime]];

    [self reportTrackIfNeeded:currentTime];
}

- (void)reportTrackIfNeeded:(NSInteger)currentTime {
    if (!_currentTrackReport) {
        _currentTrackReport = [[UCTrackReport alloc] initWithPlayToken:_token andMix:_currentMix andTrack:_currentTrack andCurrentTime:currentTime];
    } else {
       [_currentTrackReport setCurrentTime:currentTime];
    }

    [_trackReporter reportIfNeeded:_currentTrackReport];
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

- (void)resetReporting {
    [_trackReporter resetTimer];
    _currentTrackReport = [[UCTrackReport alloc] initWithPlayToken:_token andMix:_currentMix andTrack:_currentTrack andCurrentTime:0];
}

@end