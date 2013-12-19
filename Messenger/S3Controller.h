//
//  S3Controller.h
//  Messenger
//
//  Created by Simon Robbie on 12/18/13.
//  Copyright (c) 2013 Simon Robbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface S3Controller : NSObject

+ (S3Controller *) sharedInstance;

// @[ @{ @"date": date, @"text": @"" } ]
- (NSArray *) textsSinceDate:(NSDate *)date bucket:(NSString *)bucket;

- (void) uploadText:(NSString *)text bucket:(NSString *)bucket;

@end
