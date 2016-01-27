//
//  ModelLocationDTO.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/30/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ModelLocationDTO <NSObject>

@end
@interface ModelLocationDTO : JSONModel
@property (nonatomic, strong) NSString <Optional> *question_text;
@property (weak, nonatomic)  NSString <Optional> *address;
@property (weak, nonatomic)  NSString <Optional> *stringLong;
@property (weak, nonatomic)  NSString <Optional> *stringLat;
@end
