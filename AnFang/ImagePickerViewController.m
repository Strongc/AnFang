//
//  ImagePickerViewController.m
//  AnFang
//
//  Created by mac   on 15/10/16.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "ImagePickerViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"

@interface ImagePickerViewController ()
{
    UITableView *typeTable;

}


@end

@implementation ImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT/667, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"图片选择";
    title.textColor = [UIColor whiteColor];
    [headView addSubview:title];
    [self.view addSubview:headView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*WIDTH/375, 30*HEIGHT/667, 60*WIDTH/375, 30*HEIGHT/667)];
    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(18*WIDTH/375, 7*HEIGHT/667, 32, 16)];
    backTitle.textAlignment = NSTextAlignmentCenter;
    backTitle.text = @"返回";
    backTitle.font = [UIFont systemFontOfSize:16];
    backTitle.textColor = [UIColor whiteColor];
    [backBtn addSubview:backTitle];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5*HEIGHT/667, 20, 20)];
    backImage.image = [UIImage imageNamed:@"back.png"];
    [backBtn addSubview:backImage];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    typeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 100*HEIGHT/667) style:UITableViewStylePlain];
    typeTable.delegate = self;
    typeTable.dataSource = self;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 100*HEIGHT/667, WIDTH, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [typeTable addSubview:line];
    [self.view addSubview:typeTable];
    typeTable.scrollEnabled = NO;
    //self.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)takePhoto:(UIImagePickerControllerSourceType)type
{
    
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && type == UIImagePickerControllerSourceTypeCamera)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.showsCameraControls = YES;
        imagePicker.toolbarHidden = YES;
        imagePicker.navigationBarHidden = YES;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.navigationBar.translucent = NO;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
    
    else
    {
        CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
        picker.showsCancelButton         = YES;
        picker.delegate                  = self;
        picker.showsNumberOfAssets       = NO;
        picker.navigationController.navigationBar.translucent = NO;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

//当得到该图片后调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    UIImage *theImage = nil;
    theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //保存图片
    SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
    UIImageWriteToSavedPhotosAlbum(theImage, self, selectorToCall, NULL);
    
    [picker dismissModalViewControllerAnimated:YES];
}

//保存图片到相册
- (void)imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo
{
    if (paramError == nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//当用户取消时调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma CTAssetsPickerController
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    NSMutableArray* arrayMutable = picker.selectedAssets;
    
    NSMutableArray* arrayMutable2 = [NSMutableArray arrayWithCapacity:arrayMutable.count];
    
    for (ALAsset* alasset in arrayMutable) {
        [arrayMutable2 insertObject:[UIImage imageWithCGImage:alasset.thumbnail] atIndex:arrayMutable2.count];
    }
    
    [self.delegate flushImageViews:arrayMutable2];
       
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentifier = @"cell";
    
    UITableViewCell *cell =(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
       
    }

    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20*WIDTH/375, 5*HEIGHT/667, 200*WIDTH/375, 35*HEIGHT/667)];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:titleLab];
    
    
    switch (indexPath.row) {
        case 0:
            
            titleLab.text = @"从相册中选择";
            break;
            
        default:
            titleLab.text = @"拍一张";
            break;
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            [self takePhoto:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case 1:
            [self takePhoto:UIImagePickerControllerSourceTypeCamera];
            break;
    }
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
