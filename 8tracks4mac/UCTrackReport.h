#import <Foundation/Foundation.h>
#import "UCToken.h"
#import "UCMix.h"
#import "UCTrack.h"

@interface UCTrackReport : NSObject

@property (weak, readonly) UCToken *token;
@property (weak, readonly) UCMix *mix;
@property (weak, readonly) UCTrack *track;

+ (id)initWithPlayToken:(UCToken *)token andMix:(UCMix *)mix andTrack:(UCTrack *)track;

@end