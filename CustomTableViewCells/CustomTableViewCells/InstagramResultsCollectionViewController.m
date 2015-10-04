//
//  InstagramResultsCollectionViewController.m
//  
//
//  Created by Jamaal Sedayao on 9/30/15.
//
//

#import "InstagramResultsCollectionViewController.h"

NSString *const newClient_ID = @"ac0ee52ebb154199bfabfb15b498c067";

@interface InstagramResultsCollectionViewController ()
<
UITextFieldDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic) NSString *searchTerm;
@property (nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation InstagramResultsCollectionViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *searchString = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.searchTerm = searchString;
    
    NSLog(@"search term: %@",searchString);
    
    [self fetchInstagramData:self.searchTerm];
    
    
    return textField;
}

- (void)fetchInstagramData:(NSString*)searchTerm {
    
    // create an instagram url
    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=%@",searchTerm, newClient_ID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlString
      parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             NSArray *results = responseObject[@"data"];
             
             NSLog (@"%@", results);
             // reset my array
             self.searchResults = [[NSMutableArray alloc] init];
             
             // loop through all json posts
             for (NSDictionary *result in results) {
                 
                 // create new post from json
                 MikeInstagramPost *post = [[MikeInstagramPost alloc] initWithJSON:result];
                 
                 // add post to array
                 [self.searchResults addObject:post];
             }
             
             [self.collectionView reloadData];
             
         } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
             NSLog(@"%@", error);
             
         }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchView.backgroundColor = [UIColor darkBlueColor];
    self.searchTextField.delegate = self;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
  // self.searchTextField.t;

}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"InstagramCell" forIndexPath:indexPath];
   // cell.backgroundColor = [UIColor blackColor];
    
    MikeInstagramPost *post = self.searchResults[indexPath.row];
    
    UIImageView *instaImageView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    
    //(UIImageView *)[cell viewWithTag:100];
    
    NSURL *url = [NSURL URLWithString:post.imageURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    instaImageView.image = [UIImage imageWithData:data];
    
    [cell.contentView addSubview:instaImageView];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


@end
