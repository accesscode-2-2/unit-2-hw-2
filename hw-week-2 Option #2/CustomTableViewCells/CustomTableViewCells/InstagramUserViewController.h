//
//  InstagramUserViewController.h
//  CustomTableViewCells
//
//  Created by Eric Sze on 10/2/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstagramUserViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *searchResult;

@end
