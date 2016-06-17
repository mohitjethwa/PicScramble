//
//  NetworkClass.h
//  PicScramble
//
//  Created by Mohit Jethwa on 16/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkClass : NSObject

/**
   Create shared instance of NetworkClass which is responsible for getting data from server.
*/
+(instancetype)sharedInstance;
/**
  This method will perform task for passed url with given parameters. Once request will complete, completion handler will gives all required information.  
*/
-(void)requestForURL:(NSString *)url parameters:(NSDictionary *)param completion:(void(^)(BOOL status,id responseObj, NSError *error))complete;

@end
