//
//  CustomCellImageView.m
//  Questions
//
//  Created by Quach Ngoc Tam on 11/24/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "CustomCellImageView.h"

@implementation CustomCellImageView
@synthesize imageView;
- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)takePhoto:(id)sender {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Take Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo", nil];
    [action showInView:self.contentView];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex!=2) {
        CameraObject *camera = [CameraObject shareInstance];
        camera.delegate = self;
        camera.supperView = self.supperView;
        if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Camera"]) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                camera.sourceType = UIImagePickerControllerSourceTypeCamera;
            }else{
                camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
        }else {
            camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        [camera showCamera];
    }
}

- (void)didFinishPickingMediaWithInfo:(UIImage *)image {
    self.imageView.image = image;
    if (self.didCompleteTakePhoto) {
        self.didCompleteTakePhoto(image);
    }
    
    [self layoutIfNeeded];
}

- (void)imagePickerControllerDidCancel{
    
}

@end
