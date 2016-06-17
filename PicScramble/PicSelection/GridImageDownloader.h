//
//  GridImageDownloader.h
//  PicScramble
//
//  Created by Mohit Jethwa on 16/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GridImageDownloader : NSObject

/**
  This method will first get XML data to Objective-c Collection type from flicker server. After that from response it will create Grid Image Object with image download async wise.
*/
+(void)getGameImageDataFromFlicker:(void(^)(NSArray *responseObject,NSError *error, bool status))finalHandler;
@end
