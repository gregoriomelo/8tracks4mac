#import <Foundation/Foundation.h>

@interface UCTrackPlayer : NSObject

@property(nonatomic, readonly) NSInteger currentTrackLength;

+ (UCTrackPlayer *)player;

- (void)playTrackData:(NSData *)trackData;
- (void)resumeOrPause;

@end