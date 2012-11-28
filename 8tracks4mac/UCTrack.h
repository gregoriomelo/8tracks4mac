#import <Foundation/Foundation.h>


@interface UCTrack : NSObject

@property (weak) NSString *name;
@property (weak) NSString *url;
@property (weak) NSString *performer;
@property (weak) NSString *album;
@property NSInteger lengthInSeconds;
@property long id;

@end