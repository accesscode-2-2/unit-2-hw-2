//
//  InstagramPostHeaderView.h
//  CustomTableViewCells
//
//  Created by Eric Sze on 9/26/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramPostHeaderViewDelegate.h"

@interface InstagramPostHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id <InstagramPostHeaderViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *usernameButton;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;


@end
