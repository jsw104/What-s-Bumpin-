//
//  Message.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "Message.h"

@implementation Message

-(nullable id)initWithUserID: (long)facebook_id locationID:(NSString *) googlePlacesID andMessage: (NSString *)message
{
    self = [super init];
    if (self != nil)
    {
        self.facebook_id = facebook_id;
        self.googlePlacesID = googlePlacesID;
        self.date = [NSDate date];
        self.message_text = message;
    }
    return self;
}

-(void)saveInBackgroundWithCompletionBlock:(void (^)(BOOL success))completion
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://52.14.0.153/api/insert_message.php"]];
    [request setHTTPMethod:@"POST"];
    NSLog(@"facebook_id: %ld", self.facebook_id);
    NSLog(@"location_id: %@", self.googlePlacesID);
    NSString *post = [[NSString alloc] initWithFormat:@"facebook_id=%ld&location_id=%@&message_field=%@&submit=",self.facebook_id, self.googlePlacesID, self.message_text];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data
                              
                              options:kNilOptions
                              error:&error];
        NSLog(@"json %@", json);
        bool success = [[json objectForKey:@"error"] intValue] == 0;
        completion(success);
    }];
    
    [task resume];
}

@end
