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
    
    self.searchResults = [NSMutableArray new];
    
    UINib *nib = [UINib nibWithNibName:@"ListingsTableViewCell" bundle:nil]; // grab nib from main bundle
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ListingsTableCellIdentifier"]; // register nib for cell identifier
    
        [self getLocation]; // get location
    
//    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude]; // save coordinates as strings
//        NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
//        
//        NSLog(@"*dLatitude : %@", latitude); // print strings
//        NSLog(@"*dLongitude : %@",longitude);
//    
//    self.myLatitude = latitude;
//    self.myLongitude = longitude;
    
        self.refreshControl = [[UIRefreshControl alloc] init]; // pull to refresh
        [self.refreshControl addTarget:self action:@selector(pulledToRefresh:) forControlEvents:UIControlEventValueChanged];
    
    }
    
    
    


#pragma mark - Foursquare Data

- (void)fetchFoursquareData {
    
    
}

#pragma mark - Location Data

-(void)getLocation {
    
    self.locationManager = [[CLLocationManager alloc] init]; // set up corelocation manager alert
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
   // self.locationManager.distanceFilter = kCLDistanceFilterNone;
   // [self.locationManager startUpdatingLocation];
    
    [self.locationManager requestLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
       NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *crnLoc = [locations lastObject];
    self.myLatitude = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
    self.myLongitude = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
    NSLog(@"%@", self.myLatitude);
    NSLog(@"%@", self.myLongitude);
    
    [FourSquareAPIManager searchFoursquarePlacesForTerm:@"pizza" location:crnLoc.coordinate completionHandler:^(id response, NSError *error) {
        
//        if (response != nil) {
//        
//            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response
//                                                                 options:0
//                                                                   error:nil];
//            NSLog(@"%@", json); 
//            
//            NSArray *venues = [[json objectForKey:@"response"] objectForKey:@"venues"];
//        
        
//       self.searchResults = response[@"response"][@"venues"];
        
        NSArray *venues = response[@"response"][@"venues"];
        
        for (NSDictionary *dictionary in venues) {
            FourSquarePost *post = [[FourSquarePost alloc]initWithJSON:dictionary];
            [self.searchResults addObject:post];
        }
        
        
        
        [self.tableView reloadData];
    }];
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
    
//    NSDictionary *myData = self.searchResults[indexPath.row];
    
    
   // NSLog(@"%@", myData);
   // NSLog(@"location... %@", [myData objectForKey:@"location"]);
//    NSLog(@"%@", [myData[@"location"][@"distance"] class]);
    
    cell.nameLabel.text = place.restaurantName;//[myData objectForKey:@"name"];
    
    // use the FourSquarePost object to get the location and distance
    
//    cell.distanceLabel.text = [[[myData objectForKey:@"location"] objectForKey:@"distance"] stringValue];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
