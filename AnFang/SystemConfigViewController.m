//
//  SystemConfigViewController.m
//  AnFang
//
//  Created by MyOS on 15/12/22.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "SystemConfigViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "ViewController.h"

@interface SystemConfigViewController ()

@end

@implementation SystemConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"222121"];
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [headView addSubview:navView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"系统设置";
    title.font = [UIFont systemFontOfSize:20];
    title.textColor = [UIColor colorWithHexString:@"ce7031"];
    [navView addSubview:title];
    [self.view addSubview:headView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 50)];
    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 60, 16)];
    backTitle.textAlignment = NSTextAlignmentCenter;
    backTitle.text = @"返回";
    backTitle.font = [UIFont fontWithName:@"MicrosoftYaHei" size:28];
    backTitle.textColor = [UIColor whiteColor];
    [backBtn addSubview:backTitle];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 20, 20)];
    backImage.image = [UIImage imageNamed:@"back.png"];
    [backBtn addSubview:backImage];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    self.setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    [self.view addSubview:self.setTableView];
    self.setTableView.dataSource = self;
    self.setTableView.delegate = self;
    [self.setTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.menuArray = [[NSMutableArray alloc] initWithObjects:@"退出登录", @"清理缓存",nil];
    //self.setTableView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    // Do any additional setup after loading the view.
}

-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.menuArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell =(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 59.0*HEIGHT/667, WIDTH, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [cell.contentView addSubview:line];
    cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60.0*HEIGHT/667;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
    
        [self jumpToAccountView];
    }else if (indexPath.row == 1){
    
        //NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //float catchSize = [self folderSizeAtPath:cachPath];
        NSString *message = @"确定要清理缓存?";
        //message = [@"缓存大小为" stringByAppendingString:[NSString stringWithFormat:@"%f",catchSize]];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self clearCache];
        }];
        
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

-(void)jumpToAccountView
{
    
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *loginView = [mainView instantiateViewControllerWithIdentifier:@"loginViewId"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginView animated:YES];
    
}

/**
 *  清理缓存
 */
-(void) clearCache
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess)
                                              withObject:nil waitUntilDone:YES];});
}

-(void)clearCacheSuccess
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"缓存清理成功！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    // Add the actions.
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

-(float)folderSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
