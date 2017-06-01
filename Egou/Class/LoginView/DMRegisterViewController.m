//
//  DMRegisterViewController.m
//  LoginView
//
//  Created by SDC201 on 16/3/9.
//  Copyright © 2016年 PCEBG. All rights reserved.
//

#import "DMRegisterViewController.h"
#import "UITextField+Shake.h"
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>

@interface DMRegisterViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong)UILabel *ZCLabel;
@property (nonatomic ,strong)UIView *baceView;
@property (nonatomic ,strong)UITextField *phoneTextFiled;
@property (nonatomic ,strong)UITextField *verificationCodeTextFiled;
@property (nonatomic ,strong)UITextField *userNameTextFiled;
@property (nonatomic ,strong)UITextField *passwordTextFiled;

@property (nonatomic ,strong)UIButton *yzButton;
@property (nonatomic, copy) NSString *oUserPhoneNum;
@property (assign, nonatomic) NSInteger timeCount;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic ,strong)NSString *code;
//验证码
@property (copy, nonatomic) NSString *smsId;
@property (nonatomic ,strong)UIButton *backBtn;
@property (nonatomic ,strong)UILabel *loginLabel;

@end

@implementation DMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"注 册"];

    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    
    [self createTextFiled];
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createTextFiled
{
    _baceView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 200)];
    _baceView.layer.cornerRadius = 5.0;
    _baceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baceView];
    
    _userNameTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:13] placeholder:@"昵称由1-20位的字母或中文组成"];
    _userNameTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userNameTextFiled.delegate = self;
    [_baceView addSubview:_userNameTextFiled];
    
    _passwordTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 60, 200, 30) font:[UIFont systemFontOfSize:13] placeholder:@"密码为8-18位数字和字母组合"];
    _passwordTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextFiled.delegate = self;
    _passwordTextFiled.secureTextEntry = YES;
    _passwordTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_baceView addSubview:_passwordTextFiled];
    
    UILabel *userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    userNameLabel.text=@"昵  称";
    userNameLabel.textColor=[UIColor blackColor];
    userNameLabel.textAlignment=NSTextAlignmentLeft;
    userNameLabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:userNameLabel];
    
    UILabel *codelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
    codelabel.text=@"密  码";
    codelabel.textColor=[UIColor blackColor];
    codelabel.textAlignment=NSTextAlignmentLeft;
    codelabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:codelabel];
    
    _phoneTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 110, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入11位手机号"];
    _phoneTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextFiled.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextFiled.delegate = self;
    [_baceView addSubview:_phoneTextFiled];
    
    _verificationCodeTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 160, 90, 30) font:[UIFont systemFontOfSize:14] placeholder:@"短信验证码"];
    _verificationCodeTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verificationCodeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _verificationCodeTextFiled.delegate = self;
    _verificationCodeTextFiled.secureTextEntry = NO;
    [_baceView addSubview:_verificationCodeTextFiled];
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 112, 50, 25)];
    phonelabel.text=@"手机号";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=NSTextAlignmentLeft;
    phonelabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:phonelabel];
    
    UILabel *verificationCodeLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 162, 50, 25)];
    verificationCodeLabel.text=@"验证码";
    verificationCodeLabel.textColor=[UIColor blackColor];
    verificationCodeLabel.textAlignment=NSTextAlignmentLeft;
    verificationCodeLabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:verificationCodeLabel];
    
    _yzButton=[[UIButton alloc]initWithFrame:CGRectMake(_baceView.frame.size.width-120, 162, 100, 30)];
    //yzButton.layer.cornerRadius=3.0f;
    //yzButton.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    [_yzButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_yzButton setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    _yzButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_yzButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    [_baceView addSubview:_yzButton];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, _baceView.frame.size.width - 40, 1)];
    line1.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:0.3];
    [_baceView addSubview:line1];
    
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, _baceView.frame.size.width - 40, 1)];
    line2.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:0.3];
    [_baceView addSubview:line2];

    UIImageView *line3 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 150, _baceView.frame.size.width - 40, 1)];
    line3.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:0.3];
    [_baceView addSubview:line3];

    
    UIButton *registSubmitBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,_baceView.frame.size.height + _baceView.frame.origin.y + 30, _baceView.frame.size.width, 37)];
    [registSubmitBtn setTitle:@"注  册" forState:UIControlStateNormal];
    [registSubmitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registSubmitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [registSubmitBtn addTarget:self action:@selector(registSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    registSubmitBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    registSubmitBtn.layer.cornerRadius=5.0;
    [self.view addSubview:registSubmitBtn];
    
}

#pragma 正则匹配手机号
- (BOOL)checkTelNumber:(NSString *) telNumber{
    NSString *pattern = @"^1+[3578]+[0-9]{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}


#pragma 正则匹配用户密码8-18位数字和字母组合
- (BOOL)checkPassword:(NSString *) password{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{8,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
- (BOOL)checkUserName : (NSString *) userName{
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}

#pragma 正则匹配URL
- (BOOL)checkURL : (NSString *) url{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

#pragma 正则匹配验证码
- (BOOL)checkVerificationCode : (NSString *) verificationCode{
    NSString *pattern = @"^[0-9]{4}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:verificationCode];
    return isMatch;
}



-(void)getValidCode:(UIButton *)sender{
    NSScanner *scan = [NSScanner scannerWithString:_phoneTextFiled.text];
    int val;
    BOOL PureInt = [scan scanInt:&val]&&[scan isAtEnd];
    NSLog(@"%d",PureInt);
    
    if ([self checkUserInfo]) {
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTextFiled.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (nil != error) {
                NSLog(@"获取验证码失败");
            }else{
                _oUserPhoneNum =_phoneTextFiled.text;
                sender.userInteractionEnabled = YES;
                self.timeCount = 60;
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
            }
        }];
    }
}

-(void)reduceTime:(NSTimer *)codeTimer
{
    self.timeCount--;
    if (self.timeCount == 0) {
        [_yzButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [_yzButton setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        _yzButton.userInteractionEnabled = YES;
        [self.timer invalidate];
    } else {
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", self.timeCount];
        [_yzButton setTitle:str forState:UIControlStateNormal];
        _yzButton.userInteractionEnabled = NO;
        
    }
}

-(void)registSubmitBtnClick:(UIButton *)button{
    if ([self checkUserInfo]) {
        [SMSSDK commitVerificationCode:self.verificationCodeTextFiled.text phoneNumber:self.phoneTextFiled.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error){
            if (nil != error){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"手机号码或验证码有误" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}

- (BOOL) checkUserInfo{
    BOOL bValidUserInfo = NO;
    BOOL bValidUsername;
    BOOL bValidPhoneNumber;
    BOOL bValidPassword;
    
    bValidUsername = [self checkUserName:self.userNameTextFiled.text];
    bValidPassword = [self checkPassword:self.passwordTextFiled.text];
    bValidPhoneNumber = [self checkTelNumber:self.phoneTextFiled.text];
    
    if (!bValidUsername) {
        [_userNameTextFiled shake];
    }
    else if (!bValidPassword){
        [_passwordTextFiled shake];
    }
    else if (!bValidPhoneNumber){
        [_phoneTextFiled shake];
    }
    else{
        bValidUserInfo = YES;
    }
    
    return bValidUserInfo;
}

-(UITextField *)createTextFiledWithFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _phoneTextFiled) {
        [_phoneTextFiled resignFirstResponder];
    }
    if (textField == _verificationCodeTextFiled) {
        [_verificationCodeTextFiled resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.phoneTextFiled resignFirstResponder];
    [self.passwordTextFiled resignFirstResponder];
    [self.userNameTextFiled resignFirstResponder];
    [self.verificationCodeTextFiled resignFirstResponder];
}

@end
