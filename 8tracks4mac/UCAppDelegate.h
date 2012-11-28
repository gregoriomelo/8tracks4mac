#import <Cocoa/Cocoa.h>
#import "UCRemoteCaller.h"
#import "UCTrackPlayer.h"
#import "UCTrackDownloader.h"
#import "UCMixPresenter.h"

@interface UCAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *message;
@property (weak) IBOutlet NSTextField *tag1;
@property (weak) IBOutlet NSTextField *tag2;
@property (weak) IBOutlet NSTextField *mixId;
@property (weak) IBOutlet NSTextField *downloadingStatus;

- (IBAction)findMixes:(id)sender;
- (IBAction)detailsOfMix:(id)sender;
- (IBAction)playMix:(id)sender;
- (IBAction)resumeOrPause:(id)sender;
- (IBAction)skipCurrentSong:(id)sender;

@end
