#import "UCTrackPlayer.h"


@implementation UCTrackPlayer

static UCTrackPlayer *_player = nil;
NSSound *soundPlayer = nil;
BOOL isPlaying = false;
NSMutableData *downloadingSong = nil;

+ (UCTrackPlayer *)player {
    @synchronized ([UCTrackPlayer class]) {
        if (!_player) {
            _player = [[self alloc] init];
        }

        return _player;
    }
}

+(id)alloc {
    @synchronized ([UCTrackPlayer class]) {
        _player = [super alloc];
        return _player;
    }
}

-(id)init {
    self = [super init];
    if (self != nil) {
        soundPlayer = [[NSSound alloc] init];
    }

    return self;
}

- (void)playTrackFromMix:(UCMix *)mix withToken:(UCToken *)token {
    UCTrack *track = [[[UCRemoteCall alloc] init] trackFromMix:mix andToken:token];

    NSURL *url = [NSURL URLWithString:[track url]];

    [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    NSLog(@"Started downloading from URL: %s", url);
}

- (void)playOrPause {
    if (isPlaying) {
        [soundPlayer pause];
        isPlaying = false;
    } else {
        [soundPlayer resume];
        isPlaying = true;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    if (!downloadingSong) {
        downloadingSong = [NSMutableData new];
    }
    NSLog(@"More data...");
    [downloadingSong appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Finished loading song...");

    soundPlayer = [[NSSound alloc] initWithData:downloadingSong];
    [soundPlayer play];
    isPlaying = true;
}

- (void)connection:(NSURLConnection *) connection didFailWithError:(NSError *)error{
    NSLog(@"Error loading song: %@", error);
}

@end