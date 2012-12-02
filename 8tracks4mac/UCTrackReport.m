#import "UCTrackReport.h"

@implementation UCTrackReport

- (id)initWithPlayToken:(UCToken *)token andMix:(UCMix *)mix andTrack:(UCTrack *)track andCurrentTime:(NSInteger)currentTime {
    self = [super init];

    _token = token;
    _mix = mix;
    _track = track;
    _currentTime = currentTime;

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"mix.id=%ld, track.id=%ld, track.currentTime=%ld", _mix.id, _track.id, _currentTime];
}

@end