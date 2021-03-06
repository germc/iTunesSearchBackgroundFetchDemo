//
//  BJLViewController.h
//  BackgroundFetch
//
//  Created by Bryan Luby on 10/5/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlbumFetchBlock)(BOOL didFetchAlbums);

@interface BJLViewController : UICollectionViewController

- (void)fetchInBackgroundWithCompletion:(AlbumFetchBlock)completion;

@end
