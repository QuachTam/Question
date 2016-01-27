//
//  ModelChoose.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "ModelChoose.h"
#import "ModelChooseDTO.h"
#import "CustomCellChooseAnswerTableViewCell.h"
static NSString *const customCellChooseAnswerTableViewCell = @"CustomCellChooseAnswerTableViewCell";
@implementation ModelChoose

- (CGFloat)heightForBasicCellAtIndexPaths:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static CustomCellChooseAnswerTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:customCellChooseAnswerTableViewCell];
    });
    
    [self configureformQuestionTextViewCells:sizingCell atIndexPath:indexPath tableView:tableView];
    return [self calculateHeightForConfiguredSizingCells:sizingCell] + self.arrayChoose.count * 44;
}

- (void)configureformQuestionTextViewCells:(CustomCellChooseAnswerTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    cell.questionText.text = self.question_text ? self.question_text: @"";
    cell.arrayData = self.arrayChoose;
    cell.labelQuestion.text = self.question;
    // show icon require
    if (self.is_mandatory.boolValue) {
        [cell.imageRequire setHidden:NO];
    }else{
        [cell.imageRequire setHidden:YES];
    }
    cell.labelQuestion.text = self.question;
    [cell reloadData];
}

- (UITableViewCell *)formQuestionTextViewAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellChooseAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellChooseAnswerTableViewCell];
    cell.didCompleteChoose = ^(NSArray *result) {
        self.arrayChoosed = result;
        NSLog(@"arrayChoosed: %@", self.arrayChoosed);
    };
    [self configureformQuestionTextViewCells:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

- (void)fillData:(NSObject *)quesiontiModel {
    QuestionModel *model = (QuestionModel*)quesiontiModel;
    self.question_text = model.question_text ? model.question_text : @"";
    self.is_mandatory = model.is_mandatory ? model.is_mandatory : @0;
    NSArray *array = [model.choices componentsSeparatedByString:@";"];
    self.arrayChoose = [array copy];
}

- (NSString *)checkRequire {
    NSString *message = nil;
    if (self.is_mandatory.boolValue) {
        if (!self.arrayChoosed.count)
            message = LocalizedString(keyModelTextAnswerIsRequire);
    }
    return message;
}

- (NSObject*)convertDTOFromModel{
    ModelChooseDTO *dto = [[ModelChooseDTO alloc] init];
    dto.question_text = self.question_text;
    dto.arrayChoose = self.arrayChoosed;
    return dto;
}

@end
