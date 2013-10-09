//
//  BJLAlbum.m
//  BackgroundFetch
//
//  Created by Bryan Luby on 10/5/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import "BJLAlbum.h"

@implementation BJLAlbum

- (id)initWithAlbumDict:(NSDictionary *)albumDict
{
    self = [super init];
    if (self) {
        _title = albumDict[@"collectionName"];
        _artist = albumDict[@"artistName"];
        NSString *albumURLString = albumDict[@"artworkUrl100"];
        NSURL *albumURL = [NSURL URLWithString:albumURLString];
        NSData *imageData = [NSData dataWithContentsOfURL:albumURL];
        _artwork = [UIImage imageWithData:imageData];
    }
    return self;
}

@end
