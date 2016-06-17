//
//  CommonMethods.m
//  PicScramble
//
//  Created by Mohit Jethwa on 16/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import "CommonMethods.h"

@implementation CommonMethods
+(id)nsNullHandlerForObject:(id)object{
    if ([object isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return object;
}
+(NSInteger)randomNumberGeneratorWithMax:(u_int32_t)max {
    NSInteger randNum = arc4random_uniform(max); //create the random number.
    return randNum;
}

+(void)showCustomAlert:(NSString *)message{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    [alert show];
}
@end
