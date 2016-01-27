//
//  VCDropDownMenu.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/23/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "VCMenu.h"
#import "CustomCellDropDownMenu.h"
#import "VCQuestions.h"
#import "CustomCellBackground.h"

static NSString *stringIdentify = @"CustomCellDropDownMenu";
static NSInteger HEIGHT_ROW_INDEXPATH_DEFAULT = 44;

@interface VCMenu ()<UITableViewDataSource, UITableViewDelegate>{
    NSInteger _presentedRow;
}
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation VCMenu

- (void)registerTableViewCell {
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellDropDownMenu class]) bundle:nil] forCellReuseIdentifier:stringIdentify];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = LocalizedString(keyDropDownMenuTitle);
    self.currentRow = -1;
    [self registerTableViewCell];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tbView reloadData];
    self.lastSelectedIndexPath = [self indexPathFromRow:self.currentRow section:0];
    [self setCheckMarkCellSelectedAtIndexPath:[self indexPathFromRow:self.currentRow section:0]];
    [self scrollToCellIfNeed:[self indexPathFromRow:self.currentRow section:0]]; // default one section.
}

#pragma mark - method
- (BOOL)currentRowIsInRowTable{
    if (self.currentRow > 0 && self.currentRow < self.datas.count)
        return YES;
    return NO;
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath tableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath tableView:tableView];
}

- (CustomCellDropDownMenu *)basicCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellDropDownMenu *cell = [self.tbView dequeueReusableCellWithIdentifier:stringIdentify];
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * backgroundCell = [[CustomCellBackground alloc] init];
        cell.backgroundView = backgroundCell;
    }
    
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * selectedBackgroundCell = [[CustomCellBackground alloc] init];
        selectedBackgroundCell.selected = YES;
        cell.selectedBackgroundView = selectedBackgroundCell;
    }
    [self configureBasicCell:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

- (void)configureBasicCell:(CustomCellDropDownMenu *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    cell.labelTextQuestion.text = [self.datas objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    NSInteger row = indexPath.row;
    if ( row == _presentedRow)
    {
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }
    // otherwise we'll create a new frontViewController and push it with animation
    VCQuestions *newFrontController = [[VCQuestions alloc] init];
    newFrontController.textSection = [self.datas objectAtIndex:indexPath.row];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
    [revealController pushFrontViewController:navigationController animated:YES];
    _presentedRow = row;  // <- store the presented row
}

- (NSIndexPath*)indexPathFromRow:(NSInteger)row section:(NSInteger)section{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    return indexPath;
}

- (void)scrollToCellIfNeed:(NSIndexPath *)indexPath {
    if ([self currentRowIsInRowTable]) { // currentRow must in row
        [self.tbView scrollToRowAtIndexPath:indexPath
                           atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}

- (void)setCheckMarkCellSelectedAtIndexPath:(NSIndexPath*)indexPath {
    if ([self currentRowIsInRowTable]) {
        UITableViewCell *cell = [self.tbView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.tbView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static CustomCellDropDownMenu *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tbView dequeueReusableCellWithIdentifier:stringIdentify];
    });
    
    [self configureBasicCell:sizingCell atIndexPath:indexPath tableView:tableView];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    if (size.height<HEIGHT_ROW_INDEXPATH_DEFAULT) {
        return HEIGHT_ROW_INDEXPATH_DEFAULT;
    }
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}

- (NSArray *)datas {
    if (!_datas) {
        _datas =@[LocalizedString(keyMenuQuestionForm1), LocalizedString(keyMenuQuestionForm2)];
    }
    return _datas;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
