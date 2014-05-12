//
//  MFMockNSURLConnection.h
//  MFMockNSURLConnection
//
//  Created by Mustafa Furniturewala on 5/12/14.
//  Copyright (c) 2014 Mustafa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MFMockData;

@interface MFMockNSURLConnection : NSURLProtocol

@property (nonatomic, strong) NSArray *mockConfigs;

+ (void)addMock:(MFMockData*)mockConfig forRequest:(NSURLRequest*)request;

@end
