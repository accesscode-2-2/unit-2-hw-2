//
//  InstagramUserViewController.m
//  CustomTableViewCells
//
//  Created by Eric Sze on 10/1/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "InstagramUserViewController.h"
#import "InstagramUserCollectionViewController.h"

@interface InstagramUserViewController ()
@property (weak, nonatomic) IBOutlet UIView *collectionView;
@property (nonatomic) InstagramUserCollectionViewController *InstagramUserCollectionViewController;

@end

@implementation InstagramUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
//    self.InstagramUserCollectionViewController = [views firstObject];
//    [self.collectionView addSubview:self.InstagramUserCollectionViewController];
//    
//    
}

@end
