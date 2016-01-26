//
//  CaseDetailTableViewController.m
//  MedicineManage
//
//  Created by lanou3g on 16/1/6.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import "CaseDetailTableViewController.h"

@interface CaseDetailTableViewController ()
//列表数据数组
@property(strong,nonatomic)NSMutableArray *listDataArr;
@property(strong,nonatomic)WKWebView *caseDetailWebView;
@end

static NSString * const caseDetailCellID = @"caseDetailCellID";
static NSString * const caseReplyCellID = @"caseReplyCellID";

@implementation CaseDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"帖子详情";
    self.navigationController.navigationBar.barTintColor = kColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CaseDetailTableViewCell" bundle:nil] forCellReuseIdentifier:caseDetailCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CaseReplyTableViewCell" bundle:nil] forCellReuseIdentifier:caseReplyCellID];
    
    [self listDidLoad];
    
}

//数据解析
-(void)listDidLoad{
    //http://i.dxy.cn/bbs/bbsapi/mobile?ac=4124c5f1-1031-4fda-b06f-a88ac5ad8d9f&author=0&checkUserAction=1&deviceName=gcfiPhone&hardName=iPhone&id=32667170&mc=158824008224872e58158ee912847737c6e9cd8e&order=0&page=1&s=view_topic&size=20&token=TGT-9722-5UGaMnL4aeBSFqFSn7OM9PGKoCdrCG5YDty-50&vc=5.1.2&vs=9.2&withGood=1
    NSString *caseDetailUrl = [NSString stringWithFormat:@"http://i.dxy.cn/bbs/bbsapi/mobile?ac=4124c5f1-1031-4fda-b06f-a88ac5ad8d9f&author=0&checkUserAction=1&deviceName=gcfiPhone&hardName=iPhone&id=%@&mc=158824008224872e58158ee912847737c6e9cd8e&order=0&page=1&s=view_topic&size=20&token=TGT-9722-5UGaMnL4aeBSFqFSn7OM9PGKoCdrCG5YDty-50&vc=5.1.2&vs=9.2&withGood=1",self.caseId];
    DLog(@"%@",self.caseId);
    NSURL *url = [NSURL URLWithString:caseDetailUrl];
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
                CaseDetailInfo *caseDetailInfo = [[CaseDetailInfo alloc]initWithDictionary:dict];
                [self.listDataArr addObject:caseDetailInfo];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDataArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    if (indexPath.row == 0) {
        
        CGFloat htmlHeight=[self getHeightWithHtmlString:indexPath];
        
        return htmlHeight;
    }
     */
    return 200;
}
//获取网页字符串,根据字符串获取高度
-(CGFloat)getHeightWithHtmlString:(NSIndexPath *)indexPath{
    CaseDetailInfo *caseDetailInfo = self.listDataArr[indexPath.row];
    NSString *str = [self stringToHtml:caseDetailInfo.body];
    
    CGFloat htmlHeight = 0;
    
    
    return htmlHeight;
}


/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CaseDetailInfo *caseDetailInfo = self.listDataArr[indexPath.row];
    
    if (indexPath.row == 0) {
        CaseDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:caseDetailCellID forIndexPath:indexPath];
        cell.titleLabel.text = caseDetailInfo.subject;
        
        //内容
        self.caseDetailWebView = [[WKWebView alloc]initWithFrame:cell.contentView.frame];
        self.caseDetailWebView.backgroundColor = [UIColor redColor];
        [self.caseDetailWebView loadHTMLString:[self stringToHtml:caseDetailInfo.body] baseURL:nil];
        [cell.contentView addSubview:self.caseDetailWebView];
        //根据内容，重置cell的高度
        CGRect contentFrame = cell.contentView.frame;
        contentFrame.size.height = [self CalculateHeight:caseDetailInfo.body];
        cell.contentView.frame = contentFrame;
        
        
        cell.authorLabel.text = caseDetailInfo.username;
        cell.dateLabel.text = [NSString stringWithFormat:@"发表于 %@",caseDetailInfo.postTime];
        //投票
        if (caseDetailInfo.voted == true) {
            cell.voteButton.imageView.image = [UIImage imageNamed:@"Votesign"];
        }
        cell.voteCountLabel.text = caseDetailInfo.votes;
        if ([caseDetailInfo.votes isEqualToString:@"0"]) {
            cell.voteCountLabel.hidden = YES;
        }
        //收藏
        if (caseDetailInfo.favorited == true) {
            //收藏过了变成红色
            cell.collectButton.imageView.image = [UIImage imageNamed:@"Collectsign"];
        }
        cell.collectCountLabel.text = caseDetailInfo.favs;
        if ([caseDetailInfo.favs isEqualToString:@"0"]) {
            //没有人收藏的时候隐藏，不显示0
            cell.collectCountLabel.hidden = YES;
        }
        // Configure the cell...
        
        return cell;
    }
    else
    {
        CaseReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:caseReplyCellID forIndexPath:indexPath];
        cell.headImageView.image = [UIImage imageNamed:@"AppIcon60x60"];
        cell.authorLabel.text = caseDetailInfo.username;
        cell.rankLabel.text  = caseDetailInfo.boardTitle;
        cell.contentLabel.text = caseDetailInfo.body;
        cell.postTimeLabel.text = caseDetailInfo.postTime;
        //投票
        if (caseDetailInfo.voted == true) {
            cell.voteButton.imageView.image = [UIImage imageNamed:@"Votesign"];
        }
        cell.voteCountLabel.text = caseDetailInfo.votes;
        if ([caseDetailInfo.votes isEqualToString:@"0"]) {
            cell.voteCountLabel.hidden = YES;
        }
        //收藏
        if (caseDetailInfo.favorited == true) {
            //收藏过了变成红色
            cell.voteButton.imageView.image = [UIImage imageNamed:@"Collectsign"];
        }
        cell.favirateCountLabel.text = caseDetailInfo.favs;
        if ([caseDetailInfo.favs isEqualToString:@"0"]) {
            //没有人收藏的时候隐藏，不显示0
            cell.favirateCountLabel.hidden = YES;
        }
        // Configure the cell...
        
        return cell;
    }
    
}
//拼接HTML
-(NSString *)stringToHtml:(NSString *)string{
    
    NSString *html = [NSString stringWithFormat:@"<html>\n"
                      "<head>\n"
                      "<style type=\"text/css\">\n"
                      "body {font-size: 25pt;}\n"
                      "</style>\n"
                      "</head>\n"
                      "<body>\n"
                      "%@\n"
                      "</body>\n"
                      "</html>\n",string];
    
    
    return html;
}

//根据字符串计算动态高度
-(CGFloat)hobbyHeight:(NSString *)str{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(kScreenWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return rect.size.height;
}

//根据动态高度和静态高度计算cell高度
-(CGFloat)CalculateHeight:(NSString *)str{
    //动态高度
    CGFloat dynamicHeight = [self hobbyHeight:str];
    //静态高度
    CGFloat staticHeight = 100 ;
    return dynamicHeight+staticHeight;
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
