//
//  SingleVideoViewController.m
//  AnBao
//
//  Created by mac   on 15/9/8.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "SingleVideoViewController.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "VideoTableViewCell.h"

@interface SingleVideoViewController ()
{

    UITableView *videoTable;
}

@end

@implementation SingleVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    videoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    videoTable.delegate = self;
    videoTable.dataSource = self;
    videoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    videoTable.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    // monitorTable.separatorStyle = NO;
    [self.view addSubview:videoTable];
    
    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 2;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentify = @"cell";
    VideoTableViewCell *cell = (VideoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    
    if(cell == nil){
        
        cell = [[VideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;

}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 65.0*HEIGHT/667;
    
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
