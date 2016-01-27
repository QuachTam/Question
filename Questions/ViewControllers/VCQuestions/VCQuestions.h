//
//  VCQuestions.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/23/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface VCQuestions : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (nonatomic, strong) NSString *textSection;
@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;
- (IBAction)actionSubmit:(id)sender;

@end
