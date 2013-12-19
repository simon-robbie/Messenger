//
//  DateUtil.h
//  Messenger
//
//  Created by Simon Robbie on 12/18/13.
//  Copyright (c) 2013 Simon Robbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+ (NSString *) stringForDate:(NSDate *)date;
+ (NSDate *) dateForString:(NSString *)dateString;
+ (NSString *) formattedDate:(NSDate *)date;

@end
