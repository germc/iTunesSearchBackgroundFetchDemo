//
//  BJLAlbumStore.m
//  BackgroundFetch
//
//  Created by Bryan Luby on 10/5/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import "BJLAlbumStore.h"

@interface BJLAlbumStore ()
@property (copy, nonatomic) NSArray *artistNameList;
@end

@implementation BJLAlbumStore

- (id)init
{
    self = [super init];
    if (self) {
        self.artistNameList = @[@"steely+dan", @"radiohead", @"rolling+stones", @"miles+davis", @"the+beatles",
                                @"nine+inch+nails", @"grateful+dead", @"madonna", @"bob+dylan"];
    }
    return self;
}

#pragma mark - Fetch iTunes Data

- (void)fetchAlbumsWithCompletion:(AlbumStoreCompletion)completion
{
    NSURL *randomArtistSearchURL = [self randomArtistSearchURL];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *dataError = nil;
        NSData *rawData = [NSData dataWithContentsOfURL:randomArtistSearchURL options:0 error:&dataError];
        
        if (!dataError) {
            NSError *jsonError = nil;
            id jsonResponse = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:&jsonError];
            if (!jsonError) { // Successfully parsed data into json
                NSArray *jsonArray = jsonResponse[@"results"];
                NSArray *parsedAlbumsArray = [self parsedAlbumArrayFromJsonArray:jsonArray];
                completion(parsedAlbumsArray, nil);
            } else { // Couldn't parse json
                NSLog(@"Json Error: %@", [jsonError localizedDescription]);
                completion(nil, jsonError);
            }
        } else { // Error reading NSData
            NSLog(@"Data Reading Error: %@", [dataError localizedDescription]);
            completion(nil, dataError);
        }
    });
}

#pragma mark - Helpers

- (NSURL *)randomArtistSearchURL
{
    NSUInteger randomArtistIndex = arc4random_uniform([self.artistNameList count]);
    NSString *randomArtistString = self.artistNameList[randomArtistIndex];
    NSString *artistSearchString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=music&entity=album&country=us&attribute=artistTerm&limit=25", randomArtistString];
    
    return [NSURL URLWithString:artistSearchString];
}

- (NSArray *)parsedAlbumArrayFromJsonArray:(NSArray *)jsonArray
{
    NSMutableArray *albumArray = [NSMutableArray arrayWithCapacity:[jsonArray count]];
    
    for (NSDictionary *albumDict in jsonArray) {
        BJLAlbum *newAlbum = [[BJLAlbum alloc] initWithAlbumDict:albumDict];
        [albumArray addObject:newAlbum];
    }
    
    return [albumArray copy];
}

@end
