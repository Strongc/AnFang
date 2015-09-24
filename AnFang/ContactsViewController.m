//
//  ContactsViewController.m
//  AnBao
//
//  Created by mac   on 15/8/25.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "ContactsViewController.h"
#import "Common.h"

@interface ContactsViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UITableView *contactTable;
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplay;
    NSArray *sectionKey;
    NSArray *menuData;
    NSMutableDictionary *dicData;
    NSMutableDictionary *dicShowRow;
    UIView *menuView;
    UIView *tableHeaderView;

}

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,WIDTH,60)];
    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 50)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"联系人";
    title.textColor = [UIColor whiteColor];
    [headView addSubview:title];
    [self.view addSubview:headView];
    
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50, 15, 40, 40)];
    [self.view addSubview:addBtn];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    addBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self ConfigControl];
    [self initData];
    // Do any additional setup after loading the view.
}

-(void)initData
{
    
    __async_opt__,^
    {
        sectionKey = @[@"我的设备", @"朋友", @"兄弟", @"家人", @"同学", @"同事", @"长辈", @"兼职", @"陌生人", @"黑名单"];
        dicData = [[NSMutableDictionary alloc]init];
        dicShowRow = [[NSMutableDictionary alloc]init];
        
        //遍历数组
        [sectionKey enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             NSMutableArray *ar = [NSMutableArray new];
             //             srand((unsigned)time(0));  //不加这句每次产生的随机数不变
             int c = rand() % 10 + 1;
             //             int c = arc4random() % 10 + 1;
             for (int i = 1; i < c; i++)
             {
                 [ar addObject:[NSString stringWithFormat:@"%d", i]];
             }
             [dicData setObject:ar forKey:obj];
             [dicShowRow setObject:[NSNumber numberWithBool:NO] forKey:obj];
         }];
        
        __async_main__, ^
        {
            [contactTable reloadData];
        });

    });

}

//添加控件
-(void)ConfigControl
{
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 50, WIDTH, 44)];
    [searchBar setPlaceholder:@"搜索"];
    [searchBar setSearchBarStyle:UISearchBarStyleDefault];
    
    CGFloat bottom = searchBar.frame.origin.y +searchBar.frame.size.height;
    
    contactTable = [[UITableView alloc] initWithFrame:CGRectMake(0, bottom, WIDTH, self.view.frame.size.height-bottom-self.tabBarController.tabBar.frame.size.height) style:UITableViewStylePlain];
    contactTable.delegate = self;
    contactTable.dataSource = self;
    [contactTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:contactTable];
    
    tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, bottom, self.view.frame.size.width, 106)];
    [tableHeaderView setBackgroundColor:[UIColor whiteColor]];
    
    UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, tableHeaderView.frame.size.height - 25, WIDTH, 25)];
    [titleV setBackgroundColor:RGBA(235, 235, 235, 1)];
    UILabel *titleL = [[UILabel alloc] initWithFrame:titleV.bounds];
    [titleL setBackgroundColor:[UIColor clearColor]];
    [titleL setText:@"  好友分组"];
    [titleL setFont:[UIFont systemFontOfSize:13]];
    [titleV addSubview:titleL];
    [tableHeaderView addSubview:titleV];
    contactTable.tableHeaderView = tableHeaderView;
    
    searchDisplay = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchDisplay.active = NO;
    searchDisplay.delegate = self;
    searchDisplay.searchResultsDataSource =self;
    searchDisplay.searchResultsDelegate =self;
    [self.view addSubview:searchDisplay.searchBar];
    
    menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, tableHeaderView.frame.size.height-titleV.frame.size.height)];
    
    //menuV = [[RectViewForMessage alloc] initWithFrame:CGRectMake(0, 0, _tableHeaderV.width, _tableHeaderV.height - titleV.height) ar:_arMenuData showSpera:NO bg:@"buddy_header_nor.png"];
    menuView.backgroundColor = [UIColor whiteColor];
    [menuView setClipsToBounds:YES];
    [tableHeaderView addSubview:menuView];
    
    UIButton *btnGroup = [[UIButton alloc] initWithFrame:CGRectMake(30, 10, 40, 40)];
    [menuView addSubview:btnGroup];
    [btnGroup setBackgroundImage:[UIImage imageNamed:@"mulchat_header_icon_circle.png"] forState:UIControlStateNormal];
    
    UIButton *btnTelPhone = [[UIButton alloc] initWithFrame:CGRectMake(120, 10, 40, 40)];
    [menuView addSubview:btnTelPhone];
    [btnTelPhone setBackgroundImage:[UIImage imageNamed:@"buddy_header_icon_addressBook.png"] forState:UIControlStateNormal];
    
    UIButton *btnSharePhoto = [[UIButton alloc] initWithFrame:CGRectMake(210, 10, 40, 40)];
    [menuView addSubview:btnSharePhoto];
    [btnSharePhoto setBackgroundImage:[UIImage imageNamed:@"buddy_header_icon_group.png"] forState:UIControlStateNormal];
    
    UIButton *btnScan = [[UIButton alloc] initWithFrame:CGRectMake(300, 10, 40, 40)];
    [menuView addSubview:btnScan];
    [btnScan setBackgroundImage:[UIImage imageNamed:@"buddy_header_icon_public.png"] forState:UIControlStateNormal];
    
    UILabel *group = [[UILabel alloc]initWithFrame:CGRectMake(23, 55, 45, 10)];
    [menuView addSubview:group];
    group.font = [UIFont systemFontOfSize:15];
    group.textAlignment = NSTextAlignmentLeft;
    group.text = @"人脉圈";
    
    UILabel *tel = [[UILabel alloc]initWithFrame:CGRectMake(113, 55, 45, 10)];
    [menuView addSubview:tel];
    tel.font = [UIFont systemFontOfSize:15];
    tel.textAlignment = NSTextAlignmentLeft;
    tel.text = @"通讯录";
    
    UILabel *share = [[UILabel alloc]initWithFrame:CGRectMake(210, 55, 30, 10)];
    [menuView addSubview:share];
    share.font = [UIFont systemFontOfSize:15];
    share.textAlignment = NSTextAlignmentLeft;
    share.text = @"群组";
    
    UILabel *scan = [[UILabel alloc]initWithFrame:CGRectMake(293, 55, 60, 10)];
    [menuView addSubview:scan];
    scan.font = [UIFont systemFontOfSize:15];
    scan.textAlignment = NSTextAlignmentLeft;
    scan.text = @"生活服务";

}

//点击每一行，展开列表
-(void)showRow:(UIButton *)btn
{
    NSString *key = [sectionKey objectAtIndex:(btn.tag - 1)];
    BOOL b = [[dicShowRow objectForKey:key] boolValue];
    [dicShowRow setObject:[NSNumber numberWithBool:!b] forKey:key];
    [contactTable reloadSections:[NSIndexSet indexSetWithIndex:(btn.tag - 1)] withRowAnimation:UITableViewRowAnimationNone];


}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == searchDisplay.searchResultsTableView){
    
        return 0;
    }
    return sectionKey.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if(tableView == searchDisplay.searchResultsTableView){
        
        return 0;
    }
    
    NSString *key = [sectionKey objectAtIndex:section];
    BOOL bShowRow = [[dicShowRow objectForKey:key] boolValue];
    if (bShowRow)
    {
        return [[dicData objectForKey:[sectionKey objectAtIndex:section]] count];
    }
    return 0;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell)
    {
        int w = tableView.frame.size.width/6;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
        UIImage *i = [UIImage imageNamed:@"aio_face_manage_cover_default.png"];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, (50 - w + 15)/2, w - 15, w - 15)];
        iv.layer.masksToBounds = YES;
        iv.layer.cornerRadius = 6.0;
        iv.layer.borderWidth = 1.0;
        iv.layer.borderColor = [[UIColor whiteColor] CGColor];
        [iv setImage:i];
        iv.tag = 1;
        [cell.contentView addSubview:iv];
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(w + 5, 0, w*4 - 5, 30)];
        [nameL setBackgroundColor:[UIColor clearColor]];
        [nameL setTextAlignment:NSTextAlignmentNatural];
        [nameL setFont:[UIFont systemFontOfSize:18]];
        nameL.tag = 2;
        [cell.contentView addSubview:nameL];
        
        UILabel *stateL = [[UILabel alloc] initWithFrame:CGRectMake(w + 5, 25, w*4 - 5, 20)];
        [stateL setBackgroundColor:[UIColor clearColor]];
        [stateL setFont:[UIFont systemFontOfSize:12]];
        [stateL setTextColor:[UIColor grayColor]];
        stateL.tag = 3;
        [stateL setText:@"[离线]这家伙很吊，什么也没有留下"];
        [cell.contentView addSubview:stateL];

    
    }
    
    NSString *key = [sectionKey objectAtIndex:[indexPath section]];
    BOOL bShowRow = [[dicShowRow objectForKey:key] boolValue];
    if (bShowRow)
        ((UILabel *)[cell.contentView viewWithTag:2]).text = [[dicData objectForKey:key] objectAtIndex:indexPath.row];
    
     return cell;

}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    int w = tableView.frame.size.width/7;
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    [headV setBackgroundColor:[UIColor whiteColor]];
    
    NSString *key = [sectionKey objectAtIndex:section];
    BOOL bShowRow = [[dicShowRow objectForKey:key] boolValue];
    
    UIImage *i = [UIImage imageNamed:@"buddy_header_arrow.png"];
    UIImageView *arrowIV = [[UIImageView alloc] initWithFrame:CGRectMake((w - i.size.width)/2, (44 - i.size.height)/2, i.size.width, i.size.height)];
    [arrowIV setImage:i];
    [headV addSubview:arrowIV];
    if (bShowRow)
        arrowIV.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(w, 2, w * 4, 40)];
    [titleL setText:[sectionKey objectAtIndex:section]];
    [titleL setFont:[UIFont systemFontOfSize:16]];
    [titleL setUserInteractionEnabled:NO];
    [headV addSubview:titleL];
    
    UIView *lineHV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.5)];
    [lineHV setBackgroundColor:[UIColor grayColor]];
    [headV addSubview:lineHV];
    
    if (bShowRow)
    {
        UIView *lineBV = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5, tableView.frame.size.width, 0.5)];
        [lineBV setBackgroundColor:[UIColor grayColor]];
        [headV addSubview:lineBV];
    }
    
    UILabel *sumL = [[UILabel alloc] initWithFrame:CGRectMake(w * 5, 2, w * 2 - 5, 40)];
    [sumL setTextColor:[UIColor grayColor]];
    [sumL setText:[NSString stringWithFormat:@"%d/%lu", 0, (unsigned long)[[dicData objectForKey:[sectionKey objectAtIndex:section]] count]]];
    [sumL setTextAlignment:NSTextAlignmentRight];
    [sumL setFont:[UIFont systemFontOfSize:14]];
    [sumL setUserInteractionEnabled:NO];
    [headV addSubview:sumL];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:headV.bounds];
    btn.tag = section + 1;
    [headV addSubview:btn];
    [btn addTarget:self action:@selector(showRow:) forControlEvents:UIControlEventTouchUpInside];
    
    return headV;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
