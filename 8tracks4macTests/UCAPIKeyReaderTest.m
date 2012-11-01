//
//  UCAPIKeyReaderTest.m
//  8tracks4mac
//
//  Created by gmelo on 31/10/12.
//  Copyright (c) 2012 umbucaja. All rights reserved.
//

#import "UCAPIKeyReaderTest.h"

@implementation UCAPIKeyReaderTest

-(void)testReadsAPIKey
{
    NSString *expectedKey = @"sample key";
    NSString *key = [[[UCAPIKeyReader alloc] init] key];
    
    STAssertEqualObjects(expectedKey, key, @"The expected key doesn't match with returned key");
}

@end
