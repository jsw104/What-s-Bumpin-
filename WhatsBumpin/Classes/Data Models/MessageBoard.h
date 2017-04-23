//
//  MessageBoard.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/22/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Message;

@interface MessageBoard : NSObject

@property (strong, nonatomic) NSMutableArray<Message *> *messages;

-(void)loadMessagesFromFriends: (NSMutableArray *)friendIDs withCompletion:(void(^)(NSMutableArray* response))completion;
-(void)loadMessagesForLocation: (NSString *) locationID withCompletion:(void(^)(NSMutableArray* response))completion;
@end
