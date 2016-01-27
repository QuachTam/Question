//
//  ModelText.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "ModelText.h"
#import "ModelTextDTO.h"
#import "FormQuestionTextView.h"
static NSString *formQuestionTextView = @"FormQuestionTextView";

@implementation ModelText

- (CGFloat)heightForBasicCellAtIndexPaths:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static FormQuestionTextView *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:formQuestionTextView];
    });
    
    [self configureformTableViewCell:sizingCell atIndexPath:indexPath tableView:tableView];
    return [self calculateHeightForConfiguredSizingCells:sizingCell];
}

- (void)configureformTableViewCell:(FormQuestionTextView *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    cell.question.text = self.question_text ? self.question_text: @"";
    cell.textViewAnswer.text = self.answer;
    cell.labelQuestion.text = self.question;
    // show icon require
    if (self.is_mandatory.boolValue) {
        [cell.imageRequire setHidden:NO];
    }else{
        [cell.imageRequire setHidden:YES];
    }
}

- (UITableViewCell *)formQuestionTextViewAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    FormQuestionTextView *cell = [tableView dequeueReusableCellWithIdentifier:formQuestionTextView];
    cell.didChangeEditTextView = ^(NSString *text){
        self.answer = text;
    };
    [self configureformTableViewCell:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

- (void)fillData:(NSObject *)quesiontiModel {
    QuestionModel *model = (QuestionModel*)quesiontiModel;
    self.question_text = model.question_text ? model.question_text : @"";
    self.is_mandatory = model.is_mandatory ? model.is_mandatory : @0;
}

// check field answer is require
- (NSString *)checkRequire {
    NSString *message = nil;
    if (self.is_mandatory.boolValue) {
        if (!self.answer.length){
            message = LocalizedString(keyModelTextAnswerIsRequire);
        }
    }
    return message;
}

- (NSString *)answer {
    if (!_answer) {
        _answer = @"";
    }
    return _answer;
}

// convert model to DTO for string json
- (NSObject*)convertDTOFromModel{
    ModelTextDTO *dto = [[ModelTextDTO alloc] init];
    dto.question_text = self.question_text;
    dto.answer = self.answer;
    return dto;
}

@end
