//
//  NewEntryViewController.m
//  diary
//
//  Created by Edward Kim on 8/30/12.
//  Copyright (c) 2012 AppAcademy. All rights reserved.
//

#import "DiaryEntryDataStore.h"
#import "Entry.h"
#import "NewEntryViewController.h"

@interface NewEntryViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation NewEntryViewController
@synthesize imageView;
@synthesize textView;
@synthesize submitButton;

- (IBAction)submitPressed:(id)sender {
    if ([self.textView.text length] > 0) {
        Entry *newEntry = [DiaryEntryDataStore createEntry];
        newEntry.text = self.textView.text;
        newEntry.date = [NSDate date];
        [DiaryEntryDataStore save];
        
        self.textView.text = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}


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
    
    UIImage *background = [UIImage imageNamed: @"HannahMontana-641144.jpeg"];
    self.imageView.image = background;
    
    self.textView.delegate = self;
    
    self.submitButton.backgroundColor = [UIColor clearColor];
    UIImage *buttonImageNormal = [UIImage imageNamed:@"hm-button-normal.png"];
    UIImage *buttonImageDown = [UIImage imageNamed:@"hm-button-down.png"];
    //CGRect buttonImageRect = CGRectMake(self.submitButton.frame.origin.x, self.submitButton.frame.origin.y, buttonImageNormal.size.width, buttonImageNormal.size.height);
    //self.submitButton.frame = buttonImageRect;
    [self.submitButton setImage:buttonImageNormal forState:UIControlStateNormal];
    [self.submitButton setImage:buttonImageDown forState:UIControlStateHighlighted];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setTextView:nil];
    [self setSubmitButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
