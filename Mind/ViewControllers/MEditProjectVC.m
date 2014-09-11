//
//  EditProjectVC.m
//  Mind
//
//  Created by Evgeny Zorin on 22/08/14.
//  Copyright (c) 2014 Evgeny Zorin. All rights reserved.
//

#import "MEditProjectVC.h"

@interface MEditProjectVC ()
{
    IBOutlet UIProgressView* _taskProgress;
    IBOutlet UITableView* _taskList;
    IBOutlet UITextView* _taskDescription;
    IBOutlet UILabel* _taskTitleLbl;
    IBOutlet UILabel* _taskDescriptionLbl;
}

@property (strong, nonatomic) NSMutableArray* layoutConstraintsPortrait;
@property (strong, nonatomic) NSMutableArray* layoutConstraintsLandscape;

@end

@implementation MEditProjectVC

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
    _taskList.layer.borderWidth = 1.0;
    _taskList.layer.borderColor = [UIColor redColor].CGColor;
    
    _taskDescription.layer.borderColor = [UIColor greenColor].CGColor;
    _taskDescription.layer.borderWidth = 1.;
    
    _taskDescriptionLbl.layer.borderWidth = _taskTitleLbl.layer.borderWidth = 1.0;
    
    _taskTitleLbl.layer.borderColor = [UIColor brownColor].CGColor;
    _taskDescriptionLbl.layer.borderColor = [UIColor blueColor].CGColor;
    
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
        UIView *taskDesc = _taskDescription;
        UIView *taskList = _taskList;
        UIView* descName = _taskDescriptionLbl;
        UIView* titleLbl  = _taskTitleLbl;
        
        self.layoutConstraintsPortrait = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLbl]-0-[taskList]-0-[descName]-0-[taskDesc]-0-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(titleLbl, taskList, descName, taskDesc)] mutableCopy];
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:titleLbl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem: self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:titleLbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem: self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:taskList attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem: taskDesc attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:taskList attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:taskDesc attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:taskDesc attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:taskDesc attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:taskList attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        [self.layoutConstraintsPortrait addObject:[NSLayoutConstraint constraintWithItem:taskList attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        
    }
    
    // constraints for landscape orientation
    // make sure they don't conflict with and complement the existing constraints
    if (!self.layoutConstraintsLandscape) {
        UIView *taskDesc = _taskDescription;
        UIView *taskList = _taskList;
        
        self.layoutConstraintsLandscape = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:[taskList]-0-[taskDesc]-0-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(taskList, taskDesc)] mutableCopy];
        
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
