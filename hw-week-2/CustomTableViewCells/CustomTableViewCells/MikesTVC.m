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
#import "UIColor+Instagram.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

NSString *const client_ID = @"ac0ee52ebb154199bfabfb15b498c067";

@interface MikesTVC () <UITextFieldDelegate>

@property (nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic) NSString *searchTerm;
@property (strong, nonatomic) IBOutlet UIView *searchView;

@end

@implementation MikesTVC

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *searchString = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.searchTerm = searchString;
    
    NSLog(@"search term: %@",searchString);
    
    [self fetchInstagramData:self.searchTerm];
    
    
    return textField;
}

- (void)fetchInstagramData:(NSString*)searchTerm {
    
    // create an instagram url
    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=%@",searchTerm, client_ID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlString
      parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
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
    
         } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
             NSLog(@"%@", error);
    
    }];
    
}

- (void)pulledToRefresh:(UIRefreshControl *)sender {
    [self fetchInstagramData:self.searchTerm];
    [sender endRefreshing];
    
    // sender == self.refreshControl
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self fetchInstagramData];
    
    self.searchTextField.delegate = self;
    [self.searchView setBackgroundColor:[UIColor darkBlueColor]];
    
    // set up pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pulledToRefresh:) forControlEvents:UIControlEventValueChanged];
    
    // tell the table view to auto adjust the height of each cell
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 12.0;
    
    // grab the nib from the main bundle
    UINib *nib = [UINib nibWithNibName:@"InstagramPostTableViewCell" bundle:nil];
    
    // register the nib for the cell identifer
    [self.tableView registerNib:nib forCellReuseIdentifier:@"InstagramCellIdentifier"];
 
    // grab the header nib from the main bundle
    UINib *headerNib = [UINib nibWithNibName:@"InstagramPostHeaderView" bundle:nil];

    
    // register the header nib for the header identifier
    [self.tableView registerNib:headerNib forHeaderFooterViewReuseIdentifier:@"InstagramHeaderIdentifier"];
    
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // dequeue the header view from the table view with InstagramHeaderIdentifier
    InstagramPostHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"InstagramHeaderIdentifier"];

    // grabbing the post from our search results that corresponds
    // with the section
    MikeInstagramPost *post = self.searchResults[section];
    
    // set the backgroundView and make it white
    headerView.backgroundView = [[UIView alloc] initWithFrame:headerView.bounds];
    headerView.backgroundView.backgroundColor = [UIColor whiteColor];
    
    // set the usernameLabel.text to the posts username;
    headerView.usernameLabel.text = [NSString stringWithFormat:@"@%@", post.username];
    headerView.fullNameLabel.text = post.fullName;
    
    // make the avatar a circle
    headerView.avatarImageView.layer.cornerRadius = 15.0;
    headerView.avatarImageView.layer.masksToBounds = YES;
    headerView.avatarImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    headerView.avatarImageView.layer.borderWidth = 0.5;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 0.5)];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [headerView addSubview:line];
    
    // create a url from the post avatartImageURL (originally a string)
    NSURL *avatarURL = [NSURL URLWithString:post.avatarImageURL];
    
    // using SDWebImage, load the avatar image into headerView.avatarImageView
    [headerView.avatarImageView sd_setImageWithURL:avatarURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        headerView.avatarImageView.image = image;
    }];
    
    // return the header view
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
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
    
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%ld", post.likeCount];
    [cell.likeCountLabel setTextColor:[UIColor darkBlueColor]];
    
    NSMutableAttributedString *commentsString = [[NSMutableAttributedString alloc] init];
    for (NSMutableAttributedString *comment in post.comments) {
        [commentsString appendAttributedString:comment];
    }
    cell.commentsLabel.attributedText = commentsString;

    
    NSURL *url = [NSURL URLWithString:post.imageURL];

    [cell.userMediaImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.userMediaImageView.image = image;
    }];
    
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
