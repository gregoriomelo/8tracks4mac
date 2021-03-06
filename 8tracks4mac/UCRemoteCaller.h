#import <Foundation/Foundation.h>
#import "UCMix.h"
#import "UCTrack.h"
#import "UCToken.h"
#import "UCTrackReport.h"

@interface UCRemoteCaller : NSObject

-(NSString *)mixes;
- (UCMix *)detailsOfMix:(long)mix;
- (UCToken *)playToken;
- (NSString *)findMixesWithTag:(NSString *)tag1 andTag:(NSString *)tag2;
- (UCTrack *)trackFromMix:(UCMix *)mix withToken:(UCToken *)token;
- (UCTrack *)nextWithinMix:(UCMix *)mix withToken:(UCToken *)token;
- (UCTrack *)skipWithinMix:(UCMix *)mix withToken:(UCToken *)token;
- (void)report:(UCTrackReport *)report;


@end
