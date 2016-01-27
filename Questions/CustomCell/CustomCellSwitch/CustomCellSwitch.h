//
//  CustomCellSwitch.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/25/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWLabel.h"

@interface CustomCellSwitch : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageRequire;
@property (weak, nonatomic) IBOutlet RWLabel *textQuestion;
@property (weak, nonatomic) IBOutlet UISwitch *statusSwitch;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;
- (IBAction)actionSwitch:(id)sender;
@property (nonatomic, readwrite, copy) void(^didChangeValue)(BOOL isOn);
@end
