#import <Foundation/Foundation.h>
#import "UCRemoteCall.h"
#import "UCToken.h"

@interface UCTrackPlayer : NSObject

@property(nonatomic, strong, readonly) UCTrack *currentTrack;

+ (UCTrackPlayer *)player;
- (void)startPlayingMix:(UCMix *)mix withToken:(UCToken *)token;
- (void)playOrPause;

@end