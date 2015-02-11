//
//  Stack.m
//  LocoReminders
//
//  Created by David Rogers on 2/3/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "Stack.h"

@implementation Stack

-(instancetype)init {
  self = [super init];
  if (self) {
    self.items = [[NSMutableArray alloc] init];
  }
  return self;
}

@end
