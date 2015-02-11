//
//  MapVC.m
//  LocoReminders
//
//  Created by David Rogers on 2/2/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "MapVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AddReminder.h"

@interface MapVC () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *homeButton;

@property (weak, nonatomic) IBOutlet UIButton *schoolButton;

@property (weak, nonatomic) IBOutlet UIButton *spaceneedleButton;

@property (strong, nonatomic) CLLocationManager *locoManager;

@property (strong, nonatomic) MKPointAnnotation *annotation;

@property (weak, nonatomic) IBOutlet MKMapView *map;


@end


@implementation MapVC

- (IBAction)buttonForSchoolRegionSelected:(id)sender {
  self.map.mapType = MKMapTypeStandard;
  
  MKPointAnnotation *point = [MKPointAnnotation new];
  
  CLLocationCoordinate2D coord = {.latitude = 47.623765, .longitude = -122.336069};
  point.coordinate = coord;
  [self.map addAnnotation:point];
  
  MKCoordinateSpan span = {.latitudeDelta = 0.02, .longitudeDelta = 0.02};
  MKCoordinateRegion region = {coord, span};
  [self.map setRegion:region animated:YES];
  
  [self.view addSubview:self.map];
  
  if ([CLLocationManager isMonitoringAvailableForClass: [CLCircularRegion class]]) {
       
    CLCircularRegion *preSelectedRegion = [[CLCircularRegion alloc] initWithCenter:coord radius: 185 identifier: @"selectedRegion"];
    [self.locoManager startMonitoringForRegion:preSelectedRegion];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"preSelectedRegion" object:self userInfo:@{@"reminder" : preSelectedRegion}];
  }
}


- (IBAction)buttonForHomeRegionSelected:(id)sender {
  self.map.mapType = MKMapTypeStandard;
  
  MKPointAnnotation *point = [MKPointAnnotation new];
  
  CLLocationCoordinate2D coord = {.latitude = 47.672153, .longitude = -122.387118};
  point.coordinate = coord;
  [self.map addAnnotation:point];
  
  MKCoordinateSpan span = {.latitudeDelta = 0.02, .longitudeDelta = 0.02};
  MKCoordinateRegion region = {coord, span};
  [self.map setRegion:region animated:YES];
  
  [self.view addSubview:self.map];
  
  if ([CLLocationManager isMonitoringAvailableForClass: [CLCircularRegion class]]) {
    
    CLCircularRegion *homeRegion = [[CLCircularRegion alloc] initWithCenter:coord radius: 185 identifier: @"selectedRegion"];
    [self.locoManager startMonitoringForRegion:homeRegion];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"homeRegion" object:self userInfo:@{@"reminder" : homeRegion}];
  }
}

- (IBAction)buttonForSpaceNeedleRegionSelected:(id)sender {
  self.map.mapType = MKMapTypeStandard;
  
  MKPointAnnotation *point = [MKPointAnnotation new];
  
  CLLocationCoordinate2D coord = {.latitude = 47.620797, .longitude = -122.349184};
  point.coordinate = coord;
  [self.map addAnnotation:point];
  
  MKCoordinateSpan span = {.latitudeDelta = 0.45, .longitudeDelta = 0.45};
  MKCoordinateRegion region = {coord, span};
  [self.map setRegion:region animated:YES];
  
  [self.view addSubview:self.map];
  
  if ([CLLocationManager isMonitoringAvailableForClass: [CLCircularRegion class]]) {
    
    CLCircularRegion *spaceNeedleRegion = [[CLCircularRegion alloc] initWithCenter:coord radius: 185 identifier: @"selectedRegion"];
    [self.locoManager startMonitoringForRegion:spaceNeedleRegion];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"spaceNeedleRegion" object:self userInfo:@{@"reminder" : spaceNeedleRegion}];
  }
}




- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reminderAdded:) name:@"ReminderAdded" object:nil];
 
  
  self.locoManager = [CLLocationManager new];
  self.locoManager.delegate = self;
  [self.map setDelegate:self];
  
//  [self.locoManager requestWhenInUseAuthorization];
  
//  __weak MapVC *weakSelf = self;
//  
//  [UIView animateWithDuration:0.4 animations:^{
//    
//    weakSelf.view.backgroundColor = [UIColor blueColor];
//    
//  }];
  
  
//  [self.map setShowsUserLocation:YES];
  
  
  if ([CLLocationManager locationServicesEnabled]) { //if services enabled
    
    NSLog(@"status is %d", [CLLocationManager authorizationStatus]);
    
    if ([CLLocationManager authorizationStatus] == 0) {
      [self.locoManager requestAlwaysAuthorization]; //auth-enable
      
    } else {
      self.map.showsUserLocation = true;
      [self.locoManager startMonitoringSignificantLocationChanges];
      
    }
      } else {
    //TODO: loco services not enabled warning
  }
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapLongPressed:)];
  [self.map addGestureRecognizer:longPress]; //gesture is set
  
}


-(void) reminderAdded:(NSNotification *)notification {
  NSDictionary *userInfo = notification.userInfo;
  
  self.annotation.title = userInfo[@"title"];
  
  CLCircularRegion *region = userInfo[@"reminder"];
  
  MKCircle *circleOver = [MKCircle circleWithCenterCoordinate:region.center radius:region.radius];
  
  [self.map addOverlay:circleOver];
  
}


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
  MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
  circleRenderer.fillColor = [UIColor blueColor];
  circleRenderer.strokeColor = [UIColor greenColor];
  circleRenderer.alpha = 0.15; //subtle, only slightly opaque
  return circleRenderer;
}


-(void)mapLongPressed:(id)sender {
  
  UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
  
  NSLog(@"long press fired");
  
  if (longPress.state == 3) { // 3 is long press did finish
    NSLog(@"long press ended");
    
    CGPoint location = [longPress locationInView:self.map];
    NSLog(@"location y: %f, location x: %f", location.y, location.x);
    
    CLLocationCoordinate2D coords = [self.map convertPoint:location toCoordinateFromView:self.map];
    
    NSLog(@"long: %f, lat: %f", coords.longitude, coords.latitude);
    
    MKPointAnnotation *pin = [MKPointAnnotation new];
    pin.coordinate = coords;
    pin.title = @"New Location";
    [self.map addAnnotation:pin];
    
  }
}


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  NSLog(@"new status: %d", status);
  if ((status == 3) || (status == 4)) { //3 & 4 are authed
    self.map.showsUserLocation = true;
  }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  
  CLLocation *location = locations.firstObject;
  NSLog(@"lat: %f, long: %f", location.coordinate.latitude, location.coordinate.longitude);
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  
  MKPinAnnotationView *annotView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ANNOT_VIEW"];
  annotView.animatesDrop = true;
  annotView.pinColor = MKPinAnnotationColorGreen;
  annotView.canShowCallout = true;
  annotView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
  // annotView.leftCalloutAccessoryView = (text returned from AddReminder view) (use if statement?)
  
  return annotView;
}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
  self.annotation = view.annotation;
  
  [self performSegueWithIdentifier:@"SHOW_DETAIL" sender:self];
  
  NSLog(@"button tapped");
}


-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  NSLog(@"region entered");
  UILocalNotification *localNotification = [UILocalNotification new];
  localNotification.alertBody = @"region entered";
  localNotification.alertAction = @"region action";
  
  [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"SHOW_DETAIL"]) {
    AddReminder *addReminderVC = (AddReminder *)segue.destinationViewController;
    addReminderVC.annotation = self.annotation;
    addReminderVC.locationManager = self.locoManager;
  
  }
}

//- (void) doSomethingWithString: (NSString *)string andcompletionHandler:(void (^)(NSString *)) completionHandler {
//  
//  completionHandler(@"Name");
//  
//}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];

}

// C-F located at 47.623765, 122.336069
// Home (bus stop) located at 47.673078, -122.377682

//Space Needle located at 47.620797, -122.349184

@end
