//
//  ViewController.m
//  hw-week-2
//
//  Created by Michael Kavouras on 9/28/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>
#import "venueObject.h"
#import "ResultTableViewCell.h"

@interface ViewController ()
<UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate,
CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSString *longitude;
@property (nonatomic) NSString *latitude;
@property (nonatomic) NSMutableArray *instagramSearchResult;
@property (nonatomic) NSMutableArray *foursquareSearchResult;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API Call

-(void)fetchInstagramData:(NSString *)searchTerm{
    
    searchTerm = [searchTerm stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *instagramUrlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=ac0ee52ebb154199bfabfb15b498c067", searchTerm];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:instagramUrlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *results = responseObject[@"data"];
        
        // reset my array
        self.instagramSearchResult = [[NSMutableArray alloc] init];
        
        // loop through all json posts
        for (NSDictionary *result in results) {
            
            // create new post from json
            venueObject *post = [[venueObject alloc] init];
            
            [post backgroundImage:result];
            
            // add post to array
            [self.instagramSearchResult addObject:post];
        }
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"Error. Try again.");
    }];
    
}

-(void)fetchFoursquareData:(NSString *)searchTerm{
    
    searchTerm = [searchTerm stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=X4MDWXJJASEHLRHXN4CTZNFPH5QF3YSREML5FFUPHNZEITAK&client_secret=VRXXFP3MEGC1PCMM2XRHXAQPIP5C2XEESW1UCCEHBGAZCO5O&v=20130815&ll=%@,%@&query=%@", self.latitude, self.longitude, searchTerm];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *results = responseObject[@"response"];
        NSArray *venues = results[@"venues"];
        
        // reset my array
        self.foursquareSearchResult = [[NSMutableArray alloc] init];
        
        // loop through all json posts
        for (NSDictionary *venue in venues) {
            
            // create new post from json
            venueObject *post = [[venueObject alloc] init];
            
            [post venueName:venue];
            
            NSLog(@"%@", post.venueName);
            // add post to array
            [self.foursquareSearchResult addObject:post];
        }
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"Error. Try again.");
    }];

}


#pragma mark - UI
- (void)refresh:(UIRefreshControl *)refreshControl {
    [refreshControl endRefreshing];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to get your location" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style: UIAlertActionStyleDefault handler:nil];
    
    [errorAlert addAction:okAction];
    
    [self presentViewController:errorAlert animated:true completion:nil];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = locations.firstObject;
    
    self.longitude = [NSString stringWithFormat:@"%.1f", location.coordinate.longitude];
    self.latitude = [NSString stringWithFormat:@"%.1f",location.coordinate.latitude];
    
    
}

#pragma mark - Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:true];
    
    [self fetchInstagramData:textField.text];
    [self fetchFoursquareData:textField.text];
    [self.tableView reloadData];
    
    return true;
}

#pragma mark - Table View Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.instagramSearchResult.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    venueObject *postWithVenueName = self.foursquareSearchResult[indexPath.row];
    venueObject *postWithImage = self.instagramSearchResult[indexPath.row];
    
    cell.venueName.text = postWithVenueName.venueName;
    
    NSURL *url = [NSURL URLWithString:postWithImage.backgroundImageString];
    
    [cell.backgroundImage sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.backgroundImage.image = image;
    }];
    
    
    
    
    
    return cell;
}



@end
