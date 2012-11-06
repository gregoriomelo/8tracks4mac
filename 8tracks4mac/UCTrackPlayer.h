#import <Foundation/Foundation.h>
#import "UCRemoteCall.h"
#import "UCToken.h"

@interface UCTrackPlayer : NSObject

- (void)playTrackFromMix:(UCMix *)mix withToken:(UCToken *)token;

@end