//
//  DetailViewController.m
//  gitHubFriends
//
//  Created by Nick Perkins on 4/25/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import "DetailViewController.h"
#import "Friend.h"

@interface DetailViewController () <NSURLSessionDelegate>

@property NSMutableData * receivedData;
@property NSMutableArray * repoArray;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
        NSString *userName = [self.detailItem description];
        NSString * urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", userName];
        NSURL * url = [NSURL URLWithString:urlString];
        
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession * session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url];
        // you can pause or stop a dataTask specifically.  if they leave page, download stops or something.
        [dataTask resume];
        self.navigationItem.title = [NSString stringWithFormat:@"%@ Public Respositories", userName];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    
    if(!self.receivedData){
        self.receivedData = [[NSMutableData alloc]initWithData:data];
    }else{
        [self.receivedData appendData:data];
    }
    
    
}


-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    if (!error){
        //NSLog(@"Download Successful! %@", [self.receivedData description]);
        
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@", [jsonResponse description]);
        }
    }

@end
