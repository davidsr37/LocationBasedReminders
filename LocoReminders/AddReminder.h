//
//  AddReminder.h
//  LocoReminders
//
//  Created by David Rogers on 2/4/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h> 

@interface AddReminder : UIViewController

@property (strong, nonatomic) MKPointAnnotation *annotation;

@property (strong,nonatomic) CLLocationManager *locationManager;

@end
