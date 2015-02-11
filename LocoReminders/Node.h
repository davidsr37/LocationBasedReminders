//
//  Node.h
//  LocoReminders
//
//  Created by David Rogers on 2/8/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (strong, nonatomic) Node *next;
@property (nonatomic) NSInteger data;

-(void)addNode:(Node*)node;

@end
