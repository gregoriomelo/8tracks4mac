//
//  UCAPIKeyReader.m
//  8tracks4mac
//
//  Created by gmelo on 31/10/12.
//  Copyright (c) 2012 umbucaja. All rights reserved.
//

#import "UCAPIKeyReader.h"

@implementation UCAPIKeyReader

-(NSString *)key {
    NSString *apiKeyPath = [[NSBundle mainBundle] pathForResource:@"API_Key" ofType:@"plist"];
    NSDictionary *apiKeyConfiguration = [[NSDictionary alloc] initWithContentsOfFile:apiKeyPath];
    NSString *apiKey = [apiKeyConfiguration objectForKey:@"api_key"];
    
    return apiKey;
}

@end
