//
//  MFMocks.h
//  MFMockNSURLConnection
//
//  Created by Mustafa Furniturewala on 5/12/14.
//  Copyright (c) 2014 Mustafa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MFMockData;

@interface MFMocks : NSObject

@property (nonatomic, strong) NSDictionary* requestMocks;

- (MFMockData*)mockConfigForRequest:(NSURLRequest*)requestToFind;
- (void)addMockConfig:(MFMockData*)mockConfig forRequest:(NSURLRequest*)request;

@end
