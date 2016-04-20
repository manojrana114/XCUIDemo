//
//  ViewController.m
//  XCUIDemo
//
//  Created by Manoj Pratap on 11/04/16.
//  Copyright © 2016 impetus. All rights reserved.
//

#import "ViewController.h"
#define CELL_IDENTIFIER @"cell0"
@interface ViewController ()

@property (nonatomic ,strong)NSMutableArray *tableData;

@property (nonatomic ,strong)NSArray *filteredData;

@property (nonatomic,strong) UISearchController *searchController;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //Initailize initial data fro table
    self.tableData=[NSMutableArray arrayWithArray:@[@"colour 1",@"colour 2"]];
    //Register cell with table view
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
    
    //Passing nil so that same controller will act as SerachResultController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.searchController.searchResultsUpdater = self;
    
    [self.searchController.searchBar sizeToFit];
    //Add searchbar to table header
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //assign delegate
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate=self;
    
    self.searchController.dimsBackgroundDuringPresentation=NO;
    self.definesPresentationContext = NO;
    
    
    
}


#pragma mark - UITableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.filteredData!=nil?self.filteredData.count:self.tableData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    cell.textLabel.text=self.filteredData!=nil?self.filteredData[indexPath.row]:self.tableData[indexPath.row];
    
    return  cell;
}
#pragma mark :Table editing

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        [self.tableData removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
    }
}
//-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
//}

- (void)filterContentForSearchText:(NSString*)searchText
{
    if(searchText!=nil && searchText.length>0){
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText]; // if you need case sensitive search avoid '[c]' in the predicate
        
        self.filteredData = [self.tableData filteredArrayUsingPredicate:predicate];
        
        
    }else{
        self.filteredData=nil;
        
    }
}
- (IBAction)addColor:(id)sender {
    [self.tableData addObject:[NSString stringWithFormat:@"colour %lu",(unsigned long)self.tableData.count+1]];
    [self.tableView reloadData];
}
#pragma mark SearchBarDelegate methods
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.filteredData=nil;
    [self.tableView reloadData];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self filterContentForSearchText:searchBar.text];
    [self.tableView reloadData];
    
    
}

@end
