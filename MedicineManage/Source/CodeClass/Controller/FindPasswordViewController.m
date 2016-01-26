//
//  FindPasswordViewController.m
//  MedicineManage
//
//  Created by lanou3g on 16/1/6.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import "FindPasswordViewController.h"

@interface FindPasswordViewController ()

@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"修改密码";
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithTitle:@"< 返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
    self.navigationItem.leftBarButtonItem = leftBarButton;

    
}

-(void)returnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//向邮箱发送验证链接
- (IBAction)nextAction:(id)sender {
    
    [AVUser requestPasswordResetForEmailInBackground:self.emailTextField.text block:^(BOOL succeeded, NSError *error) {
        UIAlertController *findAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"邮件发送失败" preferredStyle:UIAlertControllerStyleAlert];
        if (succeeded) {
            //跳转到重置密码页面
            findAlert.message = @"邮件已发送，请查收";
        } else {
            findAlert.message = [NSString stringWithFormat:@"%@",error.userInfo[@"error"]];
//            switch (error.code) {
//                case 205:
//                    findAlert.message = @"邮箱填写错误，请重新输入";
//                    break;
//                default:
//                    DLog(@"邮件发送失败，因为：%@",error);
//                    break;
//            }
        }
        //弹出提示框
        UIAlertAction *defultButton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([findAlert.message isEqualToString:@"邮件已发送，请查收"]) {
                
                AVUser *currentUser = [AVUser currentUser];
                if (currentUser != nil) {
                    //如果是登陆之后修改密码，则清除缓存
                    [AVUser logOut];
                    //关闭当前页面
                    [self dismissViewControllerAnimated:YES completion:nil];
               } else {
                    //如果是没有登录找回密码，返回到登陆页
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                
            }
            else
            {
                self.emailTextField.text = @"";
                [self.emailTextField becomeFirstResponder];
            }
        }];
        [findAlert addAction:defultButton];
        [self presentViewController:findAlert animated:YES completion:nil];
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
