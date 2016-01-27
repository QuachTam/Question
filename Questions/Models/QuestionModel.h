//
//  QuestionModel.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/24/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface QuestionModel : BaseModel
@property (nonatomic, strong) NSString <Optional>*question_id;
@property (nonatomic, strong) NSString <Optional>*question_text;
@property (nonatomic, strong) NSString <Optional>*prompt;
@property (nonatomic, strong) NSString <Optional>*choices;
@property (nonatomic, strong) NSString <Optional>*question_type;
//@property (nonatomic, strong) NSArray <Optional>*child_questions;
@property (nonatomic, strong) NSDate <Optional>*datestamp;
@property (nonatomic, strong) NSNumber <Optional> *is_mandatory;
@end
