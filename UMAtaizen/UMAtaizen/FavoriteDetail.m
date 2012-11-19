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
        
        NSLog(@"%@", _detailItem);
        
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
	
    // 画像名のplistファイルを作成
    
    // そのplistファイルから画像名を取り出して配列に入れておく
    
    
    [self configureView];
    
//    fImg = [NSMutableArray @["@1.png","@2.png","@3.png"]];
//    for (i=0; i<3[fImg count]; i++) {
//        if (<#condition#>) {
//            <#statements#>
//        }
//    };
    
//    seeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:fImg]];
    [self.view addSubview:seeView];
    
        
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
