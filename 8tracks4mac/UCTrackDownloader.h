#import <Foundation/Foundation.h>
#import "UCTrack.h"
#import "UCDownloadProgress.h"

static NSString *const TRACK_HAS_FINISHED_DOWNLOADING = @"TrackHasFinishedDownloading";
static NSString *const TRACK_IS_DOWNLOADING = @"TrackIsDownloading";

@interface UCTrackDownloader : NSObject <NSURLConnectionDelegate>

- (void)downloadTrack:(UCTrack *)track;

@end