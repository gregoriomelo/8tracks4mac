#import "UCMixPresenter.h"


@implementation UCMixPresenter {
    UCRemoteCaller *_remoteCaller;
    UCTrackPlayer *_player;
    UCToken *_token;
    UCMix *_currentMix;
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
    if (!_token) {
        _token = [_remoteCaller playToken];
    }

    _currentMix = mix;

    UCTrack *track = [_remoteCaller trackFromMix:mix withToken:_token];
    [_player startPlayingTrack:track];
}

- (void)resumeOrPause {
    [_player resumeOrPause];
}

- (void)skipCurrentSong {
    UCTrack *nextTrack = [_remoteCaller skipWithinMix:_currentMix withToken:_token];
    [_player startPlayingTrack:nextTrack];
}
@end