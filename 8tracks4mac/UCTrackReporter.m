#import "UCTrackReporter.h"

@implementation UCTrackReporter {
    UCRemoteCaller *_remoteCaller;
    long _lastReportedTime;
}

- (id)initWithRemoteCaller:(UCRemoteCaller *)remoteCaller {
    self = [super init];

    _remoteCaller = remoteCaller;
    [self setLastReportedTime:0];

    return self;
}

- (void)setLastReportedTime:(long)lastReportedTime {
    _lastReportedTime = lastReportedTime;
}

- (void)reportIfNeeded:(UCTrackReport *)trackReport {
    if ([trackReport currentTime] >= _lastReportedTime + TIME_INTERVAL_FOR_EVERY_REPORT) {
        _lastReportedTime = [trackReport currentTime];
        [_remoteCaller report:trackReport];
    }
}

- (void)resetTimer {
    _lastReportedTime = 0;
}
@end