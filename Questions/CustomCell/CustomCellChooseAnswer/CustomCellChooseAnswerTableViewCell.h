//
//  CustomCellChooseAnswerTableViewCell.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWLabel.h"
#import "CustomCellCommon.h"

@interface CustomCellChooseAnswerTableViewCell : CustomCellCommon<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) UILabel *labelQuestion;
@property (nonatomic, strong) RWLabel *questionText;
@property (nonatomic, strong) NSMutableArray *selectedIndexes;
@property (nonatomic, strong) UILabel *answer;
@property (nonatomic, strong) UIImageView *imageRequire;
@property (nonatomic, strong) UITableView *subMenuTableView;
@property (nonatomic, copy, readwrite) void(^didCompleteChoose)(NSArray *result);
@property (nonatomic, copy, readwrite) void(^didCompleteReloadData)();
- (void)reloadData;
@end
