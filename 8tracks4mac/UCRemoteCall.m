//
//  UCRemoteCall.m
//  8tracks4mac
//
//  Created by gmelo on 01/11/12.
//  Copyright (c) 2012 umbucaja. All rights reserved.
//

#import "UCRemoteCall.h"
#import "UCAPIKeyReader.h"
#import "TBXML.h"

@implementation UCRemoteCall

-(NSString *)mixes
{
    NSString *mixesURL = @"http://8tracks.com/mixes.xml";

    NSData *response = [self request:mixesURL];

    return [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];;
}

-(NSString *)playToken
{
    NSString *playTokenURL = @"http://8tracks.com/sets/new.xml";

    NSData *response = [self request:playTokenURL];
    TBXML *xml = [TBXML newTBXMLWithXMLData:response error:nil];
    TBXMLElement *playToken = [TBXML childElementNamed:@"play-token" parentElement:xml.rootXMLElement];

    return [TBXML textForElement:playToken];
}

- (NSData *)request:(NSString *)url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    [request addValue:[UCAPIKeyReader key] forHTTPHeaderField: @"X-Api-Key"];
    [request addValue:@"2" forHTTPHeaderField: @"X-Api-Version"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];

    NSLog(@"Response Code for URL %@: %ld", url, [urlResponse statusCode]);

    return responseData;
}

@end
