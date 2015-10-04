//
//  MikeInstagramPost.m
//  CustomTableViewCells
//
//  Created by Michael Kavouras on 9/24/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MikeInstagramPost.h"
#import "UIColor+Instagram.h"

@implementation MikeInstagramPost

- (instancetype)initWithJSON:(NSDictionary *)json {
    
    if (self = [super init]) {
        
        self.tags = json[@"tags"];
        self.commentCount = [json[@"comments"][@"count"] integerValue];
        self.likeCount = [json[@"likes"][@"count"] integerValue];
        self.caption = json[@"caption"];
        self.username = json[@"user"][@"username"];
        self.fullName = json[@"user"][@"full_name"];
        self.imageURL = json[@"images"][@"standard_resolution"][@"url"];
        
        self.avatarImageURL = json[@"user"][@"profile_picture"];
        
        self.comments = [[NSMutableArray alloc] init];
        if (json[@"caption"]) {
            [self.comments addObject:[self parseComment:json[@"caption"]]];
        }
        
        for (NSDictionary *comment in json[@"comments"][@"data"]) {
            [self.comments addObject:[self parseComment:comment]];
        }
        
        return self;
    }
    return nil;
}

- (NSMutableAttributedString *)parseComment:(NSDictionary *)json {
    NSString *fromUsername = json[@"from"][@"username"];
    NSString *text = json[@"text"];
    
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ \n\n", fromUsername, text]];
    
    UIFont *font = [UIFont systemFontOfSize:13];
    [resultString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, resultString.length)];

    
    UIFont *mediumFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    [resultString addAttribute:NSFontAttributeName value:mediumFont range:NSMakeRange(0, fromUsername.length)];
    [resultString addAttribute:NSForegroundColorAttributeName value:[UIColor darkBlueColor] range:NSMakeRange(0, fromUsername.length)];
    
    return resultString;
}







@end
