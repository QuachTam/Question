//
//  QuestionManager.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "QuestionManager.h"
#import "AFAppDotNetAPIClient.h"
#import "QuestionModel.h"

NSInteger MAX_RANDOM = 5;

@interface QuestionManager ()
@property (nonatomic, strong) NSDictionary *dictionaryModelType;
@property (nonatomic, strong) NSArray *ranDomType;
@end
@implementation QuestionManager
@synthesize typeDTOs;

// types model define
- (NSDictionary *)dictionaryModelType {
    if (!_dictionaryModelType) {
        _dictionaryModelType = @{@"1" : @"ModelText",      // model for type question + input text for answer
                                 @"2" : @"ModelLocation",  // model for type question + get current location for answer
                                 @"3" : @"ModelChoose",    // model for type question + select for answer
                                 @"4" : @"ModelImage",     // model for type question + take photo, choose photo for answer
                                 @"5" : @"ModelTimes",     // model for type question + get current times device for answer
                                 @"6" : @"ModelDate",      // model for type question + get current date device for answer
                                 @"7" : @"ModelSwitch",     // model for type question + choose switch on/off for answer
                                 @"8" : @"ModelSignture",   // model for type question + signture for answer
                                 @"9" : @"ModelTimes",
                                 @"10" : @"ModelDate"};
    }
    return _dictionaryModelType;
}

// random type model show in view when select form question.
- (NSArray *)ranDomType {
    if (self.typeRandom==STATUS_ALL) {
        return @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    }
    NSMutableArray *array = [NSMutableArray new];
    for (NSInteger index=0; index<MAX_RANDOM; index++) {
        NSInteger randomNumber = arc4random() % 7 + 1;
        if (![array containsObject:[NSString stringWithFormat:@"%ld",(long)randomNumber]]) {
            [array addObject:[NSString stringWithFormat:@"%ld", (long)randomNumber]];
        }
    }
    return [array copy];
}

// create new data model show in view when select form question
- (void)fetchData:(void(^)(void))success{
    NSMutableArray *arrayData = [NSMutableArray new];
    NSArray *arrayType = self.ranDomType;
    for (NSInteger index=0; index<self.questionModels.count; index++) {
        QuestionModel *model = [self.questionModels objectAtIndex:index];
        if ([arrayType containsObject:model.question_type]) {
            // create class with name model with type model define.
            Class theClass = NSClassFromString([self.dictionaryModelType objectForKey:model.question_type]);
            BaseModel *myObject = [[theClass alloc] init];
            myObject.question = [NSString stringWithFormat:@"%@ %ld?", LocalizedString(keyDropDownMenuTitle), arrayData.count+1];
            [myObject fillData:model];
            [arrayData addObject:myObject];
        }
    }
    self.typeModels = nil;
    self.typeModels = [arrayData copy];
    if (success) {
        success();
    }
}

- (NSArray *)typeDTOs {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (BaseModel *baseModel in self.typeModels) {
        NSObject *objectDTO = [baseModel convertDTOFromModel];
        if (objectDTO) {
            [array addObject:objectDTO];
        }
    }
    return [array copy];
}

- (NSArray *)checkRequireField {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (BaseModel *baseModel in self.typeModels) {
        NSString *message = [baseModel checkRequire];
        if (message) {
            [array addObject:message];
        }
    }
    return [array copy];
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
