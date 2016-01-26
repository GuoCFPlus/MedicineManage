//
//  AcademicTableViewController.m
//  MedicineManage
//
//  Created by lanou3g on 15/12/31.
//  Copyright © 2015年 gcf. All rights reserved.
//

#import "AcademicTableViewController.h"

@interface AcademicTableViewController ()<FFNavbarMenuDelegate>

//轮播图数据数组
@property(strong,nonatomic)NSMutableArray *imageDataArr;
//列表数据数组
@property(strong,nonatomic)NSMutableArray *listDataArr;
//顶部弹出框
@property(strong,nonatomic)FFNavbarMenu *menu;

@end
static NSString * const academicCellID = @"academicCellID";
@implementation AcademicTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:style]) {
        //设置为不反弹
        //self.tableView.bounces = NO;
        
        //底部导航栏样式
        UIImage *img = [[UIImage imageNamed:@"iconfont-academic"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imgHeight = [[UIImage imageNamed:@"iconfont-academicHeight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"学术圈" image:img selectedImage:imgHeight];
        
        //顶部状态栏样式
        UIImage *leftImage = [[UIImage imageNamed:@"iconfont-search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(searchPosts)];
        self.navigationItem.leftBarButtonItem = leftBarButton;
        
        UIImage *rightImage = [[UIImage imageNamed:@"iconfont-edit"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(editPosts)];
        self.navigationItem.rightBarButtonItem = rightBarButton;

        
    }
    return self;
}

//绘制导航
-(FFNavbarMenu *)menuViewDidLoad{
    if (self.menu == nil) {
        FFNavbarMenuItem *item1 = [[FFNavbarMenuItem alloc]initWithTitle:@"发帖子" icon:[UIImage imageNamed:@"iconfont-navEdit"]];
        FFNavbarMenuItem *item2 = [[FFNavbarMenuItem alloc]initWithTitle:@"发动态" icon:[UIImage imageNamed:@"iconfont-navMessage"]];
        self.menu = [[FFNavbarMenu alloc]initWithItems:@[item1,item2] width:kScreenWidth maximumNumberInRow:2];
        self.menu.backgroundColor = kColor;
        self.menu.separatarColor = [UIColor lightGrayColor];
        self.menu.textColor = [UIColor whiteColor];
        self.menu.delegate = self;
    }
    return self.menu;
}

#pragma mark ----navMenu代理事件---
- (void)didShowMenu:(FFNavbarMenu *)menu
{
    UIImage *rightImage = [[UIImage imageNamed:@"iconfont-cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationItem.rightBarButtonItem setImage:rightImage];
}
- (void)didDismissMenu:(FFNavbarMenu *)menu{
    UIImage *rightImage = [[UIImage imageNamed:@"iconfont-edit"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationItem.rightBarButtonItem setImage:rightImage];
}
- (void)didSelectedMenu:(FFNavbarMenu *)menu atIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            //发帖子
            DLog(@"发帖子");
            break;
        }
        case 1:
        {
            //发动态
            DLog(@"发动态");
            break;
        }
        default:
            break;
    }
}

//搜索事件
-(void)searchPosts{
    
}

//编辑事件
-(void)editPosts{
    if (self.menu.isOpen) {
        [self.menu dismissWithAnimation:YES];
    }
    else
    {
        [self.menu showInNavigationController:self.navigationController];
    }
}

#pragma mark ----数据加载事件----
//轮播图数据加载
-(void)imageDidLoad{
    NSURL *url = [NSURL URLWithString:kAcademicImageURL];
    //创建会话单例
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr = [NSArray arrayWithArray:dict[@"items"]];
            //遍历数组，把数组赋给属性：imageDataArr
            self.imageDataArr = [[NSMutableArray alloc]initWithCapacity:arr.count];
            for (NSDictionary *dict in arr) {
                //查询判断是否存在
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"ImageInfo" inManagedObjectContext:[CoreDataTools shareCoreData].context];
                [fetchRequest setEntity:entity];
                // Specify criteria for filtering which objects to fetch
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url = %@",dict[@"url"]];
                [fetchRequest setPredicate:predicate];
                
                NSError *error = nil;
                NSArray *fetchedObjects = [[CoreDataTools shareCoreData].context executeFetchRequest:fetchRequest error:&error];
                if (fetchedObjects == nil) {
                    DLog(@"出错了");
                }
                
                ImageInfo *imageInfo = [NSEntityDescription insertNewObjectForEntityForName:@"ImageInfo" inManagedObjectContext:[CoreDataTools shareCoreData].context];
                
                imageInfo.avatarPath = dict[@"avatarPath"];
                imageInfo.body = dict[@"body"];
                imageInfo.mobilePushId = dict[@"mobilePushId"];
                imageInfo.path = dict[@"path"];
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                NSTimeZone *timeZone = [NSTimeZone localTimeZone];
                [formatter setTimeZone:timeZone];
                [formatter setDateFormat : @"M/d/yyyy h:m:s"];
                NSString *stringTime = dict[@"sortTime"];
                NSDate *dateTime = [formatter dateFromString:stringTime];
                imageInfo.sortTime = dateTime;
                
                imageInfo.title = dict[@"title"];
                imageInfo.url = dict[@"url"];
                
                //判断是否保存过
                if (fetchedObjects.count > 0) {
                    DLog(@"保存过了");
                }
                else
                {
                    if([[CoreDataTools shareCoreData].context save:nil]){
                        DLog(@"保存成功");
                        
                    }
                }
                
                [self.imageDataArr addObject:imageInfo];
                
            }
        }
        else
        {
            //从数据库读取数据
            DLog(@"数据库读取图片轮播");
            
        }
        //返回主线程，数据重新加载
        dispatch_async(dispatch_get_main_queue(), ^{
            //轮播图页面加载
            [self imageViewDidLoad];

        });
    }];
    //启动任务
    [dataTask resume];
}
//列表数据加载
-(void)listDidLoad{
    NSURL *url = [NSURL URLWithString:kAcademicListURL];
    //创建会话单例
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr = [NSArray arrayWithArray:dict[@"items"]];
            //遍历数组，把数组赋给属性：listDataArr
            self.listDataArr = [[NSMutableArray alloc]initWithCapacity:arr.count];
            for (NSDictionary *dict in arr) {
                /*
                //查询判断是否存在
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"AcademicInfo" inManagedObjectContext:[CoreDataTools shareCoreData].context];
                [fetchRequest setEntity:entity];
                // Specify criteria for filtering which objects to fetch
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"templateContent = %@",dict[@"templateContent"]];
                [fetchRequest setPredicate:predicate];
                
                NSError *error = nil;
                NSArray *fetchedObjects = [[CoreDataTools shareCoreData].context executeFetchRequest:fetchRequest error:&error];
                if (fetchedObjects == nil) {
                    NSLog(@"出错了");
                }
                AcademicInfo *academicInfo = [NSEntityDescription insertNewObjectForEntityForName:@"AcademicInfo" inManagedObjectContext:[CoreDataTools shareCoreData].context];
                academicInfo.infoAvatar = dict[@"infoAvatar"];
                academicInfo.infoUsername = dict[@"infoUsername"];
                academicInfo.date = dict[@"date"];
                academicInfo.content = dict[@"content"];
                academicInfo.section = dict[@"section"];
                academicInfo.templateContent = dict[@"templateContent"];
                //判断是否保存过
                if (fetchedObjects.count > 0) {
                    DLog(@"保存过了");
                }
                else
                {
                    if([[CoreDataTools shareCoreData].context save:nil]){
                        DLog(@"保存成功");
                        
                    }
                }
                [self.listDataArr addObject:academicInfo];
                 */
                
                Academic *academic = [[Academic alloc]initWithDictionary:dict];
                [self.listDataArr addObject:academic];
            }
        }
        else
        {
            //从数据库读取数据
            DLog(@"数据库读取列表");
        }
        //返回主线程，数据重新加载
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    //启动任务
    [dataTask resume];

}

#pragma mark ---页面加载事件---
-(void)imageViewDidLoad{
    //轮播图底层视图
    UIView *sView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    
    //轮播图
    JKScrollFocus *scroller = [[JKScrollFocus alloc] initWithFrame:sView.frame];
    //imageArray 也可以传入网络图片地址数组
    
    /*
     scroller.imageArray = @[@"http://img.ivsky.com/img/tupian/co/201507/27/langshan-002.jpg",
     @"http://img.ivsky.com/img/tupian/co/201507/28/zise_de_jiegenghua-002.jpg",
     @"http://img.ivsky.com/img/tupian/co/201507/28/ziweihua.jpg",
     @"http://img.ivsky.com/img/bizhi/co/201508/23/sinbawa-002.jpg",
     @"http://img.ivsky.com/img/bizhi/co/201508/25/call_of_duty_online-001.jpg",
     @"http://img.ivsky.com/img/bizhi/co/201508/25/beginning_of_autumn-004.jpg",
     @"http://img.ivsky.com/img/bizhi/co/201509/24/yazuishou_boy-001.jpg",
     @"http://img.ivsky.com/img/tupian/co/201507/28/santo_wine-009.jpg"];
     scroller.titleArray = @[@"轮播title0",@"轮播title11",@"轮播title22",@"轮播title33", @"轮播title44",@"轮播title55",@"轮播title66",@"轮播title77"];
     */
    
    //分别初始化图片数组和标题数组
    NSMutableArray *imageUrlArr = [[NSMutableArray alloc]initWithCapacity:self.imageDataArr.count];
    NSMutableArray *titleArr = [[NSMutableArray alloc]initWithCapacity:self.imageDataArr.count];
    //遍历添加
    for (ImageInfo *imageInfo in self.imageDataArr) {
        [imageUrlArr addObject:imageInfo.path];
        [titleArr addObject:imageInfo.title];
    }
    //赋值给轮播图控件
    scroller.imageArray = imageUrlArr;
    scroller.titleArray = titleArr;
    
    scroller.autoScroll = YES;
    [scroller didSelectScrollFocusItem:^(NSInteger index) {
        DLog(@"click %ld",index);
    }];
    [scroller downloadFocusItem:^(id downloadItem, UIImageView *currentImageView) {
        //这里我使用SDWebImage进行加载网络图片,可以使用自己的方法
        [currentImageView sd_setImageWithURL:[NSURL URLWithString:downloadItem] placeholderImage:nil];
    }];
    [sView addSubview:scroller];
    
    //设置页头为轮播图
    self.tableView.tableHeaderView = sView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self menuViewDidLoad];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //未登录时直接跳转登陆页面登录
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 允许用户使用应用
        
        self.navigationItem.title = @"学术圈";
        
        //数据加载事件
        [self imageDidLoad];
        [self listDidLoad];
        
        // 2.集成刷新控件
        [self setupRefresh];
        
        //轮播图页面加载
        [self imageViewDidLoad];
        
        
        //cell
        [self.tableView registerNib:[UINib nibWithNibName:@"AcademicTableViewCell" bundle:nil] forCellReuseIdentifier:academicCellID];
        //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:academicCellID];
        
        if (self.menu) {
            [self.menu dismissWithAnimation:NO];
        }
        
        
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
        LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        loginNC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kColor};
        loginNC.navigationBar.tintColor = kColor;
        [self presentViewController:loginNC animated:YES completion:nil];
        
    }

    
    
}


/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"table"];
    
    [self.tableView.header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    //    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加数据
    [self listDidLoad];
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.添加数据
    [self listDidLoad];
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.listDataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AcademicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:academicCellID forIndexPath:indexPath];
    
    Academic *academic = self.listDataArr[indexPath.row];
    cell.headerImageView.image = [UIImage imageNamed:@"AppIcon60x60"];
    cell.userNameLabel.text = academic.infoUsername;
    cell.dateLabel.text = academic.date;
    
    //DLog(@"%@",academic.content);
    NSData *data = [academic.content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    cell.titleLabel.text = dict[@"subject"];
    cell.contentLabel.text = dict[@"body"];
    
    cell.categoryLabel.text = academic.sourceTitle;
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:academicCellID forIndexPath:indexPath];
    
    //cell.textLabel.numberOfLines = 0;
    //cell.textLabel.frame = cell.frame;
    
    //方案一：直接输出串
    //cell.textLabel.text = [self.listDataArr[indexPath.row] templateContent];
    
    //方案二：拼接成完整的网页，输出
    /*
    //NSString * htmlString = [NSString stringWithFormat:@"<body style=\'color:#4F46A0;text-decoration: none;\'>%@</body>",[self.listDataArr[indexPath.row] templateContent]];
    NSString *htmlString = [self stringToHtml:[self.listDataArr[indexPath.row] templateContent]];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    cell.textLabel.attributedText = attrStr;
    
    */
    
    //方案三：WKWebView
    /*
    WKWebView *webView = [[WKWebView alloc]initWithFrame:cell.frame];
    [webView loadHTMLString:[self.listDataArr[indexPath.row] templateContent] baseURL:nil];
    [cell addSubview:webView];
    */
    // Configure the cell...
    
    return cell;
}

-(NSString *)stringToHtml:(NSString *)string{
    
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"]; //NSLog(@"1-%@",html);
    [html appendString:@"<head>"]; //NSLog(@"2-%@",html);
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle]URLForResource:@"AcademicDetails.css" withExtension:nil]]; //NSLog(@"3-%@",html);
    
    [html appendString:@"</head>"];// NSLog(@"4-%@",html);
    
    [html appendString:@"<body>"];// NSLog(@"5-%@",html);
    [html appendString:string]; //NSLog(@"6-%@",html);
    [html appendString:@"</body>"]; //NSLog(@"7-%@",html);
    
    [html appendString:@"</html>"]; //NSLog(@"8-%@",html);
    
    //[self.detailWebView loadHTMLString:html baseURL:nil];
    
    
    return html;
}
/*
- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailModel.ptime];
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
    // 遍历img
    for (SYDetailImgModel *detailImgModel in self.detailModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}
*/
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
