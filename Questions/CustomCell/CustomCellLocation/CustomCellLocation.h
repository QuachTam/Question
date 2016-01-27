//
//  CustomCellLocation.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/25/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWLabel.h"
#import "CustomCellCommon.h"

@interface CustomCellLocation : CustomCellCommon
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *stringLong;
@property (weak, nonatomic) IBOutlet UILabel *stringLat;
@property (weak, nonatomic) IBOutlet RWLabel *textQuestion;
@property (weak, nonatomic) IBOutlet UIImageView *imageRequire;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;

@property (nonatomic, copy, readwrite) void(^didClickGetCurrentLocation)(NSString *currentLat, NSString *currentLong, NSString *address);
- (IBAction)actionGetLocation:(id)sender;

@end
