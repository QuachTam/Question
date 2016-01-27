//
//  ModelLocation.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/26/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "BaseModel.h"
#import "QuestionModel.h"

@interface ModelLocation : BaseModel
@property (nonatomic, strong) NSString *question_text;
@property (weak, nonatomic)  NSString *address;
@property (weak, nonatomic)  NSString *stringLong;
@property (weak, nonatomic)  NSString *stringLat;

@end
