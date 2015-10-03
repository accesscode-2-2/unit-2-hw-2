//
//  FirstViewController.h
//  googleApp
//
//  Created by Fatima Zenine Villanueva on 10/2/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraImageDelegate.h"

@interface FirstViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) UIImagePickerController *picker;

@property (weak, nonatomic) IBOutlet UIImageView *imageCameraImage;

@end
