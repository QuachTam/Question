//
//  ServiceQuestions.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/25/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionModel.h"

@interface ServiceQuestions : NSObject
+ (instancetype)sharedClient;
- (NSURLSessionTask *)fetchData:(void(^)(NSArray *posts))success;
@end
