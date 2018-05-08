//
//  RSSTableViewController.m
//  CYHS
//
//  Created by Alex Santarelli on 8/21/16.
//  Copyright © 2016 Alex Santarelli. All rights reserved.
//

#import "RSSTableViewController.h"


@interface RSSTableViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSString *element;
}

@end

@implementation RSSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    [self setTitle:@"Events"];
    
    
//    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iPhone Background 1"]];
//
//    self.tableView.backgroundView = background;
//
//    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    [blurEffectView setFrame:self.view.frame];
//    [self.tableView.backgroundView addSubview:blurEffectView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //NSString *currentRSSStringURL = @"http://hs.cysd.k12.pa.us/syndication/rss.aspx?serverid=3161958&userid=5&feed=portalcalendarevents&key=NAx4FrYA6cB46mWyKU%2fl%2flQs9SdOvKaegd0LCednnwGJoKe%2bdBuPQpWXfilBEtkRbnNYJR69VBlUFVBmXZBVeA%3d%3d&portal_id=3162042&page_id=3162064&calendar_context_id=3163089&portlet_instance_id=318554&calendar_id=3163090&v=2.0";
    NSString *currentRSSStringURL = @"http://25livepub.collegenet.com/calendars/LUM-home_test.rss";
    //If that does not appear to work, replace
    // feed:// with http://
    
    feeds = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:currentRSSStringURL];

    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    [parser setDelegate:self];

    [parser setShouldResolveExternalEntities:NO];

    [parser parse];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rssCell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    
    //Title Label Code
    cell.eventTitle.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
   // cell.eventTitleLabel.textColor = [UIColor whiteColor];
    //cell.eventTitleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    //cell.eventTitleLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
   // cell.eventTitleLabel.layer.shadowRadius = 2.5; //5.0 was pretty good
   // cell.eventTitleLabel.layer.shadowOpacity = .9;
   // cell.eventTitleLabel.layer.masksToBounds = NO;
   // cell.eventTitleLabel.layer.shouldRasterize = YES;
    
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    printf("%s\n", [elementName cStringUsingEncoding:NSUTF8StringEncoding]);
    printf("%s\n", attributeDict);
    
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"EventsShowDetail"]) {
        
      //  CYWebViewController *webView = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *string = [feeds[indexPath.row] objectForKey: @"link"];
        
        NSString *eventTitle = [feeds[indexPath.row] objectForKey:@"title"];
        
        NSLog(@"URL Passed from the RSS Feed: %@", string);
         
      //  [webView setEventRSSSite:YES];
        
        //[webView setUrlString:string];
 
        //[webView setPasswordSaveSite:NO];
        
      //  [webView setTitle:eventTitle];
        
    }
}

@end
