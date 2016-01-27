//
//  CustomCellTimes.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/25/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "CustomCellTimes.h"

@implementation CustomCellTimes

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle{
    if (self.type == timesType) {
        [self.buttonGetDate setTitle:@"Get current times" forState:UIControlStateNormal];
    }else{
        [self.buttonGetDate setTitle:@"Get current date" forState:UIControlStateNormal];
    }
}

- (IBAction)actionGetTimes:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (self.type == timesType) {
        [formatter setDateFormat: @"HH:mm:ss"];
    }else{
        [formatter setDateFormat: @"yyyy-MM-dd"];
    }
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    self.labelTimes.text = stringFromDate;
    if (self.didCompleteGetTime) {
        self.didCompleteGetTime(self.labelTimes.text);
    }
}
@end
