//
//  CustomCellSwitch.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/25/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "CustomCellSwitch.h"

@implementation CustomCellSwitch

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionSwitch:(id)sender {
    UISwitch *switchObject = (UISwitch *)sender;
    if (self.didChangeValue) {
        self.didChangeValue (switchObject.isOn);
    }
}

@end
