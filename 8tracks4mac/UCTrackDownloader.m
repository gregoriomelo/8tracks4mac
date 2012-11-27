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

    [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self];

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

    NSLog(@"Downloaded: %ld%%", [[NSNumber numberWithFloat:(trackDataReceived / trackDataSize) * 100] integerValue]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Finished loading song...");

    [self notifyTrackHasFinishedDownloading];
}

- (void)connection:(NSURLConnection *) connection didFailWithError:(NSError *)error{
    NSLog(@"Error loading song: %@", error);
}

- (void)notifyTrackHasFinishedDownloading {
    NSDictionary *downloadedTrackData = @{@"trackData" : downloadingSong};

    [[NSNotificationCenter defaultCenter] postNotificationName:TRACK_HAS_FINISHED_DOWNLOADING
                                          object:self
                                          userInfo:downloadedTrackData];
}

@end