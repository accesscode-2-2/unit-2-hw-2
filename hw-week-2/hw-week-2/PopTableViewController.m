//
//  PopTableViewController.m
//  hw-week-2
//
//  Created by Mesfin Bekele Mekonnen on 10/2/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "PopTableViewController.h"
#import "PopTableViewCell.h"
#import "PopDetailViewController.h"

@interface PopTableViewController ()

@property (nonatomic) NSArray *array;

@end

@implementation PopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"Facebook Like And Send",@"Wrong Password",@"Custom Transition",@"Cell Animation"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PopCellIdentifier" forIndexPath:indexPath];
    
    
    cell.textLabel.text = self.array[indexPath.row];
    
    return cell;
}

-(void)pushFBDetailViewController{
    UIStoryboard *storyboard = self.storyboard;
    PopDetailViewController *vc =  [storyboard instantiateViewControllerWithIdentifier:@"openFB"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushWrongPassViewController{
    PopDetailViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"openWrongPass"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushCustomTransition{
    PopDetailViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"customVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self pushFBDetailViewController];
            break;
        case 1:
            [self pushWrongPassViewController];
            break;
        case 2:
            [self pushCustomTransition];
            break;
            
        default:
            break;
    }
    
    
    
    
}

@end
