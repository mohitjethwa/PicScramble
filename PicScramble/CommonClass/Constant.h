//
//  Constant.h
//  PicScramble
//
//  Created by Mohit Jethwa on 15/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#import <UIKit/UIKit.h>

/**
 Flip Type: It will cover all posible state for game.
 **/
typedef enum : NSUInteger {
    FlipStateImageShowUnPlayed = 0, // initial state for image
    FlipStateImageHiddenUnPlayed, // while playing state for hidden image
    FlipStateImageShowPlayed,  // state after played grid image
    FlipStateImageHiddenPlayed // after game over image hidden state
} FlipState;

// Number of images used for game 
#define kGameImageCount 9 
// placeholder image which will show untill image is not rendered from cache
#define kPlaceHolderImage [UIImage imageNamed:@"placeholder"]
// TimeOut for Request
#define MAX_TIME_TO_WAIT_FOR_IMAGE 120.0
// FLicker Public API url
#define kFlickerPublicAPI @"https://api.flickr.com/services/feeds/photos_public.gne"
#define kGridCollectionCellIdentifier @"GridImageCollection"


#endif /* Constant_h */
