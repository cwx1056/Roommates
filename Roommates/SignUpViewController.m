//
//  SignUpViewController.m
//  Roommates
//
//  Created by Zhang Boxuan on 14-5-24.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@property (strong, nonatomic) UIView *v_loginInfo;
@property (strong, nonatomic) UIView *v_loginInfoInput;

@property (strong, nonatomic) UITextField *tv_username;
@property (strong, nonatomic) UITextField *tv_password;
@property (strong, nonatomic) UITextField *tv_passwordConfirm;
@property (strong, nonatomic) UITextField *tv_email;

@end

@implementation SignUpViewController

- (void)viewWillLayoutSubviews
{
    //init loginInfo view
    self.v_loginInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.v_loginInfo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"signUp1"]];
    [self.view addSubview:self.v_loginInfo];
    
    self.v_loginInfoInput = [[UIView alloc] initWithFrame:CGRectMake(36.0, 235.0, 248.0, 254.0)];
    self.v_loginInfoInput.backgroundColor = [UIColor colorWithRed:48.0/255.0 green:69.0/255.0 blue:90.0/255.0 alpha:1.0];
    [self.v_loginInfo addSubview:_v_loginInfoInput];
    
    [self setLoginInfoInputView];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 530, 160, 22)];
    cancelBtn.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:151.0/255.0 blue:29.0/255.0 alpha:1.0];
    [cancelBtn setTitle:@"取    消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    [cancelBtn addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLoginInfoInputView
{
    UIButton *signUpBtn = [[UIButton alloc] initWithFrame:CGRectMake(44.0, 214.0, 160, 22)];
    signUpBtn.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:151.0/255.0 blue:29.0/255.0 alpha:1.0];
    [signUpBtn setTitle:@"注   册" forState:UIControlStateNormal];
    signUpBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    [signUpBtn addTarget:self action:@selector(clickSignUpButton) forControlEvents:UIControlEventTouchUpInside];
    [self.v_loginInfoInput addSubview:signUpBtn];
    
    self.tv_username = [[UITextField alloc] initWithFrame:CGRectMake(22.0, 26.0, 204.0, 28.0)];
    self.tv_username.borderStyle = UITextBorderStyleNone;
    self.tv_username.backgroundColor = [UIColor whiteColor];
    self.tv_username.placeholder = @"用户名";
    self.tv_username.returnKeyType = UIReturnKeyNext;
    self.tv_username.font = [UIFont systemFontOfSize:12.0];
    self.tv_username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.tv_username.leftView = view1;
    self.tv_username.leftViewMode = UITextFieldViewModeAlways;
    self.tv_username.leftView.userInteractionEnabled = NO;
    self.tv_username.delegate = self;
    [self.v_loginInfoInput addSubview:self.tv_username];
    
    self.tv_password = [[UITextField alloc] initWithFrame:CGRectMake(22.0, 72.0, 204.0, 28.0)];
    self.tv_password.borderStyle = UITextBorderStyleNone;
    self.tv_password.backgroundColor = [UIColor whiteColor];
    self.tv_password.placeholder = @"密码";
    self.tv_password.returnKeyType = UIReturnKeyNext;
    self.tv_password.font = [UIFont systemFontOfSize:12.0];
    self.tv_password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.tv_password.secureTextEntry = YES;
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.tv_password.leftView = view2;
    self.tv_password.leftViewMode = UITextFieldViewModeAlways;
    self.tv_password.leftView.userInteractionEnabled = NO;
    self.tv_password.delegate = self;
    [self.v_loginInfoInput addSubview:self.tv_password];
    
    self.tv_passwordConfirm = [[UITextField alloc] initWithFrame:CGRectMake(22.0, 118.0, 204.0, 28.0)];
    self.tv_passwordConfirm.borderStyle = UITextBorderStyleNone;
    self.tv_passwordConfirm.backgroundColor = [UIColor whiteColor];
    self.tv_passwordConfirm.placeholder = @"确认密码";
    self.tv_passwordConfirm.returnKeyType = UIReturnKeyNext;
    self.tv_passwordConfirm.font = [UIFont systemFontOfSize:12.0];
    self.tv_passwordConfirm.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.tv_passwordConfirm.secureTextEntry = YES;
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.tv_passwordConfirm.leftView = view3;
    self.tv_passwordConfirm.leftViewMode = UITextFieldViewModeAlways;
    self.tv_passwordConfirm.leftView.userInteractionEnabled = NO;
    self.tv_passwordConfirm.delegate = self;
    [self.v_loginInfoInput addSubview:self.tv_passwordConfirm];
    
    self.tv_email = [[UITextField alloc] initWithFrame:CGRectMake(22.0, 164.0, 204.0, 28.0)];
    self.tv_email.borderStyle = UITextBorderStyleNone;
    self.tv_email.backgroundColor = [UIColor whiteColor];
    self.tv_email.placeholder = @"邮箱";
    self.tv_email.keyboardType = UIKeyboardTypeEmailAddress;
    self.tv_email.returnKeyType = UIReturnKeyDone;
    self.tv_email.font = [UIFont systemFontOfSize:12.0];
    self.tv_email.autocapitalizationType = UITextAutocapitalizationTypeNone;
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.tv_email.leftView = view4;
    self.tv_email.leftViewMode = UITextFieldViewModeAlways;
    self.tv_email.leftView.userInteractionEnabled = NO;
    self.tv_email.delegate = self;
    [self.v_loginInfoInput addSubview:self.tv_email];
}

- (void)clickSignUpButton
{
    NSLog(@"signUp");
    
    if(self.tv_username.text.length != 0 && self.tv_password.text.length != 0 && self.tv_passwordConfirm.text.length != 0
       && self.tv_email.text.length != 0 )
    {
        if([self.tv_password.text isEqualToString:self.tv_passwordConfirm.text])
        {
            PFUser *newUser = [PFUser user];
            newUser.username = self.tv_username.text;
            newUser.password = self.tv_password.text;
            newUser.email = self.tv_email.text;
            
            
            [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                    if(!error)
                                                    {
                                                        NSLog(@"注册成功");
                                                    }else
                                                    {
                                                        NSString *errorString = [error userInfo][@"error"];
                                                        NSLog(@"%@", errorString);
                                                        if(error.code == 202)
                                                        {
                                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                                            message:@"用户名已存在，请重新输入"
                                                                                                           delegate:self
                                                                                                  cancelButtonTitle:@"确定"
                                                                                                  otherButtonTitles:nil];
                                                            [alert show];
                                                            
                                                            NSTimeInterval animationDuration = 0.30f;
                                                            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
                                                            [UIView setAnimationDuration:animationDuration];
                                                            
                                                            self.v_loginInfo.frame = CGRectMake(0.0, 0, 320, 568);
                                                            
                                                            [UIView commitAnimations];
                                                            
                                                        }
                                                    }
                                                }];
            
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"两次密码不一致，请重新输入"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            
            NSTimeInterval animationDuration = 0.30f;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            
            self.v_loginInfo.frame = CGRectMake(0.0, 0, 320, 568);
            
            [UIView commitAnimations];
        }
        
        
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"请输入完整信息"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)clickCancelButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
     
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //hide keyboard
    [self.tv_username resignFirstResponder];
    [self.tv_password resignFirstResponder];
    [self.tv_passwordConfirm resignFirstResponder];
    [self.tv_email resignFirstResponder];
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    self.v_loginInfoInput.frame = CGRectMake(self.v_loginInfoInput.frame.origin.x, 235.0, self.v_loginInfoInput.frame.size.width, self.v_loginInfoInput.frame.size.height);
    [UIView commitAnimations];
}

#define MOVE_HEIGHT 40
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect originFrame1 = self.v_loginInfoInput.frame;
    float offset = originFrame1.origin.y + MOVE_HEIGHT +originFrame1.size.height - (self.view.frame.size.height - 216.0);
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if(offset > 0)
    {
        CGRect rect1 = CGRectMake(originFrame1.origin.x, originFrame1.origin.y - offset, self.v_loginInfoInput.frame.size.width, self.v_loginInfoInput.frame.size.height);
        self.v_loginInfoInput.frame = rect1;
    }
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.tv_username)
    {
        [self.tv_password becomeFirstResponder];
    }else if(textField == self.tv_password)
    {
        [self.tv_passwordConfirm becomeFirstResponder];
    }else if(textField == self.tv_passwordConfirm)
    {
        [self.tv_email becomeFirstResponder];
    }else if(textField == self.tv_email)
    {
        [self.tv_email resignFirstResponder];
        
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        self.v_loginInfoInput.frame = CGRectMake(self.v_loginInfoInput.frame.origin.x, 235.0, self.v_loginInfoInput.frame.size.width, self.v_loginInfoInput.frame.size.height);
        [UIView commitAnimations];
    }
    
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
