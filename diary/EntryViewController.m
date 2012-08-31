//
//  EntryViewController.m
//  diary
//
//  Created by Edward Kim on 8/30/12.
//  Copyright (c) 2012 AppAcademy. All rights reserved.
//

#import "EntryViewController.h"

@interface EntryViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation EntryViewController
@synthesize pictureImageView;
@synthesize textView;
@synthesize text;
@synthesize picture;

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    self.textView.text = text;
    //self.pictureImageView.image = self.picture;
    self.pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.pictureImageView.image = [UIImage imageNamed:@"ned.png"];
}

- (void)viewDidUnload
{
    [self setPictureImageView:nil];
    [self setTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
