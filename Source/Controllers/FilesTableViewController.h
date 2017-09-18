//
//  FilesTableViewController.h
//  iTorrent
//
//  Created by VerVelde on 06/27/2015.
//  Copyright (c) 2015 VerVelde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface FilesTableViewController : UITableViewController <QLPreviewControllerDataSource>

- (id)initWithPath:(NSString *)path;

@property NSString *path;
@property NSArray *files;
@end
