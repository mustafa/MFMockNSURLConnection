//
//  MFMockData.h
//  MFMockNSURLConnection
//
//  Created by Mustafa Furniturewala on 5/12/14.
//  Copyright (c) 2014 Mustafa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFMockData : NSObject

@property (nonatomic, strong) NSURLRequest* requestToBeMocked;
@property (nonatomic, strong) NSHTTPURLResponse* mockedResponse;
@property (nonatomic, strong) NSData* mockedData;

@end
