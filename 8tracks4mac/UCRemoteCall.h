#import <Foundation/Foundation.h>
#import "UCMix.h"
#import "UCTrack.h"
#import "UCToken.h"

@interface UCRemoteCall : NSObject

-(NSString *)mixes;
-(UCMix *)detailsOfMix:(long)mix;
-(UCToken *)playToken;
-(NSString *)findMixesWithTag:(NSString *)tag1 andTag:(NSString *)tag2;
-(UCTrack *)trackFromMix:(UCMix *)mix andToken:(UCToken *)token;
@end
