//
//  FavoriteDetail.m
//  UMAtaizen
//
//  Created by T on 12/11/05.
//  Copyright (c) 2012年 荒木力. All rights reserved.
//

#import "FavoriteDetail.h"

@interface FavoriteDetail ()
- (void)configureView;
@end

@implementation FavoriteDetail

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
