//
//  User.m
//  Messenger
//
//  Created by Simon Robbie on 12/18/13.
//  Copyright (c) 2013 Simon Robbie. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *) withName:(NSString *)name
{
    User *user = [User new];
    
    user.name = name;
    
    return user;
}

+ (NSArray *) users
{
    return @[ [User withName:@"Alice"], [User withName:@"Bob"], [User withName:@"Charlie"] ];
}

@end
