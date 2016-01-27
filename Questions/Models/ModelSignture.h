//
//  ModelSignture.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/30/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "BaseModel.h"
#import "QuestionModel.h"
#import "CustomCellSignture.h"

@interface ModelSignture : BaseModel
@property (nonatomic, strong) NSString *question_text;
@property (nonatomic, strong) UIImage *imageSignture;
@property (nonatomic, strong) CustomCellSignture *cell;
@end
