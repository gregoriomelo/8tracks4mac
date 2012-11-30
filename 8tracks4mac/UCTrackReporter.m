#import "UCTrackReporter.h"
#import "UCRemoteCaller.h"


@implementation UCTrackReporter {
    UCRemoteCaller *_remoteCaller;
    long _lastReportedTime;
}

+ (id)initWithReport:(UCTrackReport *)trackReport andRemoteCaller:(UCRemoteCaller *)remoteCaller {
    UCTrackReporter *trackReporter = [[UCTrackReporter alloc] init];

    [trackReporter setRemoteCaller:remoteCaller];
    [trackReporter setLastReportedTime:0];

    return trackReporter;
}


- (void)setRemoteCaller:(UCRemoteCaller *)remoteCaller {
    _remoteCaller = remoteCaller;
}

- (void)setLastReportedTime:(long)lastReportedTime {
    _lastReportedTime = lastReportedTime;
}

- (void)startReceivingNotifications {

}

@end