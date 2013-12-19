//
//  DateUtil.m
//  Messenger
//
//  Created by Simon Robbie on 12/18/13.
//  Copyright (c) 2013 Simon Robbie. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+ (NSString *) stringForDate:(NSDate *)date
{
    NSString *string = [NSString stringWithFormat:@"%llu", (long long)(date.timeIntervalSince1970 * 1000.0)];
    
    return string;
}

+ (NSDate *) dateForString:(NSString *)dateString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateString.longLongValue / 1000.0];
    
    return date;
}

+ (NSString *) formattedDate:(NSDate *)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm:ss"];
    
    NSString *dateString = [format stringFromDate:date];
    
    return dateString;
}

@end
