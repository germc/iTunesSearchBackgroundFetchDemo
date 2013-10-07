//
//  BJLAlbumStore.h
//  BackgroundFetch
//
//  Created by Bryan Luby on 10/5/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJLAlbum.h"

typedef void(^AlbumStoreCompletion)(NSArray *albums, NSError *error);

@interface BJLAlbumStore : NSObject

- (void)fetchAlbumsWithCompletion:(AlbumStoreCompletion)completion;

@end
