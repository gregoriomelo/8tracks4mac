#import <Foundation/Foundation.h>
#import "UCRemoteCaller.h"
#import "UCTrackPlayer.h"
#import "UCTrackReporter.h"
#import "UCTrackReport.h"

@interface UCMixPresenter : NSObject

@property(nonatomic, strong) UCTrackPlayer *player;

+ (id)initWithRemoteCaller:(UCRemoteCaller *)remoteCaller;
- (NSString *)findMixesWithTag:(NSString *)tag1 andTag:(NSString *)tag2;
- (UCMix *)detailsOfMix:(NSInteger)mixId;
- (void)startPlayingMix:(UCMix *)mix;
- (void)resumeOrPause;
- (void)skipCurrentSong;

@end