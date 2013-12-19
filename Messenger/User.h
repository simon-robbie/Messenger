//
//  User.h
//  Messenger
//
//  Created by Simon Robbie on 12/18/13.
//  Copyright (c) 2013 Simon Robbie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(long, UserID)
{
    kUserIDAlice,
    kUserIDBob,
    kUserIDCharlie
};

@interface User : NSObject

@property (nonatomic) NSString *name;

+ (NSArray *) users;

@end
