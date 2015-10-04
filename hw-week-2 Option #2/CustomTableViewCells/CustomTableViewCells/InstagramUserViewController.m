//
//  InstagramUserViewController.m
//  CustomTableViewCells
//
//  Created by Eric Sze on 10/2/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "InstagramUserViewController.h"
#import "InstagramUserCollectionViewCell.h"
#import "MikeInstagramPost.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface InstagramUserViewController ()

@property (nonatomic) InstagramUserCollectionViewCell *instagramUserCollectionViewCell;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@end

@implementation InstagramUserViewController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"InstagramUserCollectionViewCell" owner:self options:nil];
//    self.instagramUserCollectionViewCell = [views firstObject];
//    
//    [self.collectionView addSubview:self.instagramUserCollectionViewCell];
//    self.instagramUserCollectionViewCell.frame = self.collectionView.bounds;
    
    UINib *nib = [UINib nibWithNibName:@"InstagramUserCollectionViewCell" bundle: nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

//    [self.collectionView registerNib:[UINib nibWithNibName:@"InstagramUserCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.flowLayout setItemSize:CGSizeMake(screenWidth * 0.33, screenWidth * 0.33)];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.flowLayout.minimumInteritemSpacing = 0.0f;
    self.flowLayout.minimumLineSpacing = 0.005 * screenWidth;
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    self.collectionView.bounces = YES;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
    [self.collectionView reloadData];

}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchResult.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    InstagramUserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell

    
//    NSString *identifier = @"Cell";
//    
//    static BOOL nibMyCellloaded = NO;
//    
//    if(!nibMyCellloaded)
//    {
//        UINib *nib = [UINib nibWithNibName:@"Cell" bundle: nil];
//        [self.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
//        nibMyCellloaded = YES;
//    }

    MikeInstagramPost *post = self.searchResult[indexPath.row];
    
    //cell.usernameLabel.text = [NSString stringWithFormat:@"@%@",post.username];
    
    NSURL *url = [NSURL URLWithString:post.imageURL];
    
    [cell.userMediaView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.userMediaView.image = image;
    
    }];
    
    return cell;
}
     


//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
