//
//  CommonMethods.h
//  PicScramble
//
//  Created by Mohit Jethwa on 16/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonMethods : NSObject

/**
   Check for Null Cases for Strings
   In Case of nil it will return empty string 
*/
+(id)nsNullHandlerForObject:(id)object;

/**
   Check for given range and generate between 0 to given max value
*/
+(NSInteger)randomNumberGeneratorWithMax:(u_int32_t)max;
/**
  This method will display alertView with given parameter message.
*/
+(void)showCustomAlert:(NSString *)message;
@end
