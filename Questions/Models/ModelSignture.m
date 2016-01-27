//
//  ModelSignture.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/30/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "ModelSignture.h"
#import "ModelSigntureDTO.h"
#import "VCSignture.h"
#import <MZFormSheetController/MZFormSheetController.h>
#import "VCQuestions.h"
#import "QSCommon.h"
static NSString *const customCellSignture = @"CustomCellSignture";
@implementation ModelSignture
- (CGFloat)heightForBasicCellAtIndexPaths:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static CustomCellSignture *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:customCellSignture];
    });
    [self configureformQuestionTextViewCells:sizingCell atIndexPath:indexPath tableView:tableView];
    return [self calculateHeightForConfiguredSizingCells:sizingCell];
}

- (void)configureformQuestionTextViewCells:(CustomCellSignture *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    cell.textQuestion.text = self.question_text ? self.question_text : @"";
    cell.labelQuestion.text = self.question;
    cell.imageSignture.image = self.imageSignture;
    // show icon require
    if (self.is_mandatory.boolValue) {
        [cell.imageRequire setHidden:NO];
    }else{
        [cell.imageRequire setHidden:YES];
    }
}

- (UITableViewCell *)formQuestionTextViewAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellSignture *cell = [tableView dequeueReusableCellWithIdentifier:customCellSignture];
    __weak __typeof(self)weak = self;
    cell.didClickSignture = ^(CustomCellSignture *currentCell){
        [weak onTheEvent:currentCell];
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
        if (!self.imageSignture.size.height)
            message = LocalizedString(keyModelTextAnswerIsRequire);
    }
    return message;
}

- (void)onTheEvent:(CustomCellSignture *)cell{
    VCSignture *datePickerVC = [[VCSignture alloc] initWithNibName:@"VCSignture" bundle:nil];
    datePickerVC.didCompleteSignture = ^(UIImage *signtureImage){
        self.imageSignture = signtureImage;
        VCQuestions *xxx = (VCQuestions*)self.viewController;
        [xxx.tbView reloadData];
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:datePickerVC];
    MZFormSheetController * formController = [[MZFormSheetController alloc] initWithSize:CGSizeMake(self.viewController.view.frame.size.width/2, self.viewController.view.frame.size.height/2) viewController:nav];
    formController.shouldCenterVertically = YES;
    formController.shouldDismissOnBackgroundViewTap = YES;
    formController.transitionStyle = MZFormSheetTransitionStyleSlideFromRight;
    [self.viewController.navigationController mz_presentFormSheetController:formController animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
}

- (NSObject*)convertDTOFromModel{
    ModelSigntureDTO *dto = [[ModelSigntureDTO alloc] init];
    dto.question_text = self.question_text;
    dto.imageSigntureString = [QSCommon imageToNSString:self.imageSignture];
    return dto;
}


@end
