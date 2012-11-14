#import <Foundation/Foundation.h>
#import "UCRemoteCall.h"
#import "UCToken.h"

@interface UCTrackPlayer : NSObject

+ (UCTrackPlayer *)player;
- (void)playTrackFromMix:(UCMix *)mix withToken:(UCToken *)token;

@end