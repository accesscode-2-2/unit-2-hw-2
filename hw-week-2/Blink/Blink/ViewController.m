//
//  ViewController.m
//  Blink
//
//  Created by Jason Wang on 10/9/15.
//  Copyright © 2015 Jason Wang. All rights reserved.
//

#import "ViewController.h"

#import <MicroBlink/MicroBlink.h>

@interface ViewController () <PPScanDelegate>

@property (nonatomic, strong) NSString* rawOcrParserId;

@property (nonatomic, strong) NSString* priceParserId;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rawOcrParserId = @"Raw ocr";
    self.priceParserId = @"Price";
}


- (PPCoordinator *)coordinatorWithError:(NSError**)error {
    
    if ([PPCoordinator isScanningUnsupported:error]) {
        return nil;
    }

    PPSettings *settings = [[PPSettings alloc] init];
    settings.licenseSettings.licenseKey = @"E5WB3P5M-RJED46TC-7W3BCQ4C-IFURCQ4C-IFURCQ4C-IFURCQ4C-IFURCQ4C-JFR4L4ND";
    
    PPOcrRecognizerSettings *ocrRecognizerSettings = [[PPOcrRecognizerSettings alloc] init];
    
    [ocrRecognizerSettings addOcrParser:[[PPRawOcrParserFactory alloc] init] name:self.rawOcrParserId];
    
    [ocrRecognizerSettings addOcrParser:[[PPPriceOcrParserFactory alloc] init] name:self.priceParserId];
    
    [settings.scanSettings addRecognizerSettings:ocrRecognizerSettings];
    
    
    PPCoordinator *coordinator = [[PPCoordinator alloc] initWithSettings:settings];
    
    return coordinator;
}

- (IBAction)didTapScan:(id)sender {
    
    NSError *error;
    PPCoordinator *coordinator = [self coordinatorWithError:&error];
    
    if (coordinator == nil) {
        NSString *messageString = [error localizedDescription];
        [[[UIAlertView alloc] initWithTitle:@"Warning"
                                    message:messageString
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        
        return;
    }
    
    UIViewController<PPScanningViewController>* scanningViewController = [coordinator cameraViewControllerWithDelegate:self];
    
    [self presentViewController:scanningViewController animated:YES completion:nil];
}

#pragma mark - PPScanDelegate

- (void)scanningViewControllerUnauthorizedCamera:(UIViewController<PPScanningViewController> *)scanningViewController {
}

- (void)scanningViewController:(UIViewController<PPScanningViewController> *)scanningViewController
                  didFindError:(NSError *)error {
}

- (void)scanningViewControllerDidClose:(UIViewController<PPScanningViewController> *)scanningViewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scanningViewController:(UIViewController<PPScanningViewController> *)scanningViewController
              didOutputResults:(NSArray *)results {

    [scanningViewController pauseScanning];
    
    for (PPRecognizerResult* result in results) {
        
        if ([result isKindOfClass:[PPOcrRecognizerResult class]]) {
            PPOcrRecognizerResult* ocrRecognizerResult = (PPOcrRecognizerResult*)result;
            
            NSLog(@"OCR results are:");
            NSLog(@"Raw ocr: %@", [ocrRecognizerResult parsedResultForName:self.rawOcrParserId]);
            NSLog(@"Price: %@", [ocrRecognizerResult parsedResultForName:self.priceParserId]);
            
            PPOcrLayout* ocrLayout = [ocrRecognizerResult ocrLayout];
            NSLog(@"Dimensions of ocrLayout are %@", NSStringFromCGRect([ocrLayout box]));
        }
    };
    
    [scanningViewController resumeScanningAndResetState:NO];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
