//
//  DetailViewController.h
//  hw-week-2
//
//  Created by Brian Blanco on 10/2/15.
//  Copyright © 2015 Brian Blanco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

