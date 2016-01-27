//
//  CustomCellImageView.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/24/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraObject.h"
#import "RWLabel.h"
#import "CustomCellCommon.h"

@interface CustomCellImageView : CustomCellCommon <CameraObjectDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet RWLabel *textQuestion;
@property (nonatomic, strong) UIViewController *supperView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageRequire;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;
@property (nonatomic, copy, readwrite) void(^didCompleteTakePhoto)(UIImage *image);
- (IBAction)takePhoto:(id)sender;
@end
