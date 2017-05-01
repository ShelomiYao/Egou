//
//  DMLoginViewController.m
//  LoginView
//
//  Created by SDC201 on 16/3/9.
//  Copyright © 2016年 PCEBG. All rights reserved.
//

#import "DMLoginViewController.h"
#import "UITextField+Shake.h"
#import "DMRegisterViewController.h"
#import "ForgotPassWordViewController.h"
@interface DMLoginViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong)UIImageView *imageView;
@property (nonatomic ,strong)UIButton *backBtn;
@property (nonatomic ,strong)UIButton *registerBtn;
@property (nonatomic ,strong)UILabel *loginLabel;
@property (nonatomic ,strong)UIView *backView;
@property (nonatomic ,strong)UITextField *phoneTextFiled;
@property (nonatomic ,strong)UITextField *passwordTextFiled;
@property (nonatomic ,strong)UIButton *QQBtn;
@property (nonatomic ,strong)UIButton *WeiXinBtn;
@property (nonatomic ,strong)UIButton *XinLangBtn;
@end

@implementation DMLoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _imageView.image = [UIImage imageNamed:@"bg4"];
    [self.view addSubview:_imageView];
    
    //设置返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(5, 27, 35, 35);
    [_backBtn setImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    //设置注册按钮
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.frame = CGRectMake(self.view.frame.size.width - 60, 30, 50, 30);
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor colorWithRed:248/255.0 green:144/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    //设置登陆Label
    _loginLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 30)/2, 30, 50, 30)];
    _loginLabel.text = @"登  陆";
    _loginLabel.textColor = [UIColor colorWithRed:248/255.0 green:144/255.0 blue:34/255.0 alpha:1.0];
    _loginLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_loginLabel];
    
    //为登陆界面添加TextfFiled
    [self createTextFileds];
    
    //为登陆界面添加Button
    [self createButtons];
    
    //为登陆界面添加Label
    [self createLabel];
    
    //为登陆界面添加横线
    [self createImageView];
    
}
//返回按钮点击事件
-(void)backBtnClick:(UIButton *)button
{
    exit(0);
}
//注册按钮点击事件
-(void)registerBtnClick
{
    DMRegisterViewController *vc = [[DMRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)createTextFileds
{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(10, 75, self.view.frame.size.width - 20, 100)];
    _backView.layer.cornerRadius = 5.0;
    _backView.alpha = 0.7;
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    _phoneTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, 271, 30)];
    _phoneTextFiled.delegate = self;
    _phoneTextFiled.placeholder = @"请输入11位手机号";
    _phoneTextFiled.font = [UIFont systemFontOfSize:14];
    _phoneTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_backView addSubview:_phoneTextFiled];
    
    _passwordTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(60, 60, 271, 30)];
    _passwordTextFiled.delegate = self;
    _passwordTextFiled.placeholder = @"请输入您的密码";
    _passwordTextFiled.font = [UIFont systemFontOfSize:14];
    _passwordTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextFiled.secureTextEntry = YES;
    [_backView addSubview:_passwordTextFiled];
    
    UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 25, 25)];
    phoneImageView.image = [UIImage imageNamed:@"ic_landing_nickname"];
    [_backView addSubview:phoneImageView];
    UIImageView *passwordImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 60, 25, 25)];
    passwordImageView.image= [UIImage imageNamed:@"mm_normal"];
    [_backView addSubview:passwordImageView];
    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, _backView.frame.size.width - 40, 1)];
    lineImageView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:0.3];
    [_backView addSubview:lineImageView];
}
-(void)createButtons
{
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(5, 235, 70, 30);
    [registerButton setTitle:@"快速注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(10, 190, self.view.frame.size.width - 20, 37);
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setBackgroundColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1]];
    [self.view addSubview:loginButton];
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.frame = CGRectMake(self.view.frame.size.width - 75, 235, 60, 30);
    [forgetButton setTitle:@"找回密码" forState:UIControlStateNormal];
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgetButton addTarget:self action:@selector(forgotPwdButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetButton];
    
    _QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _QQBtn.frame = CGRectMake((self.view.frame.size.width - 50)/2, 440, 50, 50);
    _QQBtn.layer.cornerRadius = 25;
    [_QQBtn setBackgroundImage:[UIImage imageNamed:@"ic_landing_qq"] forState:UIControlStateNormal];
    [_QQBtn addTarget:self action:@selector(QQBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_QQBtn];
    
    _WeiXinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _WeiXinBtn.frame = CGRectMake((self.view.frame.size.width - 50)/2 - 100, 440, 50, 50);
    _WeiXinBtn.layer.cornerRadius = 25;
    [_WeiXinBtn setBackgroundImage:[UIImage imageNamed:@"ic_landing_wechat"] forState:UIControlStateNormal];
    [_WeiXinBtn addTarget:self action:@selector(WeiXinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_WeiXinBtn];
    
    _XinLangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _XinLangBtn.frame = CGRectMake((self.view.frame.size.width - 50)/2 + 100, 440, 50, 50);
    _XinLangBtn.layer.cornerRadius = 25;
    [_XinLangBtn setBackgroundImage:[UIImage imageNamed:@"ic_landing_microblog"] forState:UIControlStateNormal];
    [_XinLangBtn addTarget:self action:@selector(XinLangBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_XinLangBtn];
    
    
}
-(void)createLabel
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 140)/2, 390, 140, 21)];
    label.text = @"第三方账号快速登陆";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
}
-(void)createImageView
{
    UIImageView *lineImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(2, 400, 100, 1)];
    lineImageView1.backgroundColor = [UIColor lightGrayColor];
    UIImageView *lineImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100 - 4, 400, 100, 1)];
    lineImageView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineImageView1];
    [self.view addSubview:lineImageView2];
}
-(void)registerButtonClick:(UIButton *)button
{
    DMRegisterViewController *vc = [[DMRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)loginButtonClick:(UIButton *)button
{
    if (_phoneTextFiled.text.length == 11 && _passwordTextFiled.text.length <= 16 && _passwordTextFiled.text.length >= 8) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登陆" message:@"恭喜你登陆成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if (_passwordTextFiled.text.length < 8 || _passwordTextFiled.text.length > 16) {
        [_passwordTextFiled shake];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的密码格式" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if (_phoneTextFiled.text.length != 11) {
        [_phoneTextFiled shake];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
-(void)forgotPwdButtonClick:(UIButton *)button
{
    ForgotPassWordViewController *vc = [[ForgotPassWordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)QQBtnClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"QQ登陆" message:@"该功能正在开发，给你带来不便请见谅" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)WeiXinBtnClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"微信登陆" message:@"该功能正在开发，给你带来不便请见谅" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)XinLangBtnClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新浪微博登陆" message:@"该功能正在开发，给你带来不便请见谅" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark UITextFiledDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _phoneTextFiled) {
        [_phoneTextFiled resignFirstResponder];
    }
    if (textField == _passwordTextFiled) {
        [_passwordTextFiled resignFirstResponder];
    }
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
