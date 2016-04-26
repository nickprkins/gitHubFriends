//
//  DetailViewController.m
//  gitHubFriends
//
//  Created by Nick Perkins on 4/25/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import "DetailViewController.h"
#import "RepoTableViewCell.h"

@interface DetailViewController () <NSURLSessionDelegate, UITableViewDataSource>

@property NSMutableData * receivedData;
@property NSMutableArray * repoArray;
@property UITableView *tableView;

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
    //[self configureView];
    
    //NEED to initialize the array.
    self.repoArray = [[NSMutableArray alloc]init];
    
    self.tableView = [[UITableView alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    [self.tableView registerClass:[RepoTableViewCell class] forCellReuseIdentifier:@"repoCell"];
    [self.view addSubview:self.tableView];
    
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
        // NEED to be stored in Array not dictionary
        NSArray *jsonResponse = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingMutableContainers error:nil];

        self.repoArray = [jsonResponse mutableCopy];
        
        if(self.repoArray){
            //Clean out so this will be called again if data is retrieved again.
            self.receivedData = nil;
            [self.tableView reloadData];
        }
        
        NSLog(@"%@", [self.repoArray description]);
        
        
        }
    }

#pragma mark UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.repoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"repoCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.repoArray[indexPath.row][@"name"];
    return cell;
}

@end
