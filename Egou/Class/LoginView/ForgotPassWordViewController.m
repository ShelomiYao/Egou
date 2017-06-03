//
//  ForgotPassWordViewController.m
//  LoginView
//
//  Created by SDC201 on 16/3/10.
//  Copyright © 2016年 PCEBG. All rights reserved.
//

#import "ForgotPassWordViewController.h"
#import "UITextField+Shake.h"
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>

@interface ForgotPassWordViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong)UILabel *ZCLabel;
@property (nonatomic ,strong)UIView *baceView;
@property (nonatomic ,strong)UITextField *NewPwdTextFiled;
@property (nonatomic ,strong)UITextField *phoneTextFiled;
@property (nonatomic ,strong)UITextField *verificationCodeTextFiled;
@property (nonatomic ,strong)UIButton *yzButton;
@property(nonatomic, copy) NSString *oUserPhoneNum;
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;
@property(nonatomic ,strong)NSString *code;
//验证码
@property(copy, nonatomic) NSString *smsId;
@property (nonatomic ,strong)UIButton *backBtn;
@property (nonatomic ,strong)UILabel *loginLabel;

@end

@implementation ForgotPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"重置密码"];
 
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
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请输入11位手机号";
    label.textColor=[UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    _baceView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 150)];
    _baceView.layer.cornerRadius = 5.0;
    _baceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baceView];
    
    _NewPwdTextFiled= [self createTextFiledWithFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入新密码"];
    _NewPwdTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _NewPwdTextFiled.delegate = self;
    _NewPwdTextFiled.secureTextEntry = YES;
    _NewPwdTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_baceView addSubview:_NewPwdTextFiled];
    
    _phoneTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 60, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入11位手机号"];
    _phoneTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextFiled.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextFiled.delegate = self;
    [_baceView addSubview:_phoneTextFiled];
    
    _verificationCodeTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 110, 90, 30) font:[UIFont systemFontOfSize:14] placeholder:@"短信验证码"];
    _verificationCodeTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verificationCodeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _verificationCodeTextFiled.delegate = self;
    _verificationCodeTextFiled.secureTextEntry = NO;
    [_baceView addSubview:_verificationCodeTextFiled];
    
    UILabel *newPasswordLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    newPasswordLabel.text=@"新密码";
    newPasswordLabel.textColor=[UIColor blackColor];
    newPasswordLabel.textAlignment=NSTextAlignmentLeft;
    newPasswordLabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:newPasswordLabel];
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
    phonelabel.text=@"手机号";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=NSTextAlignmentLeft;
    phonelabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:phonelabel];
    
    UILabel *codelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 112, 50, 25)];
    codelabel.text=@"验证码";
    codelabel.textColor=[UIColor blackColor];
    codelabel.textAlignment=NSTextAlignmentLeft;
    codelabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:codelabel];
    
    _yzButton=[[UIButton alloc]initWithFrame:CGRectMake(_baceView.frame.size.width-120, 112, 100, 30)];
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
    
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,_baceView.frame.size.height + _baceView.frame.origin.y + 30, _baceView.frame.size.width, 37)];
    [submitBtn setTitle:@"完 成" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    submitBtn.layer.cornerRadius=5.0;
    [self.view addSubview:submitBtn];
    
}

#pragma 正则匹配手机号
- (BOOL)checkTelNumber:(NSString *) telNumber{
    NSString *pattern = @"^1+[3578]+[0-9]{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}


#pragma 正则匹配用户密码6-18位数字和字母组合
- (BOOL)checkPassword:(NSString *) password{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

-(void)getValidCode:(UIButton *)sender
{
    NSScanner *scan = [NSScanner scannerWithString:_phoneTextFiled.text];
    int val;
    BOOL PureInt = [scan scanInt:&val]&&[scan isAtEnd];
    NSLog(@"%d",PureInt);
    
    if ([self checkUserInfo]) {
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTextFiled.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (nil != error) {
                NSString *alertMessage = @"获取验证码失败";
                [self showAlert:alertMessage];
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

-(void)submitBtnClick:(UIButton *)button
{
    if ([self checkUserInfo]) {
        [SMSSDK commitVerificationCode:self.verificationCodeTextFiled.text phoneNumber:self.phoneTextFiled.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error){
            if (nil != error){
                [self showAlert:@"手机号码或验证码有误"];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重置密码成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
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
    BOOL bValidPhoneNumber;
    BOOL bValidPassword;
    BOOL bPhoneRegiste = NO;
    NSArray *userPhoneArr = @[@"18866668888",@"16800009999",@"15078331961"];

    bValidPassword = [self checkPassword:self.NewPwdTextFiled.text];
    bValidPhoneNumber = [self checkTelNumber:self.phoneTextFiled.text];
    
    if (!bValidPassword){
        [_NewPwdTextFiled shake];
    }
    if (!bValidPhoneNumber){
        [_phoneTextFiled shake];
    }
    else{
        for (int i = 0; i < userPhoneArr.count; i++) {
            if ([_phoneTextFiled.text isEqualToString:userPhoneArr[i]]) {
                bPhoneRegiste = YES;
                break;
            }
        }
        if (!bPhoneRegiste) {
            bValidPhoneNumber = NO;
            [_phoneTextFiled shake];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该号码没有注册" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }

    }
    
    if (bValidPhoneNumber && bValidPassword){
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
    [self.NewPwdTextFiled resignFirstResponder];
    [self.verificationCodeTextFiled resignFirstResponder];
}

-(void)showAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
