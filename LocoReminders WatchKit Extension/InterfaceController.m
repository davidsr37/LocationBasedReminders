//
//  InterfaceController.m
//  LocoReminders WatchKit Extension
//
//  Created by David Rogers on 2/5/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "InterfaceController.h"
#import "ReminderRowCon.h"
#import <CoreLocation/CoreLocation.h>


@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceTable *interfaceTable;
@property (strong, nonatomic) NSArray *regionsArray;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
  CLLocationManager *locationManager = [CLLocationManager new];
  NSSet *regions = locationManager.monitoredRegions;
  self.regionsArray = regions.allObjects;
  
  NSArray *points = self.regionsArray;
  [self.interfaceTable setNumberOfRows:self.regionsArray.count withRowType:@"ReminderRowController"];
  NSInteger index = 0;
  for (CLCircularRegion *point in points) {
    ReminderRowCon *rowCon = [self.interfaceTable rowControllerAtIndex:index];
    [rowCon.reminderLabel setText:point.identifier];
    index++;
    
  }
  
}

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex {
  NSLog(@"%ld", (long)rowIndex);
  
  CLCircularRegion *region = self.regionsArray[rowIndex];
  
  return region;
  
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



