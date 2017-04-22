//
//  MessageBoard.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/22/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "MessageBoard.h"

@implementation MessageBoard

//TODO  Change script name
//      Change post string
//
-(void)loadMessagesFromFriends: (NSMutableArray *)friendIDs {
    NSString *postString = @"";
    for (NSString * fID in friendIDs) {
        postString = [postString stringByAppendingString:fID];
        postString = [postString stringByAppendingString:@"|"];
    }
    
    NSLog(@"postString: %@", postString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://52.14.0.153/api/get_messages_by_friends.php"]];
    [request setHTTPMethod:@"POST"];
    
    NSString *post = [[NSString alloc] initWithFormat:@"friends_facebook_ids=%@&submit=", postString]; ///change string to post string
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"response %@", response);
        NSLog(@"data %@", dataString);
    }];

    [task resume];


}

-(void)loadMessagesForLocation: (NSString *) locationID {
    
    NSLog(@"Location ID: %@",locationID);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://52.14.0.153/api/get_messages.php"]];
    [request setHTTPMethod:@"POST"];
    
    NSString *post = [[NSString alloc] initWithFormat:@"location_id=%@&submit=", locationID]; ///change string to post string
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"data %@", dataString);
    }];
    
    [task resume];
    
    
}


@end
