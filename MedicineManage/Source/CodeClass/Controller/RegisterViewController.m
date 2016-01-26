//
//  RegisterViewController.m
//  MedicineManage
//
//  Created by lanou3g on 16/1/5.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"快速注册";
}
- (IBAction)registerAction:(id)sender {
    
    AVUser *user = [AVUser user];
    user.username = self.userNameTextField.text;
    user.password =  self.passwordTextField.text;
    user.email = self.emailTextField.text;
    [user setObject:@"186-1234-0000" forKey:@"phone"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //注册事件
        UIAlertController *registerAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册失败" preferredStyle:UIAlertControllerStyleAlert];
        if (succeeded) {
            registerAlert.message = @"注册成功";
        } else {
            registerAlert.message = [NSString stringWithFormat:@"%@",error.userInfo[@"error"]];
//            switch (error.code) {
//                case 125:
//                    registerAlert.message = @"请填写正确的邮箱地址";
//                    break;
//                default:
//                    DLog(@"注册失败，因为：%@",error);
//                    break;
//            }
        }
        
        //弹出提示框
        UIAlertAction *defultButton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([registerAlert.message isEqualToString:@"注册成功"]) {
                //跳转到登陆页
                [self.navigationController popViewControllerAnimated:YES];
                //打开首页
                //[self dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                self.emailTextField.text = @"";
                [self.emailTextField becomeFirstResponder];
            }
        }];
        [registerAlert addAction:defultButton];
        [self presentViewController:registerAlert animated:YES completion:nil];
    }];
    
    
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
