//
//  BaseModel.h
//  MutipleCellInTableView
//
//  Created by Quach Ngoc Tam on 11/25/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JSONModel/JSONModel.h>

@interface BaseModel : JSONModel
@property (nonatomic, strong) UIViewController<Optional> *viewController;
@property (nonatomic, strong) NSNumber <Optional>*is_mandatory;
@property (nonatomic, strong) NSString <Optional>*question;
@property (nonatomic, readwrite, copy) void(^reloadData)();
- (CGFloat)heightForBasicCellAtIndexPaths:(NSIndexPath *)indexPath tableView:(UITableView*)tableView;
- (UITableViewCell *)formQuestionTextViewAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView;

- (void)fillData:(NSObject *)quesiontiModel;

- (NSObject*)convertDTOFromModel;

- (NSString *)checkRequire;

- (CGFloat)calculateHeightForConfiguredSizingCells:(UITableViewCell *)sizingCell;

@end
