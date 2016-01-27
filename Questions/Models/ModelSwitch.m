//
//  ModelSwitch.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "ModelSwitch.h"
#import "ModelSwitchDTO.h"
#import "CustomCellSwitch.h"
static NSString *const customCellSwitch = @"CustomCellSwitch";
@implementation ModelSwitch

- (CGFloat)heightForBasicCellAtIndexPaths:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static CustomCellSwitch *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:customCellSwitch];
    });
    
    [self configureformQuestionTextViewCells:sizingCell atIndexPath:indexPath tableView:tableView];
    return [self calculateHeightForConfiguredSizingCells:sizingCell];
}

- (void)configureformQuestionTextViewCells:(CustomCellSwitch *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    cell.textQuestion.text = self.question_text ? self.question_text : @"";
    cell.labelQuestion.text = self.question;
    [cell.statusSwitch setOn:self.isOn];
    // show icon require
    if (self.is_mandatory.boolValue) {
        [cell.imageRequire setHidden:NO];
    }else{
        [cell.imageRequire setHidden:YES];
    }
}

- (UITableViewCell *)formQuestionTextViewAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellSwitch *cell = [tableView dequeueReusableCellWithIdentifier:customCellSwitch];
    cell.didChangeValue = ^(BOOL isOn){
        self.isOn = isOn;
    };
    [self configureformQuestionTextViewCells:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

- (void)fillData:(NSObject *)quesiontiModel {
    QuestionModel *model = (QuestionModel*)quesiontiModel;
    self.question_text = model.question_text ? model.question_text : @"";
    self.is_mandatory = model.is_mandatory ? model.is_mandatory : @0;
    self.isOn = YES;
}

- (NSString *)checkRequire {
    NSString *message = nil;
    if (self.is_mandatory.boolValue) {
        if (!self.isOn)
            message = LocalizedString(keyModelTextAnswerIsRequire);
    }
    return message;
}

- (NSObject*)convertDTOFromModel{
    ModelSwitchDTO *dto = [[ModelSwitchDTO alloc] init];
    dto.question_text = self.question_text;
    dto.isOn = [NSNumber numberWithBool:self.isOn];
    return dto;
}


@end
