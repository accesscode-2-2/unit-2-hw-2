//
//  InstagramUserCollectionViewCell.m
//  CustomTableViewCells
//
//  Created by Eric Sze on 10/2/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "InstagramUserCollectionViewCell.h"

@implementation InstagramUserCollectionViewCell

- (void)awakeFromNib {
    
    
    // background color
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView = bgView;
    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    
    
    // selected background
    UIView *selectedView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView = selectedView;
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink"]];
    
}


@end
