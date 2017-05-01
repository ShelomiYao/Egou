//
//  ForgotPassWordViewController.m
//  LoginView
//
//  Created by SDC201 on 16/3/10.
//  Copyright © 2016年 PCEBG. All rights reserved.
//

#import "ForgotPassWordViewController.h"
#import "UITextField+Shake.h"
#import "GetPassWordViewController.h"
@interface ForgotPassWordViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong)UILabel *ZCLabel;
@property (nonatomic ,strong)UIView *baceView;
@property (nonatomic ,strong)UITextField *phoneTextFiled;
@property (nonatomic ,strong)UITextField *pwdTextFiled;
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
    self.title = @"找回密码1/2";
    self.navigationController.navigationBarHidden = YES;
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(5, 27, 35, 35);
    [_backBtn setImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    //设置登陆Label
    _loginLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 50)/2, 30, 80, 30)];
    _loginLabel.text = @"重置密码";
    _loginLabel.textColor = [UIColor colorWithRed:248/255.0 green:144/255.0 blue:34/255.0 alpha:1.0];
    _loginLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_loginLabel];
    
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
    
    _baceView = [[UIView alloc]initWithFrame:CGRectMake(10, 110, self.view.frame.size.width - 20, 100)];
    _baceView.layer.cornerRadius = 5.0;
    _baceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baceView];
    
    _phoneTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入11位手机号"];
    _phoneTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextFiled.delegate = self;
    [_baceView addSubview:_phoneTextFiled];
    
    _pwdTextFiled = [self createTextFiledWithFrame:CGRectMake(100, 60, 90, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入4位验证码"];
    _pwdTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTextFiled.delegate = self;
    _pwdTextFiled.secureTextEntry = YES;
    [_baceView addSubview:_pwdTextFiled];
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text=@"手机号";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=NSTextAlignmentLeft;
    phonelabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:phonelabel];
    
    UILabel *codelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
    codelabel.text=@"验证码";
    codelabel.textColor=[UIColor blackColor];
    codelabel.textAlignment=NSTextAlignmentLeft;
    codelabel.font=[UIFont systemFontOfSize:14];
    [_baceView addSubview:codelabel];
    
    _yzButton=[[UIButton alloc]initWithFrame:CGRectMake(_baceView.frame.size.width-100-20, 62, 100, 30)];
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
    
    UIButton *landBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,_baceView.frame.size.height + _baceView.frame.origin.y + 30, _baceView.frame.size.width - 20, 37)];
    [landBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [landBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    landBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [landBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    landBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    landBtn.layer.cornerRadius=5.0;
    [self.view addSubview:landBtn];
    
}
-(void)getValidCode:(UIButton *)sender
{
    NSScanner *scan = [NSScanner scannerWithString:_phoneTextFiled.text];
    int val;
    BOOL PureInt = [scan scanInt:&val]&&[scan isAtEnd];
    NSLog(@"%d",PureInt);
    if (!PureInt || _phoneTextFiled.text.length !=11)
    {
        [_phoneTextFiled shake];
    }
    else
    {
        _oUserPhoneNum =_phoneTextFiled.text;
        //__weak MMZCHMViewController *weakSelf = self;
        sender.userInteractionEnabled = YES;
        self.timeCount = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
        _code = [NSString stringWithFormat:@"%i%i%i%i",arc4random()%10,arc4random()%10,arc4random()%10,arc4random()%10];
        NSLog(@"%@",_code);
        _pwdTextFiled.text = _code;
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
-(void)next:(UIButton *)button
{
    if (_phoneTextFiled.text.length == 11 && _pwdTextFiled.text == _code) {
        GetPassWordViewController *vc = [[GetPassWordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else{
        [_pwdTextFiled shake];
        [_phoneTextFiled shake];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号码和验证码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
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
    if (textField == _pwdTextFiled) {
        [_pwdTextFiled resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
