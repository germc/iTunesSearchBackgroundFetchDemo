//
//  BJLAlbum.h
//  BackgroundFetch
//
//  Created by Bryan Luby on 10/5/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJLAlbum : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *artist;
@property (strong, nonatomic) UIImage *artwork;

// Designated Initializer
- (id)initWithAlbumDict:(NSDictionary *)albumDict;

@end
