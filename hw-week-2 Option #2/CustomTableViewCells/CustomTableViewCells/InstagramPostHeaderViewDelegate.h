//
//  InstagramPostHeaderViewDelegate.h
//  CustomTableViewCells
//
//  Created by Eric Sze on 9/29/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InstagramPostHeaderView;

@protocol InstagramPostHeaderViewDelegate <NSObject>

- (void)instagramUserViewDidTapUsernameButton:(InstagramPostHeaderView *)view;

@end
