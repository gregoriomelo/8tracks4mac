#import "UCMixPresenter.h"


@implementation UCMixPresenter {
    UCRemoteCaller *_remoteCaller;
    UCTrackPlayer *_player;
    UCToken *_token;
    UCMix *_currentMix;
    UCTrackReporter *_trackReporter;
    UCTrack *_currentTrack;
}

- (id)init {
    self = [super init];

    _player = [UCTrackPlayer player];

    return self;
}

+ (id)initWithRemoteCaller:(UCRemoteCaller *)remoteCaller {
    UCMixPresenter *mixPresenter = [[UCMixPresenter alloc] init];

    [mixPresenter setRemoteCaller:remoteCaller];

    return mixPresenter;
}

- (void)setRemoteCaller:(UCRemoteCaller *)remoteCaller {
    _remoteCaller = remoteCaller;
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
    UCTrackDownloader *trackDownloader = [[UCTrackDownloader alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackHasFinishedDownloading:) name:TRACK_HAS_FINISHED_DOWNLOADING object:trackDownloader];

    [trackDownloader downloadTrack:track];
}

- (void)trackHasFinishedDownloading:(NSNotification *)note {
    [_player playTrackData:[[note userInfo] objectForKey:@"trackData"]];

    [_currentTrack setLengthInSeconds:[_player currentTrackLength]];

    [self initializeReporterOfTrack:_currentTrack];
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

    _currentTrack = nextTrack;
}
@end