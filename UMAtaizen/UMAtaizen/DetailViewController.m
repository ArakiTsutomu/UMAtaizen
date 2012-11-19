//
//  DetailViewController.m
//  UMAtaizen
//
//  Created by T on 12/11/05.
//  Copyright (c) 2012年 荒木力. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    
}
- (void)configureView;
@end
//阿部

// セーブデータ(row)ソート用関数
NSComparisonResult rowCompare (id obj1, id obj2, void* context)
{
    //自分が比較したいオブジェクトに変換
    NSNumber *my = obj1;
    NSNumber *target = obj2;
    
    //値を比較してそれに当たる物を返す。
    if ([my intValue] < [target intValue])
        return NSOrderedAscending;
    else if ([my intValue] == [target intValue])
        return NSOrderedSame;
    else
        return NSOrderedDescending;
}


@implementation DetailViewController

@synthesize section;
@synthesize row;


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

//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
//    }
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    keyArray = [NSArray arrayWithObjects:@"NAME1", @"NAME2", @"NAME3", @"NAME4", @"NAME5", @"NAME6", nil];
    
    section = 0;
    row = 0;
    
    section = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SECTION"] intValue];
    row = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ROW"] intValue];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"img" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *imgArr = [dic objectForKey:@"imgArray"];
    
    // i=セクション数
    for (int i=0; i<2; i++) {
        // j=行数
        for (int j=0; j<[imgArr count]; j++) {
            if (section == i && row == j) {
                UIImage *image = [UIImage imageNamed:[imgArr objectAtIndex:j]];
                UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
                [self.view addSubview:imgView];
            }
        }
    }
    
    
    
    
    
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
        
        
        
        
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        // 保存済みお気に入りデータ取得
        BOOL isFindSection = NO;
        int findSectionID = 0;
        NSArray *ary = [ud objectForKey:@"FAVORITE"];
        for ( int s=0; s<[ary count]; s++ ) {
            // セクション取り出し(secがセクション番号)
            NSDictionary *dic = ary[s];
            int sec = [dic[@"SECTION"] intValue];
            if ( sec == section ) {
                // 同一セクションのお気に入りデータが既にある(本登録時に使用する)
                isFindSection = YES;
                findSectionID = s;
            }
            
            NSArray *rowAry = dic[@"ROW"];
            for ( int r=0; r<[rowAry count]; r++ ) {
                // row取り出し(noがrow番号)
                int no = [rowAry[r] intValue];
                if ( sec == section && no == row ) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                                   message:@"すでに登録されています。"
                                                                  delegate:nil
                                                         cancelButtonTitle:nil
                                                         otherButtonTitles:@"", nil];
                    [alert show];
                    
                    // 終了
                    return;
                }
            }
        }
        // お気に入りに新規登録 ------
        // 入れ物作成
        NSMutableArray *mary;
        if ( ary ) {
            // データあり
            mary = [NSMutableArray arrayWithArray:ary];
        }else {
            // データなし
            mary = [NSMutableArray array];
        }
        // 本登録 ---
        // セクションデータがあるか確認
        if ( isFindSection ) {
            // rowを登録 -----
            // 既存セクションデータ取得
            NSDictionary *dic = ary[findSectionID];
            NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
            // 既存rowデータ取得
            NSArray *rary = mdic[@"ROW"];
            NSMutableArray *mrary = [NSMutableArray arrayWithArray:rary];
            // row追加
            [mrary addObject:[NSNumber numberWithInt:row]];
            // 並び替えて順番通りにする
            [mrary sortUsingFunction:rowCompare context:nil];
            
            // rootのmaryに反映 -----
            [mdic setObject:mrary forKey:@"ROW"];
            // 新データに置き換え
            [mary replaceObjectAtIndex:findSectionID withObject:mdic];
            
        }else {
            // sectionを作成してからrowを登録 -----
            NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:section] forKey:@"SECTION"];
            NSMutableArray *mrary = [NSMutableArray arrayWithObject:[NSNumber numberWithInt:row]];
            
            // rootのmaryに反映 -----
            [mdic setObject:mrary forKey:@"ROW"];
            // 新規追加
            [mary addObject:mdic];
        }
        // 保存
        [ud setObject:mary forKey:@"FAVORITE"];
        
        [ud synchronize];

        
        
        
        
        
        int k = 0;
        for (int i=0; i<2; i++) {
            for (int j=0; j<3; j++) {
                if (section == i && row == j) {
                    [[NSUserDefaults standardUserDefaults] setObject:_detailItem forKey:[keyArray objectAtIndex:k]];
                    break;
                }
                
                k++;
                
            }
        }
        
    
    

    }else if([sender state] == UIGestureRecognizerStateEnded){
        
        // 指を離したときの処理
        
        
        
    }
    
        
    //TODO:くまを食べる

}
@end
