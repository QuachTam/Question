//
//  ModelLocation.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "ModelLocation.h"
#import "ModelLocationDTO.h"
#import "CustomCellLocation.h"
#import "CustomCellBackground.h"
static NSString *const customCellLocation = @"CustomCellLocation";
@implementation ModelLocation

- (CGFloat)heightForBasicCellAtIndexPaths:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static CustomCellLocation *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:customCellLocation];
    });
    
    [self configureformQuestionTextViewCells:sizingCell atIndexPath:indexPath tableView:tableView];
    return [self calculateHeightForConfiguredSizingCells:sizingCell];
}

- (void)configureformQuestionTextViewCells:(CustomCellLocation *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    cell.textQuestion.text = self.question_text ? self.question_text : @"";
    cell.labelQuestion.text = self.question;
    cell.address.text = self.address?self.address:@"";
    cell.stringLat.text = self.stringLat?self.stringLat:@"";
    cell.stringLong.text = self.stringLong?self.stringLong:@"";
    
    // show icon require
    if (self.is_mandatory.boolValue) {
        [cell.imageRequire setHidden:NO];
    }else{
        [cell.imageRequire setHidden:YES];
    }
}

- (UITableViewCell *)formQuestionTextViewAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellLocation *cell = [tableView dequeueReusableCellWithIdentifier:customCellLocation];
    [self configureformQuestionTextViewCells:cell atIndexPath:indexPath tableView:tableView];
    cell.didClickGetCurrentLocation = ^(NSString *cLat, NSString *cLong, NSString *address){
        self.address = address;
        self.stringLat = cLat?cLat : _stringLat;
        self.stringLong = cLong ?cLong : _stringLong;
        if (self.reloadData) {
            self.reloadData();
        }
     };
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
        if (!self.address.length || !self.stringLat.length || !self.stringLong.length)
            message = LocalizedString(keyModelTextAnswerIsRequire);
    }
    return message;
}

- (NSObject*)convertDTOFromModel{
    ModelLocationDTO *dto = [[ModelLocationDTO alloc] init];
    dto.question_text = self.question_text;
    dto.address = self.address;
    dto.stringLat = self.stringLat;
    dto.stringLong = self.stringLong;
    return dto;
}


@end
