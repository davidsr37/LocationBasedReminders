//
//  WatchMapVC.m
//  LocoReminders
//
//  Created by David Rogers on 2/10/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "WatchMapVC.h"

@interface WatchMapVC ()

@property (weak, nonatomic) IBOutlet WKInterfaceMap *mapView;

@end

@implementation WatchMapVC

- (void)awakeWithContext:(id)context {
  
    [super awakeWithContext:context];
  
  CLCircularRegion *region = (CLCircularRegion *) context;
  MKCoordinateSpan span = MKCoordinateSpanMake(0.037, 0.037);
  
  MKCoordinateRegion mapRegion = MKCoordinateRegionMake(region.center, span);
  
  [self.mapView setRegion:mapRegion];
}

-(void)willActivate {
  
  [super willActivate];
  
}

-(void)didDeactivate {
  
  [super didDeactivate];
  
}

@end
