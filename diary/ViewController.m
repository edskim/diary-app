//
//  ViewController.m
//  diary
//
//  Created by Edward Kim on 8/30/12.
//  Copyright (c) 2012 AppAcademy. All rights reserved.
//

#import "DiaryEntryDataStore.h"
#import "Entry.h"
#import "EntryViewController.h"
#import "NewEntryViewController.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong) UIBarButtonItem *addEntryButton;
- (void)addEntryPressed:(id)sender;


@end

@implementation ViewController
@synthesize tableView;
@synthesize toolBar;
@synthesize addEntryButton;

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *background = [UIImage imageNamed:@"HannahMontana-641144.jpeg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:background];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:255.0 green:105.0 blue:180.0 alpha:0.85];
    [self.navigationController setNavigationBarHidden:YES];
    UIImage *banner = [UIImage imageNamed:@"hm-toolbar.png"];
    [self.toolBar setBackgroundImage:banner forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    
    UIImage *entryButtonImage = [UIImage imageNamed:@"hm-toolbar-button-normal.png"];
    UIImage *entryButtonImageDown = [UIImage imageNamed:@"hm-toolbar-button-down.png"];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.bounds = CGRectMake( 0, 0, entryButtonImage.size.width, entryButtonImage.size.height );
    [addButton setImage:entryButtonImage forState:UIControlStateNormal];
    [addButton setImage:entryButtonImageDown forState:UIControlStateHighlighted];
    [addButton addTarget:self action:@selector(addEntryPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.addEntryButton = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.toolBar setItems:[NSArray arrayWithObjects:spacer, self.addEntryButton, nil]];
}

- (void)viewDidUnload
{
    [self setAddEntryButton:nil];
    [self setTableView:nil];
    [self setToolBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)addEntryPressed:(id)sender {
    [self.navigationController pushViewController:[NewEntryViewController new] animated:YES];
}

#pragma mark UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EntryViewController *entryVC = [EntryViewController new];
    entryVC.text = [[[DiaryEntryDataStore allEntries] objectAtIndex:indexPath.row] text];
    [self.navigationController pushViewController:entryVC animated:YES];
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[DiaryEntryDataStore allEntries] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *newCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    Entry *entry = [[DiaryEntryDataStore allEntries] objectAtIndex:indexPath.row];
    newCell.textLabel.text = entry.text;
    newCell.detailTextLabel.text = [entry.date description];
    return newCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.rowHeight;
}

@end
