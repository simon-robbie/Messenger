//
//  MessageCenter.m
//  Messenger
//
//  Created by Simon Robbie on 12/18/13.
//  Copyright (c) 2013 Simon Robbie. All rights reserved.
//

#import "MessageCenter.h"

#import "DateUtil.h"
#import "Message.h"
#import "S3Controller.h"
#import "User.h"

@implementation MessageCenter

+ (NSString *) bucketFromUser:(User *)fromUser toUser:(User *)toUser
{
    return [NSString stringWithFormat:@"%@_%@", fromUser.name, toUser.name];
}

+ (NSArray *) messagesToUser:(User *)toUser fromUser:(User *)fromUser sinceDate:(NSDate *)lastDate
{
    S3Controller *controller = [S3Controller sharedInstance];
    NSString *bucket = [MessageCenter bucketFromUser:fromUser toUser:toUser];
    NSArray *texts = [controller textsSinceDate:lastDate bucket:bucket];
    NSMutableArray *messages = [NSMutableArray array];
    
    for (NSDictionary *textItem in texts) {
        Message *message = [Message new];
        NSString *stringDate = [textItem valueForKey:@"date"];
        NSDate *date = [DateUtil dateForString:stringDate];
        NSString *text = [textItem valueForKey:@"text"];
        
        message.date = date;
        message.text = text;
        [messages insertObject:message atIndex:0];
    }
    
    return messages;
}

+ (void) sendMessage:(NSString *)message fromUser:(User *)fromUser toUser:(User *)toUser
{
    S3Controller *controller = [S3Controller sharedInstance];
    NSString *bucket = [MessageCenter bucketFromUser:fromUser toUser:toUser];

    [controller uploadText:message bucket:bucket];
}

@end
