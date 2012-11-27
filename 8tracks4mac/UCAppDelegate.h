#import <Cocoa/Cocoa.h>

@interface UCAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *message;
@property (weak) IBOutlet NSTextField *tag1;
@property (weak) IBOutlet NSTextField *tag2;
@property (weak) IBOutlet NSTextField *mixId;

- (IBAction)findMixes:(id)sender;
- (IBAction)detailsOfMix:(id)sender;
- (IBAction)playMix:(id)sender;
- (IBAction)playOrPause:(id)sender;

@end
