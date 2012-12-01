#import "UCTrackDownloader.h"

@implementation UCTrackDownloader {
    NSMutableData *downloadingSong;
    float trackDataSize;
    float trackDataReceived;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        downloadingSong = [NSMutableData new];
        trackDataReceived = 0;
    }

    return self;
}

- (void)downloadTrack:(UCTrack *)track {
    NSURL *url = [NSURL URLWithString:[track url]];

    (void) [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self];

    NSLog(@"Started downloading from URL: %@", [url absoluteString]);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    trackDataSize = [[NSString stringWithFormat:@"%lli", [response expectedContentLength]] floatValue];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    if (!downloadingSong) {
        downloadingSong = [NSMutableData new];
    }
    trackDataReceived += [data length];
    [downloadingSong appendData:data];

    NSNumber *rawProgress = [NSNumber numberWithFloat:(trackDataReceived / trackDataSize) * 100];

    [[NSNotificationCenter defaultCenter] postNotificationName:TRACK_IS_DOWNLOADING
                                                        object:self
                                                      userInfo:@{@"downloadProgress" : [UCDownloadProgress initWithValue:rawProgress]}];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [_delegate hasFinishedDownloadingTrack:downloadingSong];
}

- (void)connection:(NSURLConnection *) connection didFailWithError:(NSError *)error{
    NSLog(@"Error loading song: %@", error);
}

@end