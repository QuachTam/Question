//
//  FormQuestionTextView.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/24/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWLabel.h"
#import "CustomCellCommon.h"

@interface FormQuestionTextView : CustomCellCommon <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet RWLabel *question;
@property (weak, nonatomic) IBOutlet UITextView *textViewAnswer;
@property (weak, nonatomic) IBOutlet UIImageView *imageRequire;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;

@property (nonatomic, readwrite, copy) void(^didChangeEditTextView)(NSString *text);
@end
