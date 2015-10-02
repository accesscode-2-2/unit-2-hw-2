//
//  IoGMarquee.h
//  hw-week-2
//
//  Created by Jackie Meggesto on 9/29/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARQUEE_FONT_SIZE							16
#define MARQUEE_UPDATE_TIMER_INTERVAL				0.05		// Can be adjuted to change speed of the scroll
#define MARQUEE_SCROLL_X_DISTANCE					1			// Can be adjusted to change smoothness of the scroll
#define MARQUEE_LABEL_MARGIN						10			// Can be adjusted to change space between end of message and re-start of message

@interface IoGMarquee : UIScrollView

- (void)setupForMessage:(NSString *)marqueeMessage withBackgroundColor:(UIColor *)background andForegroundColor:(UIColor *)foreground;		// Sets up the Marquee to display the supplied text

@end