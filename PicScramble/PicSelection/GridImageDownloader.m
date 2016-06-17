//
//  GridImageDownloader.m
//  PicScramble
//
//  Created by Mohit Jethwa on 16/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import "GridImageDownloader.h"
#import "NetworkClass.h"
#import "GridImage.h"

@implementation GridImageDownloader
+(void)getGameImageDataFromFlicker:(void(^)(NSArray *responseObject,NSError *error, bool status))finalHandler {
    NSString *urlReq = [GridImage flickerPublicAPIUrl];
    [[NetworkClass sharedInstance] requestForURL:urlReq parameters:nil completion:^(BOOL status, id responseObj, NSError *error) {
        if (status) {
            NSArray *responseItems =  [responseObj valueForKeyPath:@"feed.entry"];
            NSMutableArray *resultedGridObjects = [NSMutableArray new];
            if ([responseItems isKindOfClass:[NSArray class]]){
                [responseItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx == kGameImageCount-1) {
                        *stop = YES;
                    }
                   [GridImage initWithServerResponse:obj withGridImage:^(GridImage *gridImage) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [resultedGridObjects addObject:gridImage];
                           if (resultedGridObjects.count == kGameImageCount){
                               finalHandler(resultedGridObjects,nil,YES);
                           }
                       });
                   }];
                }];

            }


        } else {
            finalHandler(nil, error,NO);
        }
    }];
} 

@end
