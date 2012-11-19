//
//  DetailViewController.h
//  UMAtaizen
//
//  Created by T on 12/11/05.
//  Copyright (c) 2012年 荒木力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface DetailViewController : UIViewController<UIGestureRecognizerDelegate>
{
    NSArray *keyArray;
    UIImage *umaImg;
    UIImageView *umaImgV;
}
@property (strong, nonatomic) id detailItem;
@property (nonatomic) int section;
@property (nonatomic) int row;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;


- (IBAction)favoriteResponder:(id)sender;
@end
