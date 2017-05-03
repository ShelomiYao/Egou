//
//  GetPassWordViewController.m
//  LoginView
//
//  Created by SDC201 on 16/3/10.
//  Copyright © 2016年 PCEBG. All rights reserved.
//

#import "GetPassWordViewController.h"
#import "UITextField+Shake.h"
#import "DMLoginViewController.h"
@interface GetPassWordViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong)UIView *backView;
@property (nonatomic ,strong)UITextField *pwdTextFiled;
@property (nonatomic ,strong)UIButton *backBtn;
@property (nonatomic ,strong)UILabel *loginLabel;

@end

@implementation GetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"找回密码2/2"];

//    self.title = @"找回密码2/2";
//    self.navigationController.navigationBarHidden = YES;
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(5, 27, 35, 35);
    [_backBtn setImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_backBtn];
    
    //设置登录Label
    _loginLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 60)/2, 30, 100, 30)];
    _loginLabel.text = @"设置新密码";
    _loginLabel.textColor = [UIColor colorWithRed:248/255.0 green:144/255.0 blue:34/255.0 alpha:1.0];
    _loginLabel.font = [UIFont systemFontOfSize:17];
//    [self.view addSubview:_loginLabel];
    
    [self createTextFileds];
}
-(void)createTextFileds
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请设置新密码";
    label.textColor=[UIColor grayColor];
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(10, 110, self.view.frame.size.width - 20, 50)];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 5.0;
    [self.view addSubview:_backView];
    
    _pwdTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 200, 30)];
    _pwdTextFiled.delegate = self;
    _pwdTextFiled.placeholder = @"8到16位的数字或字母";
    _pwdTextFiled.font = [UIFont systemFontOfSize:14];
    _pwdTextFiled.secureTextEntry = YES;
    _pwdTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_backView addSubview:_pwdTextFiled];
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text=@"密码";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=NSTextAlignmentLeft;
    phonelabel.font=[UIFont systemFontOfSize:14];
    
    UIButton *landBtn= [[UIButton alloc]initWithFrame:CGRectMake(10, _backView.frame.size.height + _backView.frame.origin.y + 30, self.view.frame.size.width - 20, 37)];
    [landBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [landBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    landBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [landBtn addTarget:self action:@selector(landClick) forControlEvents:UIControlEventTouchUpInside];
    landBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    landBtn.layer.cornerRadius=5.0f;
    
    [_backView addSubview:phonelabel];
    [self.view addSubview:landBtn];
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)landClick
{
    if (_pwdTextFiled.text.length < 8 || _pwdTextFiled.text.length >16) {
        [_pwdTextFiled shake];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入长度为8-16的密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        DMLoginViewController *vc = [[DMLoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField = _pwdTextFiled;
    [_pwdTextFiled resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
