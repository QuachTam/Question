//
//  CustomCellSignture.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/25/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWLabel.h"

@interface CustomCellSignture : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageSignture;
@property (weak, nonatomic) IBOutlet UIImageView *imageRequire;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;
@property (weak, nonatomic) IBOutlet RWLabel *textQuestion;
@property (nonatomic, readwrite, copy) void(^didClickSignture)(CustomCellSignture *currentCell);
@end
