#import <Foundation/Foundation.h>
#import "UCTrack.h"

static NSString *const TRACK_HAS_FINISHED_DOWNLOADING = @"TrackHasFinishedDownloading";

@interface UCTrackDownloader : NSObject <NSURLConnectionDelegate>

- (void)downloadTrack:(UCTrack *)track;

@end