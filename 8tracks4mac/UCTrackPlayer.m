#import "UCTrackPlayer.h"
#import "UCTrackDownloader.h"

@implementation UCTrackPlayer {
    BOOL isPlaying;
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
    UCTrack *track = [[[UCRemoteCall alloc] init] trackFromMix:mix andToken:token];

    UCTrackDownloader *trackDownloader = [[UCTrackDownloader alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackHasFinishedDownloading:) name:TRACK_HAS_FINISHED_DOWNLOADING object:trackDownloader];

    [trackDownloader downloadTrack:track];
}

- (void)trackHasFinishedDownloading:(NSNotification *)note {
    [self playDownloadedSong:[[note userInfo] objectForKey:@"trackData"]];
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

- (void)playDownloadedSong:(NSData *)trackData {
    soundPlayer = [[NSSound alloc] initWithData:trackData];
    [soundPlayer play];
    isPlaying = true;
}

@end