//
//  S3Controller.m
//  Messenger
//
//  Created by Simon Robbie on 12/18/13.
//  Copyright (c) 2013 Simon Robbie. All rights reserved.
//

#import "S3Controller.h"

#import "DateUtil.h"

#import <AWSS3/AWSS3.h>
#import <AWSRuntime/AWSRuntime.h>

#define ACCESS_KEY_ID          @"AKIAJ5RIACMKEN5KS5TQ"
#define SECRET_KEY             @"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"

@interface S3Controller ()

@property (nonatomic, retain) AmazonS3Client *s3;

@end

@implementation S3Controller

+ (S3Controller *) sharedInstance
{
    static S3Controller *sController = nil;
    
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sController = [[S3Controller alloc] init];
    });
    
    return sController;
}

- (id) init
{
    self = [super init];
    
    if (self) {
        self.s3 = [[AmazonS3Client alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY];
    }
    
    return self;
}

- (NSArray *) textsSinceDate:(NSDate *)date bucket:(NSString *)bucket
{
    NSMutableArray *texts = [NSMutableArray array];
    S3ListObjectsRequest *lor = [[S3ListObjectsRequest alloc] initWithName:bucket];
    S3ListObjectsResponse *lorResponse = [self.s3 listObjects:lor];
    S3ListObjectsResult *lorResult = lorResponse.listObjectsResult;
    
    if (lorResult) {
        for (S3ObjectSummary *summary in lorResult.objectSummaries) {
            NSString *key = summary.key;
            S3GetObjectRequest *gor = [[S3GetObjectRequest alloc] initWithKey:key withBucket:bucket];
            S3GetObjectResponse *downloadResponse = [self.s3 getObject:gor];
            NSDate *keyDate = [DateUtil dateForString:key];
            
            if ([keyDate compare:date] == NSOrderedDescending) {
                NSData *data = downloadResponse.body;
                NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                [texts addObject:@{ @"date": key,
                                    @"text": text }];
            }
        }
    }

    return texts;
}

- (void) uploadText:(NSString *)text bucket:(NSString *)bucket
{
    NSDate *date = [NSDate date];
    NSString *key = [DateUtil stringForDate:date];
    S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:key inBucket:bucket];
    
    por.contentType = @"text";
    por.data = [text dataUsingEncoding:NSUTF8StringEncoding];
    [self.s3 putObject:por];
}

@end
