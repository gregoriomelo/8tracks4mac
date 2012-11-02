#import "UCAPIKeyReader.h"

@implementation UCAPIKeyReader

+(NSString *)key {
    NSString *apiKeyPath = [[NSBundle mainBundle] pathForResource:@"API_Key" ofType:@"plist"];
    NSDictionary *apiKeyConfiguration = [[NSDictionary alloc] initWithContentsOfFile:apiKeyPath];
    NSString *apiKey = [apiKeyConfiguration objectForKey:@"api_key"];
    
    return apiKey;
}

@end
