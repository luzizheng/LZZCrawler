//
//  CheckoutVC.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/27.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "CheckoutVC.h"
#import "UINavigationItem+CustomBackButton.h"
#import "CheckoutPicVC.h"

@interface CheckoutVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray * cellData;
@end

@implementation CheckoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Check out";
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setUpUI
{
    
    self.navigationItem.backBarButtonItem.title = @"";
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - table view delegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * const kCellID = @"checkOutCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text = [self.cellData objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            CheckoutPicVC * vc = [[CheckoutPicVC alloc] initWithNibName:NSStringFromClass([CheckoutPicVC class]) bundle:nil];
            vc.htmlDocument = self.htmlDocument;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
}


#pragma mark - lazy load

-(NSArray *)cellData
{
    if (!_cellData) {
        _cellData = @[@"Picture",@"Nodes",@"Class"];
    }
    return _cellData;
}


@end
