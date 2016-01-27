//
//  VCSignture.h
//  Questions
//
//  Created by Quach Ngoc Tam on 11/30/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SignatureView/SignatureView.h>

@interface VCSignture : UIViewController
@property (nonatomic, strong) SignatureView *signatureView;
@property (nonatomic, readwrite, copy) void(^didCompleteSignture)(UIImage *image);
@end
