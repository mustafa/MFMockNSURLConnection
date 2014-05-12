//
//  MFMockNSURLConnectionTests.m
//  MFMockNSURLConnectionTests
//
//  Created by Mustafa Furniturewala on 5/12/14.
//  Copyright (c) 2014 Mustafa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MFMockNSURLConnection.h"
#import "MFMockData.h"

@interface MFMockNSURLConnectionTests : XCTestCase

@end

@implementation MFMockNSURLConnectionTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [NSURLProtocol registerClass:[MFMockNSURLConnection class]];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMock
{
    MFMockData* mockConfig = [[MFMockData alloc] init];
    NSString* strData =  @"test123";
    NSURL* url = [[NSURL alloc] initWithScheme:@"https" host:@"api.test.com" path:@"/oauth/access_token"];
    NSURLRequest* req = [NSURLRequest requestWithURL:url];
    NSURL* url2 = [[NSURL alloc] initWithScheme:@"https" host:@"api.test.com" path:@"/oauth/access_token"];
    NSURLRequest* req2 = [NSURLRequest requestWithURL:url2];
    
    [mockConfig setMockedData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
    [MFMockNSURLConnection addMock:mockConfig forRequest:req];
    
    __block BOOL shouldKeepRunning = YES;
    [NSURLConnection sendAsynchronousRequest:req2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        XCTAssertEqualObjects(strData, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], @"");
        shouldKeepRunning = NO;
    }];
    NSRunLoop* theRL = [NSRunLoop currentRunLoop];
    while (shouldKeepRunning && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
}

@end
