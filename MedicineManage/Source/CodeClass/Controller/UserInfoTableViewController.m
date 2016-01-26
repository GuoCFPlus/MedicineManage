//
//  UserInfoTableViewController.m
//  MedicineManage
//
//  Created by lanou3g on 15/12/31.
//  Copyright © 2015年 gcf. All rights reserved.
//

#import "UserInfoTableViewController.h"

@interface UserInfoTableViewController ()

@end
static NSString * const userInfoCellID = @"userInfoCellID";
@implementation UserInfoTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:style]) {
        
        UIImage *img = [[UIImage imageNamed:@"iconfont-userInfo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imgHeight = [[UIImage imageNamed:@"iconfont-userInfoHeight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:img selectedImage:imgHeight];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

-(void)headDidLoad{
    //用户基本信息底层视图
    UIView *sView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    sView.backgroundColor = kColor;
    
    //头像
    UIImageView *headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-25, sView.frame.size.height/2-25, 50, 50)];
    headImgView.image = [UIImage imageNamed:@"AppIcon60x60"];
    headImgView.layer.cornerRadius = 25;
    headImgView.layer.masksToBounds = YES;
    [sView addSubview:headImgView];
    //用户名
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headImgView.frame)+10, kScreenWidth, 25)];
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 允许用户使用应用
        userNameLabel.text = currentUser.username;
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
        userNameLabel.text = @"游客";
        
    }
    
    userNameLabel.textColor = [UIColor whiteColor];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    userNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [sView addSubview:userNameLabel];
    
    //设置页头为用户基本信息底层视图
    self.tableView.tableHeaderView = sView;
    
    //设置页头页脚高度
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        return 3;
    }
    else
    {
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoCellID forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"我的收藏";
                    break;
                }
                case 1:
                {
                    cell.textLabel.text = @"我的发帖";
                    break;
                }
                case 2:
                {
                    cell.textLabel.text = @"我的动态";
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"修改密码";
                    break;
                }
                case 1:
                {
                    cell.textLabel.text = @"退出登录";
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //打开修改密码页面
                    FindPasswordViewController *findPasswordVC = [FindPasswordViewController new];
                    UINavigationController *findPasswordNC = [[UINavigationController alloc]initWithRootViewController:findPasswordVC];
                    findPasswordNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kColor};
                    findPasswordNC.navigationBar.tintColor = kColor;
                    //[self.navigationController pushViewController:findPasswordVC animated:YES];
                    [self presentViewController:findPasswordNC animated:YES completion:nil];
                    break;
                }
                case 1:
                {
                    [AVUser logOut];  //清除缓存用户对象
                    //打开用户登录界面…
                    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                    UINavigationController *loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
                    loginNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kColor};
                    loginNC.navigationBar.tintColor = kColor;
                    [self presentViewController:loginNC animated:YES completion:nil];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }

}


-(void)viewWillAppear:(BOOL)animated{
    
    //未登录时直接跳转登陆页面登录
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:userInfoCellID];
        [self headDidLoad];
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
        LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        loginNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kColor};
        loginNC.navigationBar.tintColor = kColor;
        [self presentViewController:loginNC animated:YES completion:nil];
        
    }
    
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
