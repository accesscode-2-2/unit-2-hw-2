//
//  InstagramUserViewController.m
//  CustomTableViewCells
//
//  Created by Eric Sze on 10/2/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "InstagramUserViewController.h"
#import "InstagramUserCollectionViewCell.h"

@interface InstagramUserViewController ()

@property (nonatomic) InstagramUserCollectionViewCell *instagramUserCollectionViewCell;

@end

@implementation InstagramUserViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"InstagramUserCollectionViewCell" owner:self options:nil];
    self.instagramUserCollectionViewCell = [views firstObject];
    
    [self.collectionView addSubview:self.instagramUserCollectionViewCell];
    self.instagramUserCollectionViewCell.frame = self.collectionView.bounds;

//    [self.collectionView registerNib:[UINib nibWithNibName:@"InstagramUserCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
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

    cell.textLabel.text = [NSString stringWithFormat:@"%li", (long)indexPath.row + 1];
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
