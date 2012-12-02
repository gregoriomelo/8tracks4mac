#import <Foundation/Foundation.h>
#import "UCRemoteCaller.h"
#import "UCTrackReport.h"

static int const TIME_INTERVAL_FOR_EVERY_REPORT = 30;

@interface UCTrackReporter : NSObject

@property UCTrackReport *trackReport;

- (id)initWithRemoteCaller:(UCRemoteCaller *)remoteCaller;

- (void)reportIfNeeded:(UCTrackReport *)trackReport;

- (void)resetTimer;
@end