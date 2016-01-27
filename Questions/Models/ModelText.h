//
//  ModelText.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "BaseModel.h"
#import "QuestionModel.h"
#import "FormQuestionTextView.h"

@interface ModelText : BaseModel
@property (nonatomic, strong) NSString *question_text;
@property (nonatomic, strong) NSString *answer;

@end
