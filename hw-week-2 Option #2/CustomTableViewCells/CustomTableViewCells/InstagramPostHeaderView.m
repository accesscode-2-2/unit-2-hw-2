//
//  InstagramPostHeaderView.m
//  CustomTableViewCells
//
//  Created by Eric Sze on 9/26/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "InstagramPostHeaderView.h"

@implementation InstagramPostHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)buttonToSegueToVC:(id)sender {
    [self.delegate instagramUserViewDidTapUsernameButton:self];
}

@end
