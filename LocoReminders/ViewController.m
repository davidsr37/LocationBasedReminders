//
//  ViewController.m
//  LocoReminders
//
//  Created by David Rogers on 2/2/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()


@end

@implementation ViewController
//have to synthesize if overriding the properties, we have custom setter and getter
//@synthesize name = _name;

- (void)viewDidLoad {
  [super viewDidLoad];
  
//  //accessing ivar (private to class) but ignoring the setter and getter
//  _name = @"Name";
//  
//  //using dot notation for below, same as line afterward
//  self.name = @"Name";
//  //setter and getter is the only way to access from another place
//  [self setName:@"Name"];
//  //use getter when on right side of equal side
//  NSString *myName = self.name;
//  
//  [NSString stringWithString:self.name]; //common pattern
//  
//  //getter
//  [self name];
//  
//  [self view];
//  
//  [self setupView:self.view forViewController:self withColor: [UIColor blueColor]];
//  
//  Person *person = [[Person alloc] init];
//  Person *anotherPerson = [Person new];
//  
//  
  // Do any additional setup after loading the view, typically from a nib.
}

//- (void)setName:(NSString *)name {
//  _name = name;
//  
//}
//
//- (NSString *)name {
//  return _name;
//}
//
//
//- (void)setupView:(UIView *)setView forViewController:(UIViewController *)vc withColor: (UIColor *)color {
//  

  
  
//}






@end
