//
//  MessageBoard.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/22/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "MessageBoard.h"

@implementation MessageBoard


-(void)loadMessagesFromFriends: (NSMutableArray *)friendIDs {
    NSString *postString = @"";
    for (NSString * fID in friendIDs) {
        postString = [postString stringByAppendingString:fID];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://52.14.0.153/api/get_messages.php"]];
    [request setHTTPMethod:@"POST"];
    
    NSString *post = [[NSString alloc] initWithFormat:@"location_id=%@&submit=", @"ChIJM5WTlIT7MIgRZXbXABw3OQw"]; ///change string to post string 
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"data %@", dataString);
    }];

    [task resume];


}

@end
