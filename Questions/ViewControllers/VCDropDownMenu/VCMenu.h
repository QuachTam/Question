//
//  VCDropDownMenu.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/23/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface VCMenu : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (nonatomic, readwrite) NSInteger currentRow;
@end
