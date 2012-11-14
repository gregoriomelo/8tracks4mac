#import <Foundation/Foundation.h>


@interface UCMix : NSObject

@property NSString *name;
@property NSString *slug;
@property bool published;
@property long id;
@property NSArray *tags;
@property long timesPlayed;
@property NSString *description;

@end