#import "UCRemoteCall.h"
#import "UCAPIKeyReader.h"
#import "RXMLElement.h"

@implementation UCRemoteCall

-(NSString *)mixes
{
    NSString *mixesURL = @"http://8tracks.com/mixes.xml";

    RXMLElement *xmlRoot = [RXMLElement elementFromXMLData:[self requestFor:mixesURL]];
    RXMLElement *mixesTag = [xmlRoot child:@"mixes"];
    NSArray *xmlMixes = [mixesTag children:@"mix"];


    NSMutableArray *mixes = [NSMutableArray array];
    [xmlMixes enumerateObjectsUsingBlock:^(id xmlMix, NSUInteger index, BOOL *stop) {
        [mixes addObject:[self mixFromXML:xmlMix]];
    }];

    return [NSString stringWithFormat:@"%d", [[mixes objectAtIndex:0] id]];
}

- (UCMix *)detailsOfMix:(NSInteger) mix {
    NSString *mixURL = [NSString stringWithFormat:@"http://8tracks.com/mixes/%d.xml", mix];

    RXMLElement *xmlRoot = [RXMLElement elementFromXMLData:[self requestFor:mixURL]];

    return [self mixFromXML:[[xmlRoot children:@"mix"] objectAtIndex:0]];
}


-(UCToken *)playToken
{
    NSString *playTokenURL = @"http://8tracks.com/sets/new.xml";

    RXMLElement *xmlRoot = [RXMLElement elementFromXMLData:[self requestFor:playTokenURL]];

    id tokenXML = [[xmlRoot children:@"play-token"] objectAtIndex:0];

    UCToken *aToken = [[UCToken alloc] init];
    [aToken setId:[tokenXML textAsInt]];

    return aToken;
}

-(NSString *)findMixesWithTag:(NSString *)tag1 andTag:(NSString *)tag2
{
    NSString *mixesURL = @"http://8tracks.com/mixes.xml?tags=";

    NSString *requestURL = [NSString stringWithFormat:@"%@%@", mixesURL, [self encode:[NSString stringWithFormat:@"%@+%@", tag1, tag2]]];

    NSData *response = [self requestFor:requestURL];

    return [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
}

- (UCTrack *)trackFromMix:(UCMix *)mix andToken:(UCToken *)token {
    NSString *trackURL = [NSString stringWithFormat:@"http://8tracks.com/sets/%d/play.xml?mix_id=%d", [token id], [mix id]];

    RXMLElement *xmlRoot = [RXMLElement elementFromXMLData:[self requestFor:trackURL]];

    NSArray *children = [[xmlRoot child:@"set"] children:@"track"];
    return [self trackFromXML:[children objectAtIndex:0]];
}

- (UCTrack *)trackFromXML:(id)trackXML {
    UCTrack *aTrack = [[UCTrack alloc] init];
    [aTrack setAlbum:[[trackXML child:@"release-name"] text]];
    [aTrack setId:[[trackXML child:@"id"] textAsInt]];
    [aTrack setPerformer:[[trackXML child:@"performer"] text]];
    [aTrack setName:[[trackXML child:@"name"] text]];
    [aTrack setUrl:[[trackXML child:@"url"] text]];
    return aTrack;
}

- (UCMix *)mixFromXML:(id)mix
{
    UCMix *aMix = [[UCMix alloc] init];

    [aMix setId:[[mix child:@"id"] textAsInt]];
    [aMix setDescription:[[mix child:@"description"] text]];
    [aMix setName:[[mix child:@"name"] text]];
    [aMix setSlug:[[mix child:@"slug"] text]];
    [aMix setTimesPlayed:[[mix child:@"name"] textAsInt]];

    return aMix;
}

- (NSData *)requestFor:(NSString *)url
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
    long sourceLen = strlen((const char *)source);
    for (long i = 0; i < sourceLen; ++i) {
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
