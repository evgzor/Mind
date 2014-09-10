//
//  MCalendarVC.m
//  Mind
//
//  Created by Evgeny Zorin on 08/09/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "MCalendarVC.h"
#import "MCalendarView.h"

@interface MCalendarVC ()

@property (strong, nonatomic) NSMutableArray* layoutConstraintsPortrait;
@property (strong, nonatomic) NSMutableArray* layoutConstraintsLandscape;
@property (weak, nonatomic) IBOutlet MCalendarView* calendarView;
@property (weak, nonatomic) IBOutlet UITableView* taskList;

@end

@implementation MCalendarVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)updateViewConstraints {
    [super updateViewConstraints];
    
    // constraints for portrait orientation
    // use a property to change a constraint's constant and/or create constraints programmatically, e.g.:
    if (!self.layoutConstraintsPortrait) {
        UIView *calendar = self.calendarView;
        UIView *taskList = self.taskList;
        self.layoutConstraintsPortrait = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:[calendar]-0-[taskList]-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(calendar, taskList)] mutableCopy];
       
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:calendar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem: taskList attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:calendar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:taskList attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:taskList attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:taskList attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:calendar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:calendar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];

        
    }
    
    // constraints for landscape orientation
    // make sure they don't conflict with and complement the existing constraints
    if (!self.layoutConstraintsLandscape) {
        UIView *calendar = self.calendarView;
        UIView *taskList = self.taskList;
        
        self.layoutConstraintsLandscape = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:[calendar]-0-[taskList]-0-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(calendar, taskList)] mutableCopy];

    }
    
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
    [self.view removeConstraints:isPortrait ? self.layoutConstraintsLandscape : self.layoutConstraintsPortrait];
    [self.view addConstraints:isPortrait ? self.layoutConstraintsPortrait : self.layoutConstraintsLandscape];
    
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.view setNeedsUpdateConstraints];
    
}

@end
