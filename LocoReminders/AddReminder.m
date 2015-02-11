//
//  AddReminder.m
//  LocoReminders
//
//  Created by David Rogers on 2/4/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "AddReminder.h"

@interface AddReminder ()

@property (weak, nonatomic) IBOutlet UITextField *pointName;

@property (weak, nonatomic) IBOutlet MKMapView *mapMiniViz;

@property (nonatomic, assign) id currentResponder;

@end

@implementation AddReminder

-(void)viewDidLoad {
  [super viewDidLoad];
  
  NSLog(@"long:%f, lat:%f", self.annotation.coordinate.longitude, self.annotation.coordinate.latitude); //looking at where pin was dropped
  self.mapMiniViz.mapType = MKMapTypeHybrid;
  
  MKPointAnnotation *point = [MKPointAnnotation new];
  
  CLLocationCoordinate2D coord = {.latitude = self.annotation.coordinate.latitude, .longitude = self.annotation.coordinate.longitude};
  point.coordinate = coord;
  [self.mapMiniViz addAnnotation:point];
  
  MKCoordinateSpan span = {.latitudeDelta = 0.0024, .longitudeDelta = 0.0024};
  MKCoordinateRegion region = {coord, span};
  [self.mapMiniViz setRegion:region animated:YES];
  
  [self.view addSubview:self.mapMiniViz];

}


- (IBAction)button:(id)sender {
  
  if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) { //make sure avail
    
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:self.annotation.coordinate radius:210 identifier:self.pointName.text];
    
    [self.locationManager startMonitoringForRegion: region];
    
    //watching now
    [self.locationManager.monitoredRegions allObjects];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderAdded"
      object:self userInfo:@{@"reminder" : region, @"title" : self.pointName.text}];
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:true];
  }
  
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
