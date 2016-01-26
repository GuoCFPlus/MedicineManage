//
//  CaseTableViewController.m
//  MedicineManage
//
//  Created by lanou3g on 15/12/31.
//  Copyright © 2015年 gcf. All rights reserved.
//

#import "CaseTableViewController.h"

@interface CaseTableViewController ()
//列表数据数组
@property(strong,nonatomic)NSMutableArray *listDataArr;
//经典数据数组
@property(strong,nonatomic)NSMutableArray *caseSutraDataArr;

//选项卡
@property(strong,nonatomic)UISegmentedControl *seg;

//当前页
@property(assign,nonatomic)NSUInteger casePage;
@property(assign,nonatomic)NSUInteger caseSutraPage;

@end
static NSString * const caseCellID = @"caseCellID";
@implementation CaseTableViewController
-(instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:style]) {
        
        //设置为不反弹
        //self.tableView.bounces = NO;
        
        UIImage *img = [[UIImage imageNamed:@"iconfont-case"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imgHeight = [[UIImage imageNamed:@"iconfont-caseHeight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"病例" image:img selectedImage:imgHeight];
        
        //顶部状态栏样式
        UIImage *leftImage = [[UIImage imageNamed:@"iconfont-add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(addCase)];
        self.navigationItem.leftBarButtonItem = leftBarButton;
        
        UIImage *rightImage = [[UIImage imageNamed:@"iconfont-edit"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(editCase)];
        self.navigationItem.rightBarButtonItem = rightBarButton;
        
        //segement页面添加到表头
        [self headViewDidLoad];

        self.casePage = 1;
        self.caseSutraPage = 1;
        self.listDataArr = [NSMutableArray array];
        self.caseSutraDataArr = [NSMutableArray array];
        //数据加载事件
        [self changePage];
        
    }
    return self;
}

//添加病例事件
-(void)addCase{
    
}

//编辑事件
-(void)editCase{
    
}

//选项卡切换页面
-(void)changePage{
    
    switch (self.seg.selectedSegmentIndex) {
        case 0:{
            //加载最新数据
            [self listDidLoad];
            break;
        }
        case 1:{
            //加载经典数据
            [self listSutraDidLoad];
            break;
        }
        default:
            DLog(@"出错了");
            break;
    }
}

//segement页面添加到表头
-(void)headViewDidLoad{
    
    UIView *sView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    //分段控制器独有的初始化方法中，参数是一个数组
    //数组要求：字符串数组或图片数组
    NSArray *arr = @[@"最新病例",@"经典病例"];
    self.seg = [[UISegmentedControl alloc] initWithItems:arr];
    //seg.center = self.view.center;
    self.seg.frame = CGRectMake(10, 5, kScreenWidth-20, 30);
    //边框及字体颜色
    self.seg.tintColor = [UIColor grayColor];
    self.seg.backgroundColor = [UIColor whiteColor];
    //切圆角
    self.seg.layer.cornerRadius = 5;
    self.seg.layer.masksToBounds = YES;
    //根据内容自适应大小，但不会超出整体布局frame的宽度
    self.seg.apportionsSegmentWidthsByContent = YES;
    //默认选中
    self.seg.selectedSegmentIndex = 0;
    
    //给分段控制器添加事件
    [self.seg addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    
    [sView addSubview:self.seg];
    self.tableView.tableHeaderView = sView;
    
    
    
}

//列表数据加载
-(void)listDidLoad{
    
    NSString *caseUrlStr = [NSString stringWithFormat:@"http://i.dxy.cn/snsapi/user/case/recommend?ac=4124c5f1-1031-4fda-b06f-a88ac5ad8d9f&deviceName=gcfiPhone&hardName=iPhone&mc=158824008224872e58158ee912847737c6e9cd8e&page=%ld&size=10&token=TGT-9722-5UGaMnL4aeBSFqFSn7OM9PGKoCdrCG5YDty-50&vc=5.1.2&vs=9.2",self.casePage];
    
    NSURL *url = [NSURL URLWithString:caseUrlStr];//kCaseNewURL
    //创建会话单例
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr = [NSArray arrayWithArray:dict[@"items"]];
            //遍历数组，把数组赋给属性：listDataArr
            //self.listDataArr = [[NSMutableArray alloc]initWithCapacity:arr.count];
            for (NSDictionary *dict in arr) {
                CaseInfo *caseInfo = [[CaseInfo alloc]initWithDictionary:dict];
                [self.listDataArr addObject:caseInfo];
            }
        }
        else
        {
            //提示没有网络
            DLog(@"网络连接错误");
        }
        //返回主线程，数据重新加载
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    //启动任务
    [dataTask resume];
    
}

//经典病例列表数据加载
-(void)listSutraDidLoad{
    
    NSString *caseSutraUrlStr = [NSString stringWithFormat:@"http://i.dxy.cn/snsapi/case/recommend?ac=4124c5f1-1031-4fda-b06f-a88ac5ad8d9f&deviceName=gcfiPhone&hardName=iPhone&mc=158824008224872e58158ee912847737c6e9cd8e&page=%ld&size=10&token=TGT-9722-5UGaMnL4aeBSFqFSn7OM9PGKoCdrCG5YDty-50&vc=5.1.2&vs=9.2",self.caseSutraPage];
    
    NSURL *url = [NSURL URLWithString:caseSutraUrlStr];//kCaseSutraURL
    //创建会话单例
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr = [NSArray arrayWithArray:dict[@"items"]];
            //遍历数组，把数组赋给属性：listDataArr
            //self.listDataArr = [[NSMutableArray alloc]initWithCapacity:arr.count];
            for (NSDictionary *dict in arr) {
                CaseInfo *caseInfo = [[CaseInfo alloc]initWithDictionary:dict];
                [self.caseSutraDataArr addObject:caseInfo];
            }
        }
        else
        {
            //提示没有网络
            DLog(@"网络连接错误");
        }
        //返回主线程，数据重新加载
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    //启动任务
    [dataTask resume];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"病例";
    
    // 2.集成刷新控件
    [self setupRefresh];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //[self.tableView registerNib:[UINib nibWithNibName:@"CaseTableViewCell" bundle:nil] forCellReuseIdentifier:caseCellID];
    [self.tableView registerClass:[CaseCell class] forCellReuseIdentifier:caseCellID];
    
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
    switch (self.seg.selectedSegmentIndex) {
        case 0:{
            //最新数据页数设为1
            self.casePage = 1;
            break;
        }
        case 1:{
            //经典数据页数设为1
            self.caseSutraPage = 1;
            break;
        }
        default:
            DLog(@"出错了");
            break;
    }

    
    // 1.添加数据
    [self changePage];
    
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
    switch (self.seg.selectedSegmentIndex) {
        case 0:{
            //最新数据页数加1
            self.casePage++;
            break;
        }
        case 1:{
            //经典数据页数加1
            self.caseSutraPage++;
            break;
        }
        default:
            DLog(@"出错了");
            break;
    }
    // 1.添加数据
    [self changePage];
    
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
    NSUInteger count = 0;
    switch (self.seg.selectedSegmentIndex) {
        case 0:{
            count = self.listDataArr.count;
            break;
        }
        case 1:{
            count = self.caseSutraDataArr.count;
            break;
        }
        default:
        {
            DLog(@"出错了");
            break;
        }
    }
    return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //DLog(@"%s",__FUNCTION__);
    
    CGFloat cellHeight = 0;
    CaseInfo *caseInfo = [CaseInfo new];
    switch (self.seg.selectedSegmentIndex) {
        case 0:{
            caseInfo = self.listDataArr[indexPath.row];
            break;
        }
        case 1:{
            caseInfo = self.caseSutraDataArr[indexPath.row];
            break;
        }
        default:
        {
            DLog(@"出错了");
            break;
        }
    }
    CGFloat titleHeight = [self hobbyHeight:caseInfo.subject];
    CGFloat contentHeight = [self hobbyHeight:caseInfo.body];
    CGFloat imageInfoHeight = 0;
    if (caseInfo.imageInfo != nil) {
        imageInfoHeight = 80;
    }
    cellHeight = kGap * 5 + titleHeight + kLineHeight +contentHeight +imageInfoHeight;
    
    return cellHeight;
}


/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    CaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:caseCellID forIndexPath:indexPath];
    
    // Configure the cell...
    CaseInfo *caseInfo = self.listDataArr[indexPath.row];
    cell.titleLabel.text = caseInfo.subject;
    cell.authorLabel.text = [NSString stringWithFormat:@"%@  %@/%@",caseInfo.username,caseInfo.reply,caseInfo.click];
    cell.contentLabel.text = caseInfo.body;
    */
    //DLog(@"%s",__FUNCTION__);
    CaseCell *cell = [tableView dequeueReusableCellWithIdentifier:caseCellID forIndexPath:indexPath];
    CaseInfo *caseInfo = [CaseInfo new];
    switch (self.seg.selectedSegmentIndex) {
        case 0:{
            caseInfo = self.listDataArr[indexPath.row];
            break;
        }
        case 1:{
            caseInfo = self.caseSutraDataArr[indexPath.row];
            break;
        }
        default:
        {
            DLog(@"出错了");
            break;
        }
    }
    cell.titleLabel.text = caseInfo.subject;
    CGRect titleRect = cell.titleLabel.frame;
    titleRect.size.height = [self hobbyHeight:caseInfo.subject];
    cell.titleLabel.frame = titleRect;
    
    cell.authorLabel.text = [NSString stringWithFormat:@"%@  %@/%@",caseInfo.username,caseInfo.reply,caseInfo.click];
    
    cell.contentLabel.text = caseInfo.body;
    CGRect contentRect = cell.contentLabel.frame;
    contentRect.origin.y = CGRectGetMaxY(cell.authorLabel.frame)+kGap;
    contentRect.size.height = [self hobbyHeight:caseInfo.body];
    cell.contentLabel.frame = contentRect;
    
    //有图片时显示图片,没有的时候隐藏
    CGRect imgInfoRect = cell.imgInfoView.frame;
    imgInfoRect.origin.y = CGRectGetMaxY(cell.contentLabel.frame)+kGap;
    if (caseInfo.imageInfo == nil) {
        cell.imgInfoView.hidden = YES;
        imgInfoRect.size.height = 0;
    }
    else
    {
        cell.imgInfoView.hidden = NO;
        NSArray *imgArr = caseInfo.imageInfo;
        //DLog(@"%@",imgArr[0][@"uri"]);
        [cell.contentImage1 sd_setImageWithURL:[NSURL URLWithString:imgArr[0][@"uri"]]];
        cell.contentImage2.hidden = YES;
        if (imgArr.count > 2) {
            [cell.contentImage2 sd_setImageWithURL:[NSURL URLWithString:imgArr[1][@"uri"]]];
            cell.contentImage2.hidden = NO;
        }
    }
    cell.imgInfoView.frame = imgInfoRect;
    
    CGRect bgRect = cell.bgView.frame;
    bgRect.size.height = cell.frame.size.height - kGap/2;
    cell.bgView.frame = bgRect;
    
    return cell;
}

//根据字符串计算动态高度
-(CGFloat)hobbyHeight:(NSString *)str{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(kCellWidth, 70) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFontSize]} context:nil];
    return rect.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CaseDetailTableViewController *caseDetailVC = [[CaseDetailTableViewController alloc]init];
    caseDetailVC.caseId = [self.listDataArr[indexPath.row] caseId];
    [self.navigationController pushViewController:caseDetailVC animated:YES];
    
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
