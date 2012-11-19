//
//  Favorite.m
//  UMAtaizen
//
//  Created by T on 12/11/05.
//  Copyright (c) 2012年 荒木力. All rights reserved.
//

#import "Favorite.h"
#import "FavoriteDetail.h"

@interface Favorite () {
    NSMutableArray *_objects;
    NSMutableArray *_objects2;
    
    NSArray *nameArr;
    NSArray *nameArr2;
    
    NSArray *keyArray;
    
    NSArray *saveArray;
}
@end

@implementation Favorite

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    keyArray = [NSArray arrayWithObjects:@"NAME1", @"NAME2", @"NAME3", @"NAME4", @"NAME5", @"NAME6", nil];
    
    NSString *umaNAME = [[NSUserDefaults standardUserDefaults] objectForKey:@"NAME"];
    NSLog(@"%@", umaNAME);
    
    
    // お気に入りデータ取得
    saveArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"FAVORITE"];
    
    
    
    // plistからUMAの名前を取り出して配列に入れておく
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UMAname" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    nameArr = [dic objectForKey:@"name"];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"UMAname_2" ofType:@"plist"];
    NSDictionary *dic2 = [NSDictionary dictionaryWithContentsOfFile:path2];
    nameArr2 = [dic2 objectForKey:@"name"];
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    _objects = [[NSMutableArray alloc] initWithObjects:
//                @"イエティ",
//                @"ネッシー",
//                @"チュパカブラ",
//                nil];
//    _objects2 = [[NSMutableArray alloc] initWithObjects:
//    @"犬",
//    @"猫",
//    @"クマ",
//    nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // お気に入りデータ取得
    saveArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"FAVORITE"];
    // テーブル表示の更新
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return [nameArr count];
    
    int ret = 0;
    for ( int i=0; i<[saveArray count]; i++ ) {
        int sec = [[saveArray[i] objectForKey:@"SECTION"] intValue];
        if ( sec == section ) {
            ret = [[saveArray[i] objectForKey:@"ROW"] count];
        }
    }
    return ret;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSUserDefaultsからキーを取り出す
    // for文でそのキー番号があるかどうがをチェック
    // NSUserDefaultsから値(名前)を取り出す
    // 取り出した値(名前)を下のcell.tectLabel.textにセットする
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
//    if (indexPath.section==0) {
//        for (int i=0; i<[nameArr count]; i++) {
//            NSString *umaNAME = [[NSUserDefaults standardUserDefaults] objectForKey:[keyArray objectAtIndex:i]];
//            if ([[nameArr objectAtIndex:i] isEqualToString:umaNAME]) {
//                cell.textLabel.text = [nameArr objectAtIndex:i];
//                break;
//            }
//        }
//        
//        return cell;
//    }else if (indexPath.section==1 ) {
//        for (int i=0; i<[nameArr2 count]; i++) {
//            NSString *umaNAME = [[NSUserDefaults standardUserDefaults] objectForKey:[keyArray objectAtIndex:i]];
//            if ([[nameArr2 objectAtIndex:i] isEqualToString:umaNAME]) {
//                cell.textLabel.text = [nameArr objectAtIndex:i];
//                break;
//            }
//        }
//    }
    for ( int i=0; i<[saveArray count]; i++ ) {
        int sec = [[saveArray[i] objectForKey:@"SECTION"] intValue];
        if ( sec == indexPath.section ) {
            NSArray *rowAry = [saveArray[i] objectForKey:@"ROW"];
            
            if ( indexPath.section == 0 ) {
                cell.textLabel.text = [nameArr objectAtIndex:[rowAry[indexPath.row] intValue]];
            }else if ( indexPath.section == 1 ) {
                cell.textLabel.text = [nameArr2 objectAtIndex:[rowAry[indexPath.row] intValue]];
            }
        }
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"セクションその1";
            break;
        case 1:
            return @"セクションその２";
            break;
           }
    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = nameArr[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}


@end

