//
//  RSSTableViewController.h
//  CYHS
//
//  Created by Alex Santarelli on 8/21/16.
//  Copyright © 2016 Alex Santarelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RSSTableViewCell.h"

@interface RSSTableViewController : UITableViewController <NSXMLParserDelegate>{
    NSString *rssFeedURL;
}


//@property (strong, nonatomic) IBOutlet UITableView *eventsTableView;


@end
