//
//  MikesTVC.m
//  CustomTableViewCells
//
//  Created by Michael Kavouras on 9/24/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "MikesTVC.h"
#import "MikeInstagramPost.h"
#import "APIManager.h"
#import "InstagramPostTableViewCell.h"
#import "InstagramPostHeaderView.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "InstagramPostHeaderViewDelegate.h"
#import "SearchViewController.h"
#import "InstagramUserViewController.h"
#import "UIColor+InstagramBlueUIColor.h"

@interface MikesTVC () <InstagramPostHeaderViewDelegate>

@property (strong, nonatomic) NSMutableArray *searchResults;

@property (nonatomic) InstagramPostHeaderView *instagramPostHeaderView;

@end

@implementation MikesTVC

- (void)fetchInstagramData:(NSString *)searchTerm
              callbackBlock:(void(^)())block {
    
    // create an instagram url
    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=ac0ee52ebb154199bfabfb15b498c067", searchTerm];
    
    NSString *encodedString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // create an instagram url
    NSURL *instagramURL = [NSURL URLWithString:encodedString];
    NSString *myString = [instagramURL absoluteString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:myString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *results = responseObject[@"data"];
        
        // reset my array
        self.searchResults = [[NSMutableArray alloc] init];
        
        // loop through all json posts
        for (NSDictionary *result in results) {
            
            // create new post from json
            MikeInstagramPost *post = [[MikeInstagramPost alloc] initWithJSON:result];
            
            // add post to array
            [self.searchResults addObject:post];
        }
        
        [self.tableView reloadData];
        
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        block();
    }];
}


- (void)refresh:(UIRefreshControl *)refresh {
    [self fetchInstagramData:self.searchString callbackBlock:^{
        
    }];
    [refresh endRefreshing];
}






#pragma mark - LifeCycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tell the table view
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40.0;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // sell up pull to refresh
    UIRefreshControl *refresh = [UIRefreshControl new];
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    
    // grab and register nib for actual post/image/caption/likes
    UINib *nib = [UINib nibWithNibName:@"InstagramPostTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"InstagramCellIdentifier"];
    
    
    // grab and register nib for header identifier
    [self.tableView registerNib:[UINib nibWithNibName:@"InstagramPostHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"InstagramHeaderIdentifier"];
    
    self.navigationItem.title = @"Instagram";
    
    if(self.searchString){
        [self fetchInstagramData:self.searchString callbackBlock:^{
            
        }];
    }else {
        //TODO
    }
}


#pragma mark - IBActions



#pragma mark - Function

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    InstagramUserViewController *instagramUserViewController = segue.destinationViewController;
    instagramUserViewController.searchResult = self.searchResults;
}

#pragma mark - View Layout


#pragma mark - delegate 







- (void)instagramUserViewDidTapUsernameButton:(InstagramPostHeaderView *)view {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myController = [storyboard instantiateViewControllerWithIdentifier:@"practice"];
    
    [self presentViewController:myController animated:YES completion:nil];
}



- (void)didTapLabelWithGesture:(UITapGestureRecognizer *)tapGesture {
    [self performSegueWithIdentifier:@"showUser" sender:nil];
}

- (void)didTapAvatarImageViewWithGesture:(UITapGestureRecognizer *)tapGesture {
    [self performSegueWithIdentifier:@"showUser" sender:nil];
}











#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    InstagramPostHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"InstagramHeaderIdentifier"];
    
    
    headerView.usernameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapLabelWithGesture:)];
    [headerView.usernameLabel addGestureRecognizer:tapGesture];
    
    headerView.avatarImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *avatarImageViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAvatarImageViewWithGesture:)];
    [headerView.avatarImageView addGestureRecognizer:avatarImageViewTapGesture];
    
    
    // grabbing the post from our search results that corresponds
    // with the section
    MikeInstagramPost *post = self.searchResults[section];
    
    headerView.backgroundView = [[UIView alloc] initWithFrame:headerView.bounds];
    headerView.backgroundView.backgroundColor = [UIColor whiteColor];
    headerView.delegate = self;
    
    
    headerView.usernameLabel.text = post.username;
    headerView.usernameLabel.textColor = [UIColor instagramBlue];    headerView.avatarImageView.layer.cornerRadius = 21;
    headerView.avatarImageView.layer.masksToBounds = YES;
    headerView.avatarImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    headerView.avatarImageView.layer.borderWidth = 0.5;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, 0.5)];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [headerView addSubview:line];

    
    // create a url from the post avatarImageURL (originally a string)
    NSURL *avatarURL = [NSURL URLWithString:post.avatarImageURL];

    [headerView.avatarImageView sd_setImageWithURL:avatarURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        headerView.avatarImageView.image = image;
    }];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 75.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.searchResults.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InstagramPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstagramCellIdentifier" forIndexPath:indexPath];
    
    MikeInstagramPost *post = self.searchResults[indexPath.section];
    
    //cell.usernameLabel.text = [NSString stringWithFormat:@"@%@",post.username];
    
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%ld likes", post.likeCount];
    cell.likeCountLabel.textColor = [UIColor instagramBlue];
    
    // cell.tagCountLabel.text = [NSString stringWithFormat:@"Tags: %ld", post.tags.count];
    
    cell.captionLabel.text = post.caption[@"text"];
    

    NSURL *url = [NSURL URLWithString:post.imageURL];

    
    [cell.userMediaView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.userMediaView.image = image;
    }];
    
    return cell;
}





@end
