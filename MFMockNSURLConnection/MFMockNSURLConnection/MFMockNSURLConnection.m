//
//  MFMockNSURLConnection.m
//  MFMockNSURLConnection
//
//  Created by Mustafa Furniturewala on 5/12/14.
//  Copyright (c) 2014 Mustafa. All rights reserved.
//

#import "MFMockNSURLConnection.h"
#import "MFMocks.h"
#import "MFMockData.h"

@implementation MFMockNSURLConnection

+ (BOOL)canInitWithRequest:(NSURLRequest*)request {
    if ([[self sharedMocks] mockConfigForRequest:request]) {
        return YES;
    }
    return NO;
}

+ (NSURLRequest*)canonicalRequestForRequest:(NSURLRequest*)request {
    return request;
}

- (void)stopLoading {
    //  no-op, but needs to be implemented per NSURLProtocol
}

- (void)startLoading {
    id client = [self client];
    NSURLRequest* request = [self request];
    MFMockData* mockConfig = [[[self class] sharedMocks] mockConfigForRequest:[self request]];
    NSHTTPURLResponse* response = [[NSHTTPURLResponse alloc] initWithURL:[request URL] statusCode:200 HTTPVersion:nil headerFields:nil];
    NSData* recd = [mockConfig mockedData];
    [client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [client URLProtocol:self didLoadData:recd];
    [client URLProtocolDidFinishLoading:self];
}

+ (MFMocks*)sharedMocks {
    static MFMocks* _sharedConfiguration = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConfiguration = [[MFMocks alloc] init];
    });
    
    return _sharedConfiguration;
}

+ (void)addMock:(MFMockData*)mockConfig forRequest:(NSURLRequest*)request {
    [[self sharedMocks] addMockConfig:mockConfig forRequest:request];
}

@end
