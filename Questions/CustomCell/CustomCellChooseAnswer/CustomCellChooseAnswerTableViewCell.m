//
//  CustomCellChooseAnswerTableViewCell.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "CustomCellChooseAnswerTableViewCell.h"
#import <PureLayout/PureLayout.h>
#import "CustomCellDropDownMenu.h"
#import "CustomCellBackground.h"

@interface CustomCellChooseAnswerTableViewCell()

@end

@implementation CustomCellChooseAnswerTableViewCell
@synthesize arrayData; //array to hold submenu data

- (void)awakeFromNib {
    // Initialization code
    self.frame = CGRectMake(0, 0, 300, 50);
    if (!self.labelQuestion) {
        self.labelQuestion = [[UILabel alloc] initForAutoLayout];
        self.labelQuestion.textAlignment = NSTextAlignmentLeft;
        [self.labelQuestion setFont:[UIFont boldSystemFontOfSize:15]];
        [self.contentView addSubview:self.labelQuestion];
    }
    
    if (!self.imageRequire) {
        self.imageRequire = [[UIImageView alloc] initForAutoLayout];
        [self.imageRequire setImage:[UIImage imageNamed:@"UITableExpand"]];
        [self.contentView addSubview:self.imageRequire];
    }
    
    if (!self.questionText) {
        self.questionText = [[RWLabel alloc] initForAutoLayout];
        [self.questionText setNumberOfLines:0];
        [self.questionText setPreferredMaxLayoutWidth:300];
        self.questionText.textAlignment = NSTextAlignmentLeft;
        self.questionText.backgroundColor = [UIColor clearColor];
        [self.questionText setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:self.questionText];
    }
    
    if (!self.answer) {
        self.answer = [[UILabel alloc] initForAutoLayout];
        self.answer.text = @"Answer";
        [self.answer setFont:[UIFont boldSystemFontOfSize:15]];
        self.answer.textAlignment = NSTextAlignmentLeft;
        self.answer.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.answer];
    }
    
    if (!self.subMenuTableView) {
        self.subMenuTableView = [[UITableView alloc] initForAutoLayout]; //create tableview a
        self.subMenuTableView.backgroundColor = [UIColor clearColor];
        self.subMenuTableView.delegate = self;
        self.subMenuTableView.dataSource = self;
        [self.subMenuTableView setScrollEnabled:NO];
        [self.subMenuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.contentView addSubview:self.subMenuTableView]; // add it cell
    }
    
    [self registerTableViewCell];
}

#pragma mark - tableView
- (void)registerTableViewCell {
    [self.subMenuTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellDropDownMenu class]) bundle:nil] forCellReuseIdentifier:@"CustomCellDropDownMenu"];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)reloadData{
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
    [self setNeedsDisplay];
    
    [self.subMenuTableView reloadData];
    if (self.didCompleteReloadData) {
        self.didCompleteReloadData();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.labelQuestion autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:13];
    [self.labelQuestion autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.labelQuestion autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.labelQuestion autoSetDimension:ALDimensionHeight toSize:21];
    
    [self.imageRequire autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.imageRequire autoSetDimension:ALDimensionHeight toSize:15];
    [self.imageRequire autoSetDimension:ALDimensionWidth toSize:15];
    [self.imageRequire autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.labelQuestion];
    
    [self.questionText autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:13];
    [self.questionText autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.questionText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.labelQuestion withOffset:2];
    
    [self.answer autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:13];
    [self.answer autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.answer autoSetDimension:ALDimensionHeight toSize:21];
    [self.answer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.questionText withOffset:2];
    
    [self.subMenuTableView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    [self.subMenuTableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.subMenuTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.answer withOffset:2];
    [self.subMenuTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
}

//manage datasource and  delegate for submenu tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCellDropDownMenu *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCellDropDownMenu"];
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * backgroundCell = [[CustomCellBackground alloc] init];
        cell.backgroundView = backgroundCell;
    }
    
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * selectedBackgroundCell = [[CustomCellBackground alloc] init];
        selectedBackgroundCell.selected = YES;
        cell.selectedBackgroundView = selectedBackgroundCell;
    }
    cell.labelTextQuestion.text = [self.arrayData objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (!self.selectedIndexes) {
        self.selectedIndexes = [[NSMutableArray alloc] init];
    }
    if ([selectedCell accessoryType] == UITableViewCellAccessoryNone) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [self.selectedIndexes addObject:[NSNumber numberWithInt:(int)indexPath.row]];
    }
    else {
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
        [self.selectedIndexes removeObject:[NSNumber numberWithInt:(int)indexPath.row]];
    }
    if (self.didCompleteChoose) {
        self.didCompleteChoose([self arrayWithIndex:self.selectedIndexes]);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSArray *)arrayWithIndex:(NSArray *)arrayIndex {
    NSMutableArray *array = [NSMutableArray new];
    for (NSNumber *number in arrayIndex) {
        NSString *string = [self.arrayData objectAtIndex:[number integerValue]];
        [array addObject:string];
    }
    return [array copy];
}

@end
