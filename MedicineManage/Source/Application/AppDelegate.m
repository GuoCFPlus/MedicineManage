//
//  AppDelegate.m
//  MedicineManage
//
//  Created by lanou3g on 15/12/31.
//  Copyright © 2015年 gcf. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()<UITabBarControllerDelegate>
@property(strong,nonatomic) UITabBarController *tabBC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //网络判断对象
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    //开启网络状态判断通知
    [reachability startNotifier];
    
    //LeanCloud
    //如果使用美国站点，请加上这行代码 [AVOSCloud useAVCloudUS];
    [AVOSCloud setApplicationId:@"knw1FBudwV7WON1GHyqPfivO-gzGzoHsz"
                      clientKey:@"CsqnKyEzRXE2opCLw7QYMA04"];
    //跟踪统计应用的打开情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    //设置self.window为主窗口并显示
    [self.window makeKeyAndVisible];
    
    //子视图控制器
    //学术圈
    AcademicTableViewController *academicVC = [[AcademicTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *academicNC = [[UINavigationController alloc]initWithRootViewController:academicVC];
    academicNC.navigationBar.barTintColor = kColor;
    academicNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};

    
    //病例
    CaseTableViewController *caseVC = [[CaseTableViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *caseNC = [[UINavigationController alloc]initWithRootViewController:caseVC];
    caseNC.navigationBar.barTintColor = kColor;
    caseNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    
    //论坛
    ForumTableViewController *forumVC = [[ForumTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *forumNC = [[UINavigationController alloc]initWithRootViewController:forumVC];
    forumNC.navigationBar.barTintColor = kColor;
    forumNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    //消息
    MessageTableViewController *messageVC = [[MessageTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *messageNC = [[UINavigationController alloc]initWithRootViewController:messageVC];
    messageNC.navigationBar.barTintColor = kColor;
    messageNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    //我的
    UserInfoTableViewController *userInfoVC = [[UserInfoTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *userInfoNC = [[UINavigationController alloc]initWithRootViewController:userInfoVC];
    userInfoNC.navigationBar.barTintColor = kColor;
    userInfoNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};

    //设置根视图控制器
    self.tabBC = [[UITabBarController alloc]init];
    self.tabBC.viewControllers = @[academicNC,caseNC,userInfoVC];//forumNC,messageNC,
    
    //选中后的字体颜色
    self.tabBC.tabBar.tintColor = kColor;
    
    //设置默认选中下标
    self.tabBC.selectedIndex = 0;
    //代理
    self.tabBC.delegate = self;
    
    //tabBar默认高度49
  
    [self.window setRootViewController:self.tabBC];
    
    
    return YES;
}


#pragma mark ---------tabBarControllerDelegate---------
//已经选中视图控制器，通常进行视图的设置
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    /*
    //viewController是用户选中的控制器
    if (tabBarController.selectedIndex == 0) {
        FirstViewController *firstVC = (FirstViewController *)viewController;
        firstVC.tabBarItem.badgeValue = nil;
    }
    if (tabBarController.selectedIndex == 1) {
        //强制转换把子类指针指向父类对象
        SecondViewController *secondVC = (SecondViewController *)viewController;
    }
     */
    NSLog(@"%s",__FUNCTION__);
}
//将要选中视图控制器，通常进行数据的准备
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSLog(@"%s",__FUNCTION__);
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
