//
//  MFMocks.m
//  MFMockNSURLConnection
//
//  Created by Mustafa Furniturewala on 5/12/14.
//  Copyright (c) 2014 Mustafa. All rights reserved.
//

#import "MFMocks.h"
#import "MFMockData.h"

@implementation MFMocks

- (id)init {
    self = [super init];
    if(!self) {
        return nil;
    }
    _requestMocks = [NSDictionary dictionary];
    return self;
}

- (MFMockData*)mockConfigForRequest:(NSURLRequest*)requestToFind {
    __block MFMockData* result;
    [[self requestMocks] enumerateKeysAndObjectsUsingBlock:^(NSURLRequest* request, MFMockData* mockConfig, BOOL* stop) {
        if([[self class] compareURLRequest:request with:requestToFind] && [[self class] compareURL:[request URL] withURL:[requestToFind URL]]) {
            result = mockConfig;
        }
    }];
    return result;
}

- (void)addMockConfig:(MFMockData*)mockConfig forRequest:(NSURLRequest *)request {
    NSMutableDictionary* mutableMocks = [[self requestMocks] mutableCopy];
    [mutableMocks setObject:mockConfig forKey:request];
    [self setRequestMocks:mutableMocks];
}

+ (BOOL)compareURL:(NSURL*)url1 withURL:(NSURL*)url2 {
    if([url1 isEqual:url2]) {
        return YES;
    }
    if([[url1 scheme] caseInsensitiveCompare:[url2 scheme]] != NSOrderedSame) {
        return NO;
    }
    if([[url1 host] caseInsensitiveCompare:[url2 host]] != NSOrderedSame) {
        return NO;
    }
    if ([[url1 path] compare:[url2 path]] != NSOrderedSame) {
        return NO;
    }
    if ([[url1 port] compare:[url2 port]] != NSOrderedSame) {
        return NO;
    }
    if ([[url1 query] compare:[url2 query]] != NSOrderedSame) {
        return NO;
    }
    return YES;
}

+ (BOOL)compareURLRequest:(NSURLRequest*)request1 with:(NSURLRequest*)request2 {
    if([[request1 HTTPMethod] caseInsensitiveCompare:[request2 HTTPMethod]] != NSOrderedSame) {
        return NO;
    }
    if([[request1 HTTPBody] isEqualToData:[request2 HTTPBody]] == NO && !([request1 HTTPBody]==nil && [request2 HTTPBody] == nil)) {
        return NO;
    }
    return YES;
}

@end
