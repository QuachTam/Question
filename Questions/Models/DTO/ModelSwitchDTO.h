//
//  ModelSwitchDTO.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/30/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ModelSwitchDTO <NSObject>

@end
@interface ModelSwitchDTO : JSONModel
@property (nonatomic, strong) NSString *question_text;
@property (nonatomic, readwrite) NSNumber *isOn;
@end
