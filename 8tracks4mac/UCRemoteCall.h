#import <Foundation/Foundation.h>

@interface UCRemoteCall : NSObject

-(NSString *)mixes;
-(NSString *)playToken;
-(NSString *)findMixesWithTag:(NSString *)tag1 andTag:(NSString *)tag2;

@end
