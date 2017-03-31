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
    return self;
}

- (void) bumpWithCompletionBlock:(void (^)(BOOL successful))completion
{
    NSString *post = [NSString stringWithFormat:@"Username=%@&Password=%@",@"username",@"password"];
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
}




@end
