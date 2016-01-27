//
//  VCSignture.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/30/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "VCSignture.h"
#import <PureLayout/PureLayout.h>
#import <MZFormSheetController/MZFormSheetController.h>

@interface VCSignture ()

@end

@implementation VCSignture

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setButtonNavicationBar];
    
    SignatureView *view = [[SignatureView alloc] initForAutoLayout];
    [self.view addSubview:view];
    
    [view autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [view autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [view autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [view autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    
    self.signatureView = view;
}

- (void)setButtonNavicationBar {
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearAction:)];
    self.navigationItem.leftBarButtonItem = refreshItem;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    self.navigationItem.rightBarButtonItem = save;
}

- (void)clearAction:(id)sender {
    [self.signatureView clear];
}

- (void)saveAction:(id)sender {
    if (self.didCompleteSignture) {
        self.didCompleteSignture(self.signatureView.signatureImage);
    }
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
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
