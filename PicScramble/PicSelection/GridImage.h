//
//  GridImage.h
//  PicScramble
//
//  Created by Mohit Jethwa on 16/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GridImage : NSObject
// it will hold image unique id 
@property(nonatomic,retain) NSString *image_Id;
// it will hold image url 
@property(nonatomic,retain) NSString *image_Url; 
@property(nonatomic,retain) UIImage *imageObject;
// it will hold current flip state of GridImage
@property(nonatomic) FlipState flipState;

/**
  It will return flicker public API url 
*/
+(NSString *)flickerPublicAPIUrl;

/**
  This method will create Grid image object and also download image async. After downloading it will return instanceType object.
*/
+(void)initWithServerResponse:(NSDictionary *)serverResponse withGridImage:(void(^)(GridImage *gridImage))complete;
@end
