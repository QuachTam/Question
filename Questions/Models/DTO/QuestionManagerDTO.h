//
//  QuestionManagerDTO.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/30/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ModelTextDTO.h"
#import "ModelLocationDTO.h"
#import "ModelChooseDTO.h"
#import "ModelImageDTO.h"
#import "ModelDateDTO.h"
#import "ModelTimesDTO.h"
#import "ModelSwitchDTO.h"
#import "ModelSigntureDTO.h"

@interface QuestionManagerDTO : JSONModel
@property (nonatomic, strong) NSArray<Optional, ModelTextDTO, ModelLocationDTO, ModelChooseDTO, ModelImageDTO, ModelDateDTO, ModelTimesDTO, ModelSwitchDTO, ModelSigntureDTO> *typeModels;
@end
