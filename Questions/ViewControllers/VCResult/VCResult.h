//
//  VCResult.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/30/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCResult : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSString *stringResult;
@end
