//
//  DetailViewController.m
//  UMAtaizen
//
//  Created by T on 12/11/05.
//  Copyright (c) 2012年 荒木力. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

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



- (IBAction)favoriteResponder:(id)sender {
    if([sender state] == UIGestureRecognizerStateBegan){
        
        // 長押し検出時の処理
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"お気に入りに登録しました。"
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"", nil];
        [alert show];
        NSLog(@"呼ばれた");

    }else if([sender state] == UIGestureRecognizerStateEnded){
        
        // 指を離したときの処理
        
    }
        
    //TODO:くまを食べる

}
@end
