//
//  Bump.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "Bump.h"

@implementation Bump

-(nullable id)initWithUsername: (int)user_id locationWithID:(NSString *) googlePlacesID
{
    self = [super init];
    if (self != nil)
    {
        self.user_id = user_id;
        self.googlePlacesID = googlePlacesID;
        self.date = [NSDate date];
    }
    [self postBump];
    return self;
}

/*- (void) bumpWithCompletionBlock:(void (^)(BOOL successful))completion
{
    NSString *post = [NSString stringWithFormat:@"user_id=%d&location_id=%@",self.user_id,self.googlePlacesID];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"52.14.0.153/api/insert_bump.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: [request URL]];
        NSLog(@"hi");
    });
}*/

-(void) postBump {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://52.14.0.153/api/insert_bump.php"]];
    [request setHTTPMethod:@"POST"];
    NSLog(@"user_id: %d", self.user_id);
    NSLog(@"location_id: %@", self.googlePlacesID);
    NSString *post = [[NSString alloc] initWithFormat:@"user_id=%d&location_id=%@&submit=",self.user_id, self.googlePlacesID];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"response: %@, err %@", response, error);
    }];
    
    [task resume];
}




@end
