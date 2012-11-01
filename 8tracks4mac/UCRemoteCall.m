//
//  UCRemoteCall.m
//  8tracks4mac
//
//  Created by gmelo on 01/11/12.
//  Copyright (c) 2012 umbucaja. All rights reserved.
//

#import "UCRemoteCall.h"
#import "UCAPIKeyReader.h"

@implementation UCRemoteCall

-(NSString *)mixes
{
    NSString *mixesURL = @"http://8tracks.com/sets/new.xml";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:mixesURL]];
    [request setHTTPMethod:@"POST"];
    
    [request addValue:[UCAPIKeyReader key] forHTTPHeaderField: @"X-Api-Key"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response Code: %ld", [urlResponse statusCode]);
    
    return result;
}

@end
