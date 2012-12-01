#import <Foundation/Foundation.h>
#import "UCTrack.h"
#import "UCDownloadProgress.h"

@protocol UCTrackDownloaderDelegate
- (void)hasFinishedDownloadingTrack:(NSData *)trackData;
- (void)isDownloadingTrack:(UCDownloadProgress *)downloadProgress;
@end

@interface UCTrackDownloader : NSObject <NSURLConnectionDelegate>

@property id <UCTrackDownloaderDelegate> delegate;

- (void)downloadTrack:(UCTrack *)track;

@end