#import "UCRemoteCall.h"
#import "UCAPIKeyReader.h"
#import "TBXML.h"

@implementation UCRemoteCall

-(NSString *)mixes
{
    NSString *mixesURL = @"http://8tracks.com/mixes.xml";

    NSData *response = [self request:mixesURL];

    return [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
}

-(NSString *)playToken
{
    NSString *playTokenURL = @"http://8tracks.com/sets/new.xml";

    NSData *response = [self request:playTokenURL];
    TBXML *xml = [TBXML newTBXMLWithXMLData:response error:nil];
    TBXMLElement *playToken = [TBXML childElementNamed:@"play-token" parentElement:xml.rootXMLElement];

    return [TBXML textForElement:playToken];
}

-(NSString *)findMixesWithTag:(NSString *)tag1 andTag:(NSString *)tag2
{
    NSString *mixesURL = @"http://8tracks.com/mixes.xml?tags=";

    NSString *requestURL = [NSString stringWithFormat:@"%@%@", mixesURL, [self encode:[NSString stringWithFormat:@"%@+%@", tag1, tag2]]];

    NSData *response = [self request:requestURL];

    return [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
}

- (NSData *)request:(NSString *)url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    [request addValue:[UCAPIKeyReader key] forHTTPHeaderField: @"X-Api-Key"];
    [request addValue:@"2" forHTTPHeaderField: @"X-Api-Version"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];

    NSLog(@"Response Code for URL %@: %ld", url, [urlResponse statusCode]);

    return responseData;
}

- (NSString *)encode:(NSString *)url{
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[url UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end
