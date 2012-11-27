#import <Foundation/Foundation.h>
#import "UCRemoteCall.h"
#import "UCToken.h"

@interface UCTrackPlayer : NSObject <NSURLConnectionDelegate>

+ (UCTrackPlayer *)player;
- (void)startPlayingMix:(UCMix *)mix withToken:(UCToken *)token;

- (void)playOrPause;
@end