//
//  ViewController.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/25.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "ViewController.h"
#import "LZZCrawlerTool.h"
#import <ACFloatingTextfield-Objc/ACFloatingTextField.h>
#import "LZZButton.h"
#import "NSString+smartUrl.h"
#import "CheckoutVC.h"

#define LZZHistoryListCellHeight 30.0

@interface ViewController ()<UITextFieldDelegate,PKDownloadButtonDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView * maskView;
@property (strong, nonatomic) ACFloatingTextField *textField;
@property (strong, nonatomic) LZZButton *commitBtn;

@property(nonatomic,strong)UITableView * historyListView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addKBObser];
    [self setUpUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self moveInUI];
    });
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)addKBObser
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setUpUI
{
    // bg image
    UIImageView * iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    iv.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bgimg" ofType:@"jpg"]];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:iv];
    
    // mask view
    self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.layer.opacity = 0.0;
    [self.view addSubview:self.maskView];
    
    // textfield
    self.textField.layer.opacity = 0;
    [self.view addSubview:self.textField];
    
    // label
    [self.navigationController.view addSubview:self.titleLabel];
    [self.view addSubview:self.copyrightLabel];
    
    // button
    [self.view addSubview:self.commitBtn];
    
    
    // history list view
    [self showOrHideHistoryListView:NO];
    [self.view addSubview:self.historyListView];
    
}

-(void)moveInUI
{

    [UIView animateWithDuration:1.0 delay:0.5 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.textField.layer.opacity = 1.0;
        self.titleLabel.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, -SCREEN_WIDTH*0.48), 0.51, 0.51);
        self.textField.frame = CGRectMake(SCREEN_WIDTH*0.05, kScreen_Height*0.2, SCREEN_WIDTH*0.9, 45);
        self.commitBtn.frame = CGRectMake(SCREEN_WIDTH*0.2, kScreen_Height*0.5, SCREEN_WIDTH*0.6,50);
    } completion:^(BOOL finished) {
        [self.titleLabel removeFromSuperview];
        self.navigationItem.title = self.titleLabel.text;
    }];
}

-(void)keyboardWillShow:(id)sender
{
   [self showOrHideHistoryListView:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.layer.opacity = 0.6;
    }];
}

-(void)keyboardWillHide:(id)sender
{
    [self showOrHideHistoryListView:NO];
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.layer.opacity = 0.0;
    }];
}


-(void)showOrHideHistoryListView:(BOOL)flag
{
    if (flag) {
        CGFloat tf_bottom = self.textField.frame.origin.y + self.textField.frame.size.height;
        CGFloat list_maxH = self.commitBtn.frame.origin.y - tf_bottom - 20.0;
        CGFloat list_currentH = ((CGFloat)[StoreData historyUrls].count) * LZZHistoryListCellHeight;
        [self.historyListView setFrame:CGRectMake(self.textField.frame.origin.x, tf_bottom, self.textField.frame.size.width,MIN(list_maxH, list_currentH))];
        [self.historyListView reloadData];
    }
    
    self.historyListView.hidden = !flag;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
    
}


#pragma mark - PKDownloadButtonDelegate
- (void)downloadButtonTapped:(PKDownloadButton *)downloadButton
                currentState:(PKDownloadButtonState)state {
    
    [self.textField resignFirstResponder];
    
    switch (state) {
        case kPKDownloadButtonState_StartDownload:
        {
            self.textField.text = [self.textField.text smartUrl];
            [StoreData insertUrl:self.textField.text];
            self.commitBtn.state = kPKDownloadButtonState_Pending;
            [LZZCrawlerTool getHTMLDocumentWithUrl:self.textField.text andParams:nil andCompletion:^(BOOL successed, id responseObject, NSError *error) {
                
                self.commitBtn.state = kPKDownloadButtonState_StartDownload;
                if (successed) {
                    CheckoutVC * vc = [[CheckoutVC alloc] initWithNibName:NSStringFromClass([CheckoutVC class]) bundle:nil];
                    vc.htmlDocument = responseObject;
                    [self.navigationController pushViewController:vc animated:YES];
                    NSLog(@"resData:%@",[FormatToString formatItem:responseObject]);
                }else{
                    SCLAlertView * alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert showError:@"Oops~" subTitle:error.localizedDescription closeButtonTitle:@"close" duration:LZZAlertStayDuration];
                }
            }];

        }
            break;
        case kPKDownloadButtonState_Pending:
            [LZZCrawlerTool cancelAllReqTask];
            self.commitBtn.state = kPKDownloadButtonState_StartDownload;
            break;
        case kPKDownloadButtonState_Downloading:
            [LZZCrawlerTool cancelAllReqTask];
            self.commitBtn.state = kPKDownloadButtonState_StartDownload;
            break;
        case kPKDownloadButtonState_Downloaded:
            [LZZCrawlerTool cancelAllReqTask];
            self.commitBtn.state = kPKDownloadButtonState_StartDownload;
            break;
        default:
            NSAssert(NO, @"unsupported state");
            break;
    }
}

#pragma mark - table view delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [StoreData historyUrls].count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return LZZHistoryListCellHeight;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * const kCellID = @"historyCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.text = [[StoreData historyUrls] objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.textField.text = [[StoreData historyUrls] objectAtIndex:indexPath.row];
}


#pragma mark - lazy load

-(ACFloatingTextField *)textField
{
    if (!_textField) {
        _textField = [[ACFloatingTextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH+10, kScreen_Height*0.2, SCREEN_WIDTH*0.9, 45)];
        _textField.placeholder = @"Input website url";
        _textField.placeHolderColor = [UIColor darkGrayColor];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.keyboardType = UIKeyboardTypeURL;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.textColor = [UIColor whiteColor];
        _textField.lineColor = [UIColor whiteColor];
        _textField.selectedLineColor = [UIColor yellowColor];
        _textField.placeHolderColor = [UIColor darkGrayColor];
        _textField.selectedPlaceHolderColor = [UIColor yellowColor];
        _textField.errorTextColor = [UIColor redColor];
        _textField.errorLineColor = [UIColor redColor];
    }
    return _textField;
}

-(LZZButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [[LZZButton alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH*0.6-10, kScreen_Height*0.5, SCREEN_WIDTH*0.6,50)];
        _commitBtn.delegate = self;
    }
    return _commitBtn;
}

-(UITableView *)historyListView
{
    if (!_historyListView) {
        _historyListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.textField.frame.size.width, kScreen_Height*0.3) style:UITableViewStylePlain];
        _historyListView.backgroundView.backgroundColor = [UIColor clearColor];
        _historyListView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        _historyListView.dataSource = self;
        _historyListView.delegate = self;
        _historyListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _historyListView.tableFooterView = [UIView new];
        
    }
    return _historyListView;
}

@end

