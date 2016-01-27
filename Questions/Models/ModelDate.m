//
//  ModelDate.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "ModelDate.h"
#import "ModelDateDTO.h"
#import "CustomCellTimes.h"
static NSString *const customCellTimes = @"CustomCellTimes";
@implementation ModelDate
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
    cell.labelTimes.text = self.stringDate ? self.stringDate : @"";
    
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
    cell.type = dateType;
    cell.didCompleteGetTime = ^(NSString *stringDate){
        self.stringDate = stringDate;
    };
    [self configureformQuestionTextViewCells:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

- (void)fillData:(NSObject *)quesiontiModel {
    QuestionModel *model = (QuestionModel*)quesiontiModel;
    self.question_text = model.question_text ? model.question_text : @"";
    self.is_mandatory = model.is_mandatory ? model.is_mandatory : @0;
}

- (NSString *)checkRequire {
    NSString *message = nil;
    if (self.is_mandatory.boolValue) {
        if (!self.stringDate)
            message = LocalizedString(keyModelTextAnswerIsRequire);
    }
    return message;
}

- (NSObject*)convertDTOFromModel{
    ModelDateDTO *dto = [[ModelDateDTO alloc] init];
    dto.question_text = self.question_text;
    dto.stringDate = self.stringDate;
    return dto;
}
@end
