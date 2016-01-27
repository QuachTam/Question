//
//  ViewController.m
//  MapDetail
//
//  Created by Quach Ngoc Tam on 11/9/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "VCMain.h"
#import "VCQuestions.h"
#import "VCMenu.h"

@interface VCMain ()<SWRevealViewControllerDelegate>

@end

@implementation VCMain
@synthesize viewController = _viewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpSWRevealViewController];
}

- (void)setUpSWRevealViewController{
    VCQuestions *centerViewController = [[VCQuestions alloc] init]; // center viewcontroller
    centerViewController.textSection = LocalizedString(keyMenuQuestionForm1);
    VCMenu *leftViewController = [[VCMenu alloc] init]; // left viewcontroller
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:leftViewController]; // left
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;
    
    revealController.bounceBackOnOverdraw=NO;
    revealController.stableDragOnOverdraw=YES;
    self.viewController = revealController;
    
    [self addChildViewController:self.viewController];
    self.viewController.view.frame = self.view.bounds;
    [self.view addSubview:self.viewController.view];
}

#pragma mark - SWRevealViewDelegate

- (id <UIViewControllerAnimatedTransitioning>)revealController:(SWRevealViewController *)revealController animationControllerForOperation:(SWRevealControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ( operation != SWRevealControllerOperationReplaceRightController )
        return nil;
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
