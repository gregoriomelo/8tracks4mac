#import <Foundation/Foundation.h>

@protocol UCTrackPlayerDelegate
- (void)hasChangedCurrentTime:(NSInteger)currentTime;
- (void)isPlaying;
- (void)isPaused;
- (void)hasFinishedPlaying;
@end

@interface UCTrackPlayer : NSObject <NSSoundDelegate>

@property id <UCTrackPlayerDelegate> delegate;
@property (nonatomic, readonly) NSInteger currentTrackLength;

+ (UCTrackPlayer *)player;

- (void)playTrackData:(NSData *)trackData;
- (void)resumeOrPause;
- (void)sound:(NSSound *)sound didFinishPlaying:(BOOL)isTrackFinishedPlaying;
- (void)stop;

@end