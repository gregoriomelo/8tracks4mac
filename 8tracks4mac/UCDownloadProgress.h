#import <Foundation/Foundation.h>

@interface UCDownloadProgress : NSObject

- (NSNumber *)value;
- (BOOL)isComplete;
+ (id)initWithValue:(NSNumber *)value;

@end