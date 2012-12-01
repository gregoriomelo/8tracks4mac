#import <Foundation/Foundation.h>
#import "UCRemoteCaller.h"
#import "UCTrackPlayer.h"
#import "UCTrackDownloader.h"
#import "UCTrackReporter.h"
#import "UCTrackReport.h"

@class UCAppDelegate;

@interface UCMixPresenter : NSObject <UCTrackDownloaderDelegate, UCTrackPlayerDelegate>

@property(nonatomic, strong) UCTrackPlayer *player;

- (id)initWithRemoteCaller:(UCRemoteCaller *)remoteCaller andWindow:(UCAppDelegate *)ui;
- (NSString *)findMixesWithTag:(NSString *)tag1 andTag:(NSString *)tag2;
- (UCMix *)detailsOfMix:(NSInteger)mixId;
- (void)startPlayingMix:(UCMix *)mix;
- (void)resumeOrPause;
- (void)skipCurrentSong;

@end