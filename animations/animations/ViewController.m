//
//  ViewController.m
//  animations
//
//  Created by Henna on 10/2/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "ViewController.h"
#import <POP/POP.h>
#import "Colours.h"

@interface ViewController ()
@property (nonatomic) NSArray * colors;
@property (nonatomic) BOOL direction;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor * color = [UIColor seafoamColor];
    self.colors = [color colorSchemeOfType:ColorSchemeComplementary];
    self.direction = YES;
//    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
//    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 50, 50)];
//    anim.springBounciness = 20;
//    [self.squareView.layer pop_addAnimation:anim forKey:@"size"];

}

-(void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
    //drawCircles *obj = [[drawCircles alloc]init];
    //---get all touches on the screen---
    NSSet *allTouches = [event allTouches];
    
    //---compare the number of touches on the screen---
    switch ([allTouches count])
    {
            //---single touch---
        case 1: {
            
            //---get info of the touch---
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
            CGPoint point = [touch locationInView:self.view];
            NSLog(@"x=%f", point.x);
            NSLog(@"y=%f", point.y);
            CGRect circlePoint = CGRectMake(point.x, point.y, 25.0, 25.0);
            
            UIView *view = [[UIView alloc] initWithFrame:circlePoint];
            [view.layer setCornerRadius:(25/2)];
            int index = random() % 4;
            [view setBackgroundColor: [self.colors objectAtIndex: index] ];
            
            [self.view addSubview:view];
            POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
            anim.toValue = [NSValue valueWithCGRect:CGRectMake(point.x, point.y, 50, 50)];
            anim.springBounciness = 20;
            [view.layer pop_addAnimation:anim forKey:@"size"];
            
            [UIView animateWithDuration:1.5f animations:^{
                if (self.direction){
                    view.frame = CGRectOffset(view.frame, 0, self.view.bounds.size.height - view.frame.origin.y);
                    self.direction = NO;
                }else{
                    view.frame = CGRectOffset(view.frame, self.view.bounds.size.height-view.frame.origin.x, 0);
                    self.direction= YES;
                }
                
                
            }];
            
            NSTimeInterval delay = 1.0;
            [self performSelector:@selector(removeView:) withObject:view afterDelay:delay];
            
//            obj.myPoint = point;
//            CGRect circlePoint = CGRectMake(obj.myPoint.x, obj.myPoint.y, 25.0, 25.0);
//            [obj drawRect:circlePoint];
        }  break;
    }
}

- (void) removeView: (UIView*) view{
    [view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
