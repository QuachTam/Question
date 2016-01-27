//
//  ServiceQuestions.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/25/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "ServiceQuestions.h"
#import "AFAppDotNetAPIClient.h"

@implementation ServiceQuestions


+ (instancetype)sharedClient {
    static ServiceQuestions *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ServiceQuestions alloc] init];
    });
    return _sharedClient;
}

- (NSURLSessionTask *)fetchData:(void(^)(NSArray *posts))success{
    NSURLSessionTask *task = [[self class] globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (!error) {
            if (success) {
                success(posts);
            }
        }
    }];
    return task;
}

#pragma mark -

+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
    
    return [[AFAppDotNetAPIClient sharedClient] GET:@"apps/" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *postsFromResponse = (NSArray *)JSON;
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary *attributes in postsFromResponse) {
            NSError *error;
            QuestionModel *questionModel = [[QuestionModel alloc] initWithDictionary:attributes error:&error];
            [mutablePosts addObject:questionModel];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

@end
