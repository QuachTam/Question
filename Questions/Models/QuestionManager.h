//
//  QuestionManager.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionModel.h"
typedef NS_ENUM(NSInteger, ManagerRandomStatus) {
    STATUS_RANDOM,
    STATUS_ALL,
};
@interface QuestionManager : NSObject
@property (nonatomic, strong) NSArray *questionModels; // Array all question model get from server
@property (nonatomic, strong) NSArray *typeModels; // Array mutiple model show in view
@property (nonatomic, assign) NSArray *typeDTOs; // Array convert model from "typeModels" to DTO
@property (nonatomic, readwrite) ManagerRandomStatus typeRandom;
- (void)fetchData:(void(^)(void))success;
+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;
- (NSArray *)checkRequireField;
@end
