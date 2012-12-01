#import <Foundation/Foundation.h>
#import "UCTrack.h"
#import "UCDownloadProgress.h"

static NSString *const TRACK_HAS_FINISHED_DOWNLOADING = @"TrackHasFinishedDownloading";
static NSString *const TRACK_IS_DOWNLOADING = @"TrackIsDownloading";

@protocol UCTrackDownloaderDelegate
- (void)hasFinishedDownloadingTrack:(NSData *)trackData;
- (void)isDownloadingTrack:(UCDownloadProgress *)downloadProgress;
@end

@interface UCTrackDownloader : NSObject <NSURLConnectionDelegate>

@property id <UCTrackDownloaderDelegate> delegate;

- (void)downloadTrack:(UCTrack *)track;

@end