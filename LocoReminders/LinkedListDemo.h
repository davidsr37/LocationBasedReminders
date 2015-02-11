//
//  LinkedListDemo.h
//  LocoReminders
//
//  Created by David Rogers on 2/8/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface LinkedListDemo : NSObject

@property (strong, nonatomic) Node *head;
@property (strong, nonatomic) Node *tail;

-(void)insertValue:(NSInteger)value;


@end
