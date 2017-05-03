//
//  DMRegisterThreeViewController.m
//  LoginView
//
//  Created by SDC201 on 16/3/9.
//  Copyright © 2016年 PCEBG. All rights reserved.
//

#import "DMRegisterThreeViewController.h"
#import "DMLoginViewController.h"
@interface DMRegisterThreeViewController ()<UIImagePickerControllerDelegate,UITextFieldDelegate>
@property (nonatomic ,strong)UIView *backView;
@property (nonatomic ,strong)UITextField *userName;
@property (nonatomic ,strong)UIButton *head;
@property (nonatomic ,strong)UIButton *backBtn;
@property (nonatomic ,strong)UILabel *loginLabel;

@end

@implementation DMRegisterThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册3/3";
//    self.navigationController.navigationBarHidden = YES;
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(5, 27, 35, 35);
    [_backBtn setImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_backBtn];
    
    //设置登录Label
    _loginLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 30)/2, 30, 50, 30)];
    _loginLabel.text = @"登录";
    _loginLabel.textColor = [UIColor colorWithRed:248/255.0 green:144/255.0 blue:34/255.0 alpha:1.0];
    _loginLabel.font = [UIFont systemFontOfSize:17];
//    [self.view addSubview:_loginLabel];
    
    [self createTextFileds];
    [self createUI];
}

-(void)createTextFileds
{
    CGRect frame=[UIScreen mainScreen].bounds;
    _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 270,frame.size.width, 50)];
    //bgView.layer.cornerRadius=3.0;
    _backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_backView];
    
    _userName= [[UITextField alloc]initWithFrame:CGRectMake(10, 10, _backView.frame.size.width - 20, 30)];
    _userName.delegate = self;
    _userName.placeholder = @"请设置昵称";
    _userName.font = [UIFont systemFontOfSize:14];
    _userName.textAlignment=NSTextAlignmentCenter;
    _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    UIButton *landBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, _backView.frame.size.height + _backView.frame.origin.y + 30, self.view.frame.size.width - 20, 37)];
    [landBtn setTitle:@"完成" forState:UIControlStateNormal];
    landBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [landBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [landBtn addTarget:self action:@selector(landClick) forControlEvents:UIControlEventTouchUpInside];
    landBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    landBtn.layer.cornerRadius=5.0f;
    
    [_backView addSubview:_userName];
    [self.view addSubview:landBtn];
}
-(void)createUI
{
    UIImageView *bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    [bg setImage:[UIImage imageNamed:@"mycenter_bg.png"]];
    bg.backgroundColor=[UIColor grayColor];
    [self.view addSubview:bg];
    
    _head=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-80)/2, 110, 80, 80)];
    [_head setImage:[UIImage imageNamed:@"ic_landing_nickname-2"] forState:UIControlStateNormal];
    _head.layer.cornerRadius=40;
    _head.layer.masksToBounds = YES;
    _head.backgroundColor=[UIColor whiteColor];
    [_head addTarget:self action:@selector(changeHeadView1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_head];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-80)/2, 180, 80, 80)];
    label.text=@"点击设置头像";
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:label];
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)landClick
{
    [self.navigationController pushViewController:[[DMLoginViewController alloc]init] animated:YES];
}
-(void)changeHeadView1:(UIButton *)tap
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更改头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self snapImage];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"从相册中上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self localPhoto];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)snapImage
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        __block UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        ipc.navigationBar.barTintColor =[UIColor whiteColor];
        ipc.navigationBar.tintColor = [UIColor whiteColor];
        ipc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        [self presentViewController:ipc animated:YES completion:^{
            ipc = nil;
        }];
    } else {
        NSLog(@"模拟器无法打开照相机");
    }
}
-(void)localPhoto
{
    __block UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    picker.navigationBar.barTintColor =[UIColor whiteColor];
    picker.navigationBar.tintColor = [UIColor blackColor];
    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [self presentViewController:picker animated:YES completion:^{
        picker = nil;
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //完成选择
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //NSLog(@"type:%@",type);
    if ([type isEqualToString:@"public.image"]) {
        //转换成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            //设置头像
            [_head setImage:image forState:UIControlStateNormal];
            //上传头像
            //[self updatePhotoFor:image];
        }];
        
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField = _userName;
    [_userName resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
