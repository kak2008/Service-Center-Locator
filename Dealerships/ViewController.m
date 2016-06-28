//
//  ViewController.m
//  Dealerships
//
//  Created by Home on 5/10/16.
//  Copyright © 2016 Kumar. All rights reserved.
//

#import "ViewController.h"
#import "Dealership.h"
#import "DealershipTableViewCell.h"

static NSString * const kInvalidResponse = @"Sorry for the inconvenience, we are not able to retrieve the requested data please try again later.";

static NSString * const kNoDataAvailable = @"Sorry there are no dealerships available near your location, please pull down to refresh";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *dealershipTableView;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (nonatomic, strong) NSMutableArray *dealerships;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dealershipTableView.dataSource = self;
    _dealershipTableView.delegate = self;
    
    _dealershipTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _dealershipTableView.allowsSelection = NO;
    
    _errorLabel.hidden = YES;
    _dealerships = [NSMutableArray new];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(createRequestToFetchDealers) forControlEvents:UIControlEventValueChanged];
    
    [_dealershipTableView addSubview:_refreshControl];
    
    [self createRequestToFetchDealers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dealerships.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DealershipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dealershipCell"];
    [cell fillWithDealership:[_dealerships objectAtIndex:indexPath.row]];
    cell.backgroundColor = [UIColor darkGrayColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DealershipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dealershipCell"];
    [cell fillWithDealership:[_dealerships objectAtIndex:indexPath.row]];
    
    [cell layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height + 1;
}

#pragma mark - Webservice Request Methods

- (void)createRequestToFetchDealers {
    
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:9999/dealers/dealers.php?lat=%0.6f&lng=%0.6f", [[UserLocationManager sharedManager] lastKnownLocation].coordinate.latitude, [[UserLocationManager sharedManager] lastKnownLocation].coordinate.longitude];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    if (_refreshControl.refreshing) {
                                                        [_refreshControl endRefreshing];
                                                    }
                                                    
                                                    _errorLabel.hidden = YES;
                                                });
                                                
                                                if (error) {
                                                    NSLog(@"Error: %@", error.localizedDescription);
                                                    [self displayErrorLabelWithErrorMessage:kInvalidResponse];
                                                    return;
                                                }
                                                
                                                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                BOOL isGoodResponse = (httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299);
                                                
                                                if (!isGoodResponse) {
                                                    [self displayErrorLabelWithErrorMessage:kInvalidResponse];
                                                    return;
                                                }
                                                
                                                NSDictionary *dataDict = [self dictionaryFromNSData:data];
                                                if (!dataDict) {
                                                    [self displayErrorLabelWithErrorMessage:kNoDataAvailable];
                                                    return;
                                                }
                                                
                                                [self didGetDealershipList:dataDict];
                                            }];
    [task resume];
}

- (NSDictionary *)dictionaryFromNSData:(NSData *)data {
    
    NSError *error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&error];
    
    if (error) {
        NSLog(@"Convertion Error: %@", error.localizedDescription);
        return nil;
    }
    
    return dictionary;
}

- (void)displayErrorLabelWithErrorMessage:(NSString *)message {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _errorLabel.hidden = NO;
        _errorLabel.text = message;
    });
    
}

- (void)didGetDealershipList:(NSDictionary *)dictionary {
    
    [_dealerships removeAllObjects];
    
    if (![self isNull:dictionary key:@"dealerships"]) {
        NSArray *list = [dictionary objectForKey:@"dealerships"];
        for (NSDictionary *dealershipDict in list) {
            Dealership *dealership = [[Dealership alloc] initWithDictionary:dealershipDict];
            [_dealerships addObject:dealership];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_dealershipTableView reloadData];
    });
}

- (BOOL)isNull:(NSDictionary *)dictionary key:(NSString *)key {
    return (!dictionary || ![dictionary objectForKey:key] || [dictionary objectForKey:key] == [NSNull null]);
}

@end
