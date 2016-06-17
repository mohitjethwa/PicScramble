//
//  NetworkClass.m
//  PicScramble
//
//  Created by Mohit Jethwa on 16/06/16.
//  Copyright © 2016 Mohit Jethwa. All rights reserved.
//

#import "NetworkClass.h"
#import <SHXMLParser/SHXMLParser.h>

@implementation NetworkClass

+(NetworkClass *)sharedInstance {
    static NetworkClass *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkClass alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}
-(void)checkReachabilityWithResult:(void(^)(BOOL isReachable))result{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];

    NSURL *url = [NSURL URLWithString:@"http://www.google.com/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"HEAD";
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    request.timeoutInterval = 10.0;

    NSError *error = nil;
    if (!error) {
        NSURLSessionDataTask *downloadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            result([(NSHTTPURLResponse *)response statusCode] == 200);
        }];
        [downloadTask resume];
    }
}
-(void)requestForURL:(NSString *)url parameters:(NSDictionary *)param completion:(void(^)(BOOL status,id responseObj, NSError *error))complete {
    [[NetworkClass sharedInstance] checkReachabilityWithResult:^(BOOL isReachable) {
        if (isReachable){
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:config];

            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            request.HTTPMethod = @"GET";
            NSError *error = nil;
            if (!error) {
                NSURLSessionDataTask *downloadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    if (!error) {
                        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;

                        if (httpResp.statusCode == 200) {

                            SHXMLParser *parser = [[SHXMLParser alloc] init];
                            NSDictionary *resultObject = [parser parseData:data];
                            complete(YES, resultObject,nil);
                        } else {
                            complete(NO, nil,error);
                        }
                    }

                }];
                [downloadTask resume];
            }
        } else {
            complete(NO, nil,nil);
        }
    }];
}

@end
