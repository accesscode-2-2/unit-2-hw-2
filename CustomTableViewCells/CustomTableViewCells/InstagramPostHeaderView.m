//
//  InstagramPostHeaderView.m
//  CustomTableViewCells
//
//  Created by Michael Kavouras on 9/26/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "InstagramPostHeaderView.h"
#import "UIColor+Instagram.h"

@implementation InstagramPostHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.fullNameLabel setTextColor:[UIColor darkBlueColor]];
    [self.usernameLabel setTextColor:[[UIColor darkBlueColor] colorWithAlphaComponent:0.7]];
}

@end
