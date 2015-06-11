//
//  DetailViewController.m
//  RSS
//
//  Created by Taiki on 2015/06/12.
//  Copyright (c) 2015年 Taiki Sugiyama. All rights reserved.
//

#import "DetailViewController.h"
#import "EFRDefine.h"

@interface DetailViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIButton *prevButton;
@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UIButton *goForwardButton;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.articleDic[TITLE];
    int footerHeight = 46;
    
    NSURL *url = [NSURL URLWithString:self.articleDic[LINK]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height)];
    self.webView.delegate = self;
    [self.webView loadRequest:req];
    [self.view addSubview:self.webView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.webView.frame.origin.y+self.webView.frame.size.height, WINSIZE.width, footerHeight)];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    
    self.prevButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.prevButton.frame = CGRectMake(0, -50, 46, footerHeight);
    [self.prevButton setTitle:@"←" forState:UIControlStateNormal];
    [self.prevButton addTarget:self action:@selector(prevButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:self.prevButton];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.nextButton.frame = CGRectMake(self.prevButton.frame.origin.x+self.prevButton.frame.size.width, self.prevButton.frame.origin.y, self.prevButton.frame.size.width, self.prevButton.frame.size.height);
    [self.nextButton addTarget:self action:@selector(nextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton setTitle:@"→" forState:UIControlStateNormal];
    [footerView addSubview:self.nextButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.goBackButton.enabled = self.webView.canGoBack;
    self.goForwardButton.enabled = self.webView.canGoForward;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    if (self.webView.isLoading) {
        [self.webView stopLoading];
    }
    
    [super viewWillDisappear:animated];
}
- (void)goBackButtonTapped:(UIButton *)sender {
    if (self.webView.canGoBack) [self.webView goBack];
}

- (void)goForwardButtonTapped:(UIButton *)sender {
    if (self.webView.canGoForward) [self.webView goForward];
}

@end

//Users/Taiki/program/RSS/RSS/DetailViewController.m:77:10: Property 'goBackButton' not found on object of type 'DetailViewController *'