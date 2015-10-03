//
//  FirstViewController.m
//  googleApp
//
//  Created by Fatima Zenine Villanueva on 10/2/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "FirstViewController.h"
#import "CellFirstViewController.h"
#import "CameraImageDelegate.h"
#import "UserPinClass.h"
#import "PinManager.h"

@interface FirstViewController () <UITableViewDataSource, UITableViewDelegate, CameraImageDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *pins;
@property (nonatomic) UIImage *pinnedImage;
@property (nonatomic) NSMutableArray *imageContainer;
@property (nonatomic) BOOL imageCheck;

@end

@implementation FirstViewController

- (void)alertTheViewAboutCamera {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                   message:@"No camera found"
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    
    [alert show];
}

- (void) userHitsCameraButton:(NSString *)imageCamera {
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) {
        self.picker.delegate = self;
        self.picker.allowsEditing = YES;
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.picker
                           animated:YES
                         completion:NULL];
        NSLog(@"working camera");
    }
    
    
    else if ([UIImagePickerController isSourceTypeAvailable:
              UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.allowsEditing = NO;
        [self presentViewController:self.picker
                           animated:YES
                         completion:nil];
        NSLog(@"working photo album");
    }
    
    else {
        [self alertTheViewAboutCamera];
    }
    
}
- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void) viewWillDisappear:(BOOL)animated {
    self.imageCheck = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.picker = [[UIImagePickerController alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CellFirstViewController" bundle:nil] forCellReuseIdentifier:@"CellIdentifier"];
    
    self.pins = [PinManager sharedManager].pinsArray;
    
    NSLog(@"Pins Array: %@", self.pins);
    
    self.imageContainer = [[NSMutableArray alloc]init];
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)self.pins.count);
    return self.pins.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellFirstViewController *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    UserPinClass *pin = [self.pins objectAtIndex:indexPath.row];
    
    cell.delegate = self;
    cell.longitudeLabel.text = [NSString stringWithFormat:@"Longitude: %@", pin.longitude];
    cell.latitudeLabel.text = [NSString stringWithFormat:@"Latitude: %@", pin.latitude];
    
    if (self.imageCheck == YES){
        cell.selectedPinnedImage.image = [self.imageContainer objectAtIndex:indexPath.row];
        cell.selectedPinnedImage.layer.cornerRadius = cell.selectedPinnedImage.frame.size.width / 2;
        cell.selectedPinnedImage.clipsToBounds = YES;
        cell.selectedPinnedImage.layer.borderWidth = 3.0f;
        cell.selectedPinnedImage.layer.borderColor = [UIColor blackColor].CGColor;
        cell.selectedPinnedImage.layer.cornerRadius = 10.0f;
        cell.cameraButton.hidden = YES;
    }
    
    return cell;
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    self.pinnedImage = image;
    
    [self.imageContainer addObject:self.pinnedImage];
    
    NSLog(@"Images inside container: %@", self.imageContainer);
    
    self.imageCheck = YES;
    
    
    [self.tableView reloadData];
}



- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.pinnedImage = image;
    
    [self.imageContainer addObject:self.pinnedImage];
    
    NSLog(@"Images inside container: %@", self.imageContainer);
    
    self.imageCheck = YES;
    
    [self.tableView reloadData];
}

@end
