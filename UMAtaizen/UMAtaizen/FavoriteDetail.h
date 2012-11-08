//
//  FavoriteDetail.h
//  UMAtaizen
//
//  Created by T on 12/11/05.
//  Copyright (c) 2012年 荒木力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  FavoriteDetail: UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

