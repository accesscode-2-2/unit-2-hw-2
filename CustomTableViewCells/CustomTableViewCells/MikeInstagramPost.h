//
//  MikeInstagramPost.h
//  CustomTableViewCells
//
//  Created by Michael Kavouras on 9/24/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MikeInstagramPost : NSObject

@property (nonatomic) NSArray *tags;
@property (nonatomic) NSInteger commentCount;
@property (nonatomic) NSInteger likeCount;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *fullName;
@property (nonatomic) NSDictionary *caption;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) NSString *avatarImageURL;
@property (nonatomic) NSMutableArray <NSAttributedString *> *comments;

- (instancetype)initWithJSON:(NSDictionary *)json;









@end
