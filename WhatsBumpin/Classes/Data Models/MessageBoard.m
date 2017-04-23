//
//  MessageBoard.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/22/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "MessageBoard.h"
#import "Message.h"

@implementation MessageBoard

//TODO  Change script name
//      Change post string
//

- (instancetype)init {
    _messages = [[NSMutableArray alloc] init];
    return self;
}
-(void)loadMessagesFromFriends: (NSMutableArray *)friendIDs withCompletion:(void(^)(NSMutableArray* response))completion {
    NSString *postString = @"";
    for (NSString * fID in friendIDs) {
        postString = [postString stringByAppendingString:fID];
        postString = [postString stringByAppendingString:@"|"];
    }
    
    NSLog(@"postString: %@", postString);
    postString = @"1|2";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://52.14.0.153/api/get_messages_by_friends.php"]];
    [request setHTTPMethod:@"POST"];
    
    NSString *post = [[NSString alloc] initWithFormat:@"friends_facebook_ids=%@&submit=", postString]; ///change string to post string
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data
                              
                              options:kNilOptions
                              error:&error];
        
        NSLog(@"%@", [json objectForKey:@"error"]);
//        if(![json objectForKey:@"error"]){
//            NSLog(@"no error");
        NSLog(@"%@", NSStringFromClass([[json objectForKey:@"message_count"] class]));
            int messageCount = [(NSNumber *)[json objectForKey:@"message_count"] intValue];
        NSLog(@"MC %d", messageCount);
            for (int i = 0; i < messageCount; i++) {
                
                NSLog(@"asdf");
                Message *m = [self parseIntoMessage: [json objectForKey:[NSString stringWithFormat:@"%d", i]]];
                NSLog(@"%@", m);
                
                [self.messages addObject:m];
                NSLog(@"Count %lu", (unsigned long)self.messages.count);

            }
        NSLog(@"Count %lu", (unsigned long)self.messages.count);
            completion(self.messages);
        //}
        
        

        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"response %@", response);
        NSLog(@"data %@", dataString);
    }];

    [task resume];


}

-(Message *) parseIntoMessage: (NSArray *)data {
    Message *newMessage = [[Message alloc] init];
    newMessage.name = [data valueForKey:@"facebook_name"];
    newMessage.message_text = [data valueForKey:@"message_field"];
    newMessage.date = [data valueForKey:@"time_stamp"];
    newMessage.locationID = [data valueForKey:@"location_id"];
    
    return newMessage;
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
