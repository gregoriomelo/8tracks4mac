#import "UCTrackReport.h"
#import "UCToken.h"

@implementation UCTrackReport

+ (id)initWithPlayToken:(UCToken *)token andMix:(UCMix *)mix andTrack:(UCTrack *)track {
    UCTrackReport *trackReport = [UCTrackReport new];

    [trackReport setToken:token];
    [trackReport setMix:mix];
    [trackReport setTrack:track];

    return trackReport;
}

- (void)setToken:(UCToken *)token {
    _token = token;
}

- (void)setMix:(UCMix *)mix {
    _mix = mix;
}

- (void)setTrack:(UCTrack *)track {
    _track = track;
}

@end