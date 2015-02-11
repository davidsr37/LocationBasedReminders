//
//  LinkedListDemo.m
//  LocoReminders
//
//  Created by David Rogers on 2/8/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "LinkedListDemo.h"

@implementation LinkedListDemo

-(void)insertValue:(NSInteger)value {
  Node *node = [Node new];
  node.data = value;
  
  if (self.head == nil) {
    self.head = node;
    self.tail = node;
    
  } else {
    [self insertAtHead:node];
  }
}

-(void)insertAtHead:(Node*)node {
  node.next = self.head;
  self.head = node;
  
}

-(void)insertAtEnd:(Node*)node {
  [self.head addNode:node];
}

-(void)insertAtEndWithWhile:(Node *)node {
  Node *nextNode = self.head;
  while (nextNode.next != nil) {
    nextNode = nextNode.next;
  }
  nextNode.next = node;
}

@end
