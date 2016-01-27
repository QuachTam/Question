//
//  ModelSigntureDTO.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/30/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ModelSigntureDTO <NSObject>

@end
@interface ModelSigntureDTO : JSONModel
@property (nonatomic, strong) NSString <Optional> *question_text;
@property (nonatomic, strong) NSString <Optional> *imageSigntureString;
@end
