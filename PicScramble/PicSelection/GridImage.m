//
//  GridImage.m
//  PicScramble
//
//  Created by Mohit Jethwa on 16/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import "GridImage.h"
#import "GridImageDownloader.h"
@implementation GridImage

+(NSString *)flickerPublicAPIUrl {
    return kFlickerPublicAPI;
}
#pragma mark - Setup instance object
+(void)initWithServerResponse:(NSDictionary *)serverResponse withGridImage:(void(^)(GridImage *gridImage))complete{
    GridImage *grid = [GridImage new];
    if (grid) {
        [grid setImage_Id:[CommonMethods nsNullHandlerForObject:[serverResponse valueForKey:@"id"]]];
        if ([[serverResponse valueForKey:@"link"] isKindOfClass:[NSArray class]]){
            NSDictionary *lastObject = [[serverResponse valueForKey:@"link"] lastObject];
            [grid setImage_Url:[CommonMethods nsNullHandlerForObject:[lastObject valueForKeyPath:@"href"]]];
        }
        [grid setFlipState:FlipStateImageShowUnPlayed];
        [grid addImageInCache:grid.image_Url withGridImage:complete];
    }
}
#pragma mark - Download image
-(void)addImageInCache:(NSString *)url withGridImage:(void(^)(GridImage *gridImage))complete{
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:[NSURL URLWithString:url]
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                // progression tracking code
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               if (image && finished) {
                                   // do something with image

                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       self.imageObject = image;
                                       complete(self);
                                   });
                               }
                           }];
}
@end
