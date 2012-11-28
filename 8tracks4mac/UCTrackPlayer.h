#import <Foundation/Foundation.h>
#import "UCRemoteCaller.h"
#import "UCToken.h"

@interface UCTrackPlayer : NSObject

@property(nonatomic, strong, readonly) UCTrack *currentTrack;

+ (UCTrackPlayer *)player;

- (void)startPlayingTrack:(UCTrack *)track;
- (void)resumeOrPause;

@end