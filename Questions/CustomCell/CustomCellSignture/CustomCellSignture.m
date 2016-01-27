//
//  CustomCellSignture.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/25/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "CustomCellSignture.h"
#import "VCSignture.h"
#import <MZFormSheetController/MZFormSheetController.h>
#import "AppDelegate.h"

@implementation CustomCellSignture

- (void)awakeFromNib {
    // Initialization code
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.contentView addGestureRecognizer:singleTap];
}

- (void)imageTaped:(id)sender {
    if (self.didClickSignture) {
        self.didClickSignture(self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
