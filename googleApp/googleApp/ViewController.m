#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

@import GoogleMaps;

#import "ViewController.h"
#import "UserPinClass.h"
#import "PinManager.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>



@interface ViewController () <GMSPanoramaViewDelegate, CLLocationManagerDelegate, GMSMapViewDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic) double lat;
@property (nonatomic) double lng;
@property (weak, nonatomic) IBOutlet GMSMapView *googleMapView;
@property (nonatomic) NSMutableArray *allMyPins;

@end

@implementation ViewController {
    BOOL configured_;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"ViewDidLoad -- Lat: %f   Lng: %f", self.lat, self.lng);
    
    self.allMyPins = [[NSMutableArray alloc]init];
    
}

#pragma mark - GMSPanoramaDelegate

- (void) loadGoogleMap {
    // camera for the Google Map
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.lat
                                                            longitude:self.lng
                                                                 zoom:15];
    
    // animate to the location of the longitude and latitude
    [self.googleMapView animateToCameraPosition:camera];
    
    // add the self.googleMapView to the main view
    [self.view addSubview:self.googleMapView];
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations.lastObject;
    self.lng = location.coordinate.longitude;
    self.lat = location.coordinate.latitude;
    
    NSLog(@"Lat: %f   Lng: %f", self.lat, self.lng);
    
    if (self.lng != 0 && self.lat != 0){
        
        NSLog(@"run");
        [self loadGoogleMap];
    }
    
    [self.locationManager stopUpdatingLocation];
}

- (IBAction)dropPinButton:(UIButton *)sender {
    
    UserPinClass *object = [[UserPinClass alloc]init];
    
    object.latitude = [NSString stringWithFormat:@"%f", self.lat];
    object.longitude = [NSString stringWithFormat:@"%f", self.lng];
    
    NSMutableArray *pins = [PinManager sharedManager].pinsArray;
    
    [pins addObject:object];
    
    NSLog(@"Dropping a pin!");
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(self.lat, self.lng);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.snippet = [NSString stringWithFormat:@"Longitude: %f  Latitude: %f", self.lng, self.lat];
    marker.map = self.googleMapView;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    

    NSLog(@"Array pins: %@", pins);
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
