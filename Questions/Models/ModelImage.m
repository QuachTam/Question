//
//  ModelImage.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "ModelImage.h"
#import "ModelImageDTO.h"
#import "QSCommon.h"
#import "CustomCellImageView.h"
static NSString *const customCellImageView = @"CustomCellImageView";
@implementation ModelImage
- (CGFloat)heightForBasicCellAtIndexPaths:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static CustomCellImageView *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:customCellImageView];
    });
    
    [self configureformQuestionTextViewCells:sizingCell atIndexPath:indexPath tableView:tableView];
    return [self calculateHeightForConfiguredSizingCells:sizingCell];
}

- (void)configureformQuestionTextViewCells:(CustomCellImageView *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    cell.textQuestion.text = self.question_text ? self.question_text : @"";
    cell.labelQuestion.text = self.question;
    cell.imageView.image = self.image;
    // show icon require
    if (self.is_mandatory.boolValue) {
        [cell.imageRequire setHidden:NO];
    }else{
        [cell.imageRequire setHidden:YES];
    }
}

- (UITableViewCell *)formQuestionTextViewAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellImageView *cell = [tableView dequeueReusableCellWithIdentifier:customCellImageView];
    cell.supperView = self.viewController;
    cell.didCompleteTakePhoto = ^(UIImage *image){
        self.image = image;
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
        if (!self.image.size.height)
           message = LocalizedString(keyModelTextAnswerIsRequire);
    }
    return message;
}

- (NSObject*)convertDTOFromModel{
    ModelImageDTO *dto = [[ModelImageDTO alloc] init];
    dto.question_text = self.question_text;
    dto.imageBase64 = [QSCommon imageToNSString:self.image];
    NSLog(@"dto.imageBase64: %ld", (long)[QSCommon imageToNSString:self.image].length);
    return dto;
}

@end
