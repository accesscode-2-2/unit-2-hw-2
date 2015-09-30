//
//  ListingsTableViewController.m
//  hw-week-2
//
//  Created by Shena Yoshida on 9/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "ListingsTableViewController.h"
#import "ListingsTableViewCell.h"
#import "FourSquareAPIManager.h"
#import "FourSquarePost.h"

#import <AFNetworking/AFNetworking.h>
#import <CoreLocation/CoreLocation.h>

@interface ListingsTableViewController () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSString *myLatitude;
@property (nonatomic) NSString *myLongitude;
@property (nonatomic) NSMutableArray *searchResults;

@end

@implementation ListingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"ListingsTableViewCell" bundle:nil]; // grab nib from main bundle
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ListingsTableCellIdentifier"]; // register nib for cell identifier
    
    [self fetchFoursquareData];
    
        CLLocationCoordinate2D coordinate = [self getLocation]; // get location
        NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude]; // save coordinates as strings
        NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
        
        NSLog(@"*dLatitude : %@", latitude); // print strings
        NSLog(@"*dLongitude : %@",longitude);
    
    self.myLatitude = latitude;
    self.myLongitude = longitude;
    
        self.refreshControl = [[UIRefreshControl alloc] init]; // pull to refresh
        [self.refreshControl addTarget:self action:@selector(pulledToRefresh:) forControlEvents:UIControlEventValueChanged];
    
    }
    
    
    


#pragma mark - Foursquare Data

- (void)fetchFoursquareData {
    
    // call foursquare API manager - how to include longitude and latitude?
    
}

#pragma mark - Location Data

-(CLLocationCoordinate2D) getLocation{
    
    self.locationManager = [[CLLocationManager alloc] init]; // allocate memory to locationmanager
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) { // if premission has not been granted to access location
        [self.locationManager requestWhenInUseAuthorization]; // request premission
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    CLLocation *location = [self.locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}

#pragma  mark - pull to refresh

- (void)pulledToRefresh:(UIRefreshControl *)sender {
    [self fetchFoursquareData];
    [sender endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.searchResults.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListingsTableCellIdentifier" forIndexPath:indexPath];
    
    FourSquarePost *place = self.searchResults[indexPath.section];
    cell.nameLabel.text = place.restaurantName;
    cell.distanceLabel.text = place.restaurantDistance;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
