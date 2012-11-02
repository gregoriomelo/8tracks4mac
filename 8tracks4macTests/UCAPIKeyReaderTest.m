#import "UCAPIKeyReaderTest.h"

@implementation UCAPIKeyReaderTest

-(void)testReadsAPIKey
{
    NSString *expectedKey = @"sample key";
    NSString *key = [[[UCAPIKeyReader alloc] init] key];
    
    STAssertEqualObjects(expectedKey, key, @"The expected key doesn't match with returned key");
}

@end
