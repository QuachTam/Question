//
//  CustomCellTimes.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/25/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWLabel.h"

typedef NS_ENUM(NSUInteger, typeFormat) {    // date and time format styles
    dateType,
    timesType
};

@interface CustomCellTimes : UITableViewCell
@property (weak, nonatomic) IBOutlet RWLabel *textQuestion;
@property (weak, nonatomic) IBOutlet UILabel *labelTimes;
@property (nonatomic, readwrite) NSInteger type;
@property (weak, nonatomic) IBOutlet UIImageView *imageRequire;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;
@property (weak, nonatomic) IBOutlet UIButton *buttonGetDate;
@property (nonatomic, copy, readwrite) void(^didCompleteGetTime) (NSString *stringDate);
- (IBAction)actionGetTimes:(id)sender;
- (void)setTitle;
@end
