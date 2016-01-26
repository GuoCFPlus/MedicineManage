//
//  LoginViewController.m
//  MedicineManage
//
//  Created by lanou3g on 16/1/5.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"用户登录";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"快速注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    
}
//快速注册
-(void)registerAction{
    
    RegisterViewController *registerVC = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

//登录
- (IBAction)loginAction:(id)sender {
    
    [AVUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text block:^(AVUser *user, NSError *error) {
        UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录失败" preferredStyle:UIAlertControllerStyleAlert];
        if (user != nil) {
            loginAlert.message = @"登录成功";
        } else {
            loginAlert.message = [NSString stringWithFormat:@"%@",error.userInfo[@"error"]];
//            switch (error.code) {
//                case 210:
//                    loginAlert.message = @"用户名或密码错误";
//                    break;
//                case 211:
//                    loginAlert.message = @"不存在该用户";
//                    break;
//                default:
//                    DLog(@"登录失败，因为：%@",error);
//                    break;
//            }
        }
        //弹出提示框
        UIAlertAction *defultButton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([loginAlert.message isEqualToString:@"登录成功"]) {
                AVUser *currentUser = [AVUser currentUser];
                if (currentUser != nil) {
                    // 允许用户使用应用
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    //缓存用户对象为空时，可打开用户注册界面…
                    [self registerAction];
                    
                }
            }
            else
            {
                self.userNameTextField.text = @"";
                self.passwordTextField.text = @"";
                [self.userNameTextField becomeFirstResponder];
            }
        }];
        [loginAlert addAction:defultButton];
        [self presentViewController:loginAlert animated:YES completion:nil];

    }];
    
}
//找回密码
- (IBAction)findPasswordAction:(id)sender {
    
    FindPasswordViewController *findPasswordVC = [FindPasswordViewController new];
    [self.navigationController pushViewController:findPasswordVC animated:YES];
    
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
