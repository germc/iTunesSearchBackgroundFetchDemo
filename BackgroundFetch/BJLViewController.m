//
//  BJLViewController.m
//  BackgroundFetch
//
//  Created by Bryan Luby on 10/5/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import "BJLViewController.h"
#import "BJLAlbumCell.h"
#import "BJLAlbumStore.h"

@interface BJLViewController ()
@property (copy, nonatomic) NSArray *albums;
@property (strong, nonatomic) BJLAlbumStore *albumStore;
@end

@implementation BJLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.albumStore = [[BJLAlbumStore alloc] init];
}

#pragma mark - Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.albums count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BJLAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    BJLAlbum *album = self.albums[indexPath.item];
    cell.albumTitleLabel.text = album.title;
    cell.albumImageView.image = album.artwork;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
	UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
																			  withReuseIdentifier:@"header"
                                                                                     forIndexPath:indexPath];
    
	UILabel *artistLabel = (UILabel *)[headerView viewWithTag:25];
    BJLAlbum *album = [self.albums firstObject];
    NSString *artistTitle = album.artist;
    
    if (artistTitle) {
        artistLabel.text = [NSString stringWithFormat:@"%@\nFetched: %@", artistTitle, [NSDate date]];
    }
    
	return headerView;
}

#pragma mark - Background Fetch

- (void)fetchInBackgroundWithCompletion:(AlbumFetchBlock)completion
{
    __weak typeof(self)weakSelf = self;
    [self.albumStore fetchAlbumsWithCompletion:^(NSArray *albums, NSError *error) {
        if (!error) {
            __strong typeof(self)strongSelf = weakSelf;
            strongSelf.albums = albums;
            [strongSelf.collectionView reloadData];
            NSLog(@"Background fetch complete. Updating UI.");
            completion(YES);
        } else {
            completion(NO);
        }
    }];
}

@end
