#import <Foundation/Foundation.h>
#import "UCRemoteCaller.h"
#import "UCTrackReport.h"

@interface UCTrackReporter : NSObject

@property UCTrackReport *trackReport;

+ (id)initWithReport:(UCTrackReport *)trackReport andRemoteCaller:(UCRemoteCaller *)remoteCaller;
- (void)startReceivingNotifications;

@end