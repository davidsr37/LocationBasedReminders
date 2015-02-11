//
//  Node.m
//  LocoReminders
//
//  Created by David Rogers on 2/8/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "Node.h"

@implementation Node

-(void)addNode:(Node *)node {
  if (self.next == nil) {
    self.next = node;
    
  } else {
    [self.next addNode:node];
  }
}

@end
