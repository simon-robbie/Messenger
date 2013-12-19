//
//  MessageCenter.h
//  Messenger
//
//  Created by Simon Robbie on 12/18/13.
//  Copyright (c) 2013 Simon Robbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface MessageCenter : NSObject

// Last message first.
+ (NSArray *) messagesToUser:(User *)toUser fromUser:(User *)fromUser sinceDate:(NSDate *)lastDate;

+ (void) sendMessage:(NSString *)message fromUser:(User *)fromUSer toUser:(User *)toUser;

@end
