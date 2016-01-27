//
//  VCQuestions.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/23/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "VCQuestions.h"
#import "VCMenu.h"
#import "FormQuestionTextView.h"
#import "QuestionModel.h"
#import "FormQuestionTextView.h"
#import "CameraObject.h"
#import "QuestionManager.h"
#import "CustomCellChooseAnswerTableViewCell.h"
#import "CustomCellLocation.h"
#import "CustomCellImageView.h"
#import "CustomCellTimes.h"
#import "CustomCellSwitch.h"
#import "CustomCellSignture.h"
#import "VCSignture.h"
#import <JSONModel/JSONModel.h>
#import "QuestionManagerDTO.h"
#import "VCResult.h"
#import <AFNetworking/UIAlertView+AFNetworking.h>
#import "CustomHeader.h"
#import "ServiceQuestions.h"
#import "CustomCellBackground.h"

static NSString * const formQuestionTextView = @"FormQuestionTextView";
static NSString * const customCellChooseAnswer = @"CustomCellChooseAnswer";
static NSString * const customCellImageView = @"CustomCellImageView";
static NSString * const customCellChooseAnswerTableViewCell = @"CustomCellChooseAnswerTableViewCell";
static NSString * const customCellLocation = @"CustomCellLocation";
static NSString * const customCellSignture = @"CustomCellSignture";
static NSString * const customCellTimes = @"CustomCellTimes";
static NSString * const customCellSwitch = @"CustomCellSwitch";

@interface VCQuestions ()<UITableViewDataSource, UITableViewDelegate>{
    UIImageView *imageStatusMenu;
    UIRefreshControl *refreshControl;
}
@property (nonatomic, strong) NSArray *arrayQuestions;
@property (nonatomic, strong) NSMutableArray *arrayFormQuestions;
@property (nonatomic, strong) QuestionManager *questionManager;
@end

@implementation VCQuestions

- (void)reload:(__unused id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    ServiceQuestions *service = [ServiceQuestions sharedClient];
    NSURLSessionTask *task = [service fetchData:^(NSArray *posts) {
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        self.questionManager = nil;
        self.questionManager.questionModels = posts;
        [self fetchData];
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

- (QuestionManager *)questionManager {
    if (!_questionManager) {
        _questionManager = [[QuestionManager alloc] init];
    }
    return _questionManager;
}

- (void)fetchData {
    if (self.questionManager.questionModels.count) {
        [self.buttonSubmit setHidden:NO];
    }
    if ([self.textSection isEqualToString:LocalizedString(keyMenuQuestionForm1)]) {
        self.questionManager.typeRandom = STATUS_RANDOM;
    }else{
        self.questionManager.typeRandom = STATUS_ALL;
    }
    [self.questionManager fetchData:^{
        [self.tbView reloadData];
        if (refreshControl) {
            [refreshControl endRefreshing];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registerTableViewCell];
    [self addRefreshControl];
    [self registerForKeyboardNotifications];
    [self setLeftButtonNavicationBar];
    [self.buttonSubmit setHidden:YES];
    [self reload:nil];
}

- (void)addRefreshControl {
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    [self.tbView addSubview:refreshControl];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)deregisterFromKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notification {
    CGSize kbSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
        [self.tbView setContentInset:edgeInsets];
        [self.tbView setScrollIndicatorInsets:edgeInsets];
    }];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    CGRect rect = self.navigationController.navigationBar.frame;
    float y = rect.size.height + rect.origin.y;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(y, 0, 0, 0);
    self.tbView.contentInset = edgeInsets;
    [self.tbView setScrollIndicatorInsets:edgeInsets];
}

#pragma mark - tableView
- (void)registerTableViewCell {
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([FormQuestionTextView class]) bundle:nil] forCellReuseIdentifier:formQuestionTextView];
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellChooseAnswerTableViewCell class]) bundle:nil] forCellReuseIdentifier:customCellChooseAnswerTableViewCell];
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellLocation class]) bundle:nil] forCellReuseIdentifier:customCellLocation];
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellImageView class]) bundle:nil] forCellReuseIdentifier:customCellImageView];
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellTimes class]) bundle:nil] forCellReuseIdentifier:customCellTimes];
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellSwitch class]) bundle:nil] forCellReuseIdentifier:customCellSwitch];
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellSignture class]) bundle:nil] forCellReuseIdentifier:customCellSignture];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questionManager.typeModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseModel *object = [self.questionManager.typeModels objectAtIndex:indexPath.row];
    object.viewController = self;
    return [object heightForBasicCellAtIndexPaths:indexPath tableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CustomHeader * header = [[CustomHeader alloc] init];
    header.titleLabel.text = self.textSection;
    return header;
}

// mutiple model types in QuestionManager, each model type is customcell question.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseModel *object = [self.questionManager.typeModels objectAtIndex:indexPath.row];
    object.reloadData = ^{
        [self.tbView reloadData];
    };
    UITableViewCell *cell = [object formQuestionTextViewAtIndexPath:indexPath tableView:tableView];
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * backgroundCell = [[CustomCellBackground alloc] init];
        cell.backgroundView = backgroundCell;
    }
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * selectedBackgroundCell = [[CustomCellBackground alloc] init];
        selectedBackgroundCell.selected = YES;
        cell.selectedBackgroundView = selectedBackgroundCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
}

- (IBAction)actionSubmit:(id)sender {
    [self.view endEditing:YES];
    NSArray *arrayMessage = [self.questionManager checkRequireField];
    if (!arrayMessage.count) {
        [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        [self stringJsonFromModel:self.questionManager success:^(NSString *stringJson) {
            [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
            VCResult *result = [[VCResult alloc] init];
            result.stringResult = stringJson;
            [self.navigationController pushViewController:result animated:YES];
        }];
    }else{
        NSString *message = [arrayMessage firstObject];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

- (void)stringJsonFromModel:(QuestionManager *)model success:(void(^)(NSString *stringJson))success{
    QuestionManagerDTO *customerDTO = [[QuestionManagerDTO alloc]init];
    customerDTO.typeModels = [model.typeDTOs copy];
    NSString *stringJson = [customerDTO toJSONString];
    if (success) {
        success(stringJson);
    }
}



@end
