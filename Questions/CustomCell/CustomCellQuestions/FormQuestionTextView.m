//
//  FormQuestionTextView.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/24/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "FormQuestionTextView.h"
#import "Common.h"

@implementation FormQuestionTextView

- (void)awakeFromNib {
    // Initialization code
    self.textViewAnswer.delegate = self;
    self.textViewAnswer.layer.borderColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0].CGColor;
    self.textViewAnswer.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.didChangeEditTextView) {
        self.didChangeEditTextView (textView.text);
    }
}

@end
