#import <Foundation/Foundation.h>


@interface UCMix : NSObject

@property NSString *name;
@property NSString *slug;
@property bool published;
@property NSInteger *id;
@property NSArray *tags;
@property NSInteger *timesPlayed;
@property NSString *description;

@end