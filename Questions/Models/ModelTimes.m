//
//  ModelTimes.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "ModelTimes.h"
#import "ModelTimesDTO.h"
#import "CustomCellTimes.h"
static NSString *const customCellTimes = @"CustomCellTimes";
@implementation ModelTimes
- (CGFloat)heightForBasicCellAtIndexPaths:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static CustomCellTimes *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:customCellTimes];
    });
    
    [self configureformQuestionTextViewCells:sizingCell atIndexPath:indexPath tableView:tableView];
    return [self calculateHeightForConfiguredSizingCells:sizingCell];
}

- (void)configureformQuestionTextViewCells:(CustomCellTimes *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    cell.textQuestion.text = self.question_text ? self.question_text : @"";
    cell.labelQuestion.text = self.question;
    cell.labelTimes.text = self.stringTimes ? self.stringTimes : @"";
    [cell setTitle];
    // show icon require
    if (self.is_mandatory.boolValue) {
        [cell.imageRequire setHidden:NO];
    }else{
        [cell.imageRequire setHidden:YES];
    }
}

- (UITableViewCell *)formQuestionTextViewAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellTimes *cell = [tableView dequeueReusableCellWithIdentifier:customCellTimes];
    cell.type = timesType;
    cell.didCompleteGetTime = ^(NSString *stringDate){
        self.stringTimes = stringDate;
    };
    [self configureformQuestionTextViewCells:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

- (NSString *)checkRequire {
    NSString *message = nil;
    if (self.is_mandatory.boolValue) {
        if (!self.stringTimes)
            message = LocalizedString(keyModelTextAnswerIsRequire);
    }
    return message;
}

- (void)fillData:(NSObject *)quesiontiModel {
    QuestionModel *model = (QuestionModel*)quesiontiModel;
    self.question_text = model.question_text ? model.question_text : @"";
    self.is_mandatory = model.is_mandatory ? model.is_mandatory : @0;
}

- (NSObject*)convertDTOFromModel{
    ModelTimesDTO *dto = [[ModelTimesDTO alloc] init];
    dto.question_text = self.question_text;
    dto.stringTimes = self.stringTimes;
    return dto;
}

@end
