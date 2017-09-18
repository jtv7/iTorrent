//
//  FilesTableViewController.m
//  iTorrent
//
//  Created by VerVelde on 06/27/2015.
//  Copyright (c) 2015 VerVelde. All rights reserved.
//

#import "FilesTableViewController.h"
#import "CustomPreviewController.h"

@interface FilesTableViewController ()

@end

@implementation FilesTableViewController

NSURL *ptMovie;
NSString *ptTable;

- (id)initWithPath:(NSString *)path
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
		self.path = path;
		
		self.title = [path lastPathComponent];
		
		NSError *error = nil;
		NSArray *tempFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
		
		if (error)
		{
			NSLog(@"ERROR: %@", error);
		}
		
		self.files = [tempFiles sortedArrayWithOptions:0 usingComparator:^NSComparisonResult(NSString* file1, NSString* file2) {
			NSString *newPath1 = [self.path stringByAppendingPathComponent:file1];
			NSString *newPath2 = [self.path stringByAppendingPathComponent:file2];

			BOOL isDirectory1, isDirectory2;
			[[NSFileManager defaultManager ] fileExistsAtPath:newPath1 isDirectory:&isDirectory1];
			[[NSFileManager defaultManager ] fileExistsAtPath:newPath2 isDirectory:&isDirectory2];
			
			if (isDirectory1 && !isDirectory2)
				return NSOrderedDescending;
			
			return  NSOrderedAscending;
		}];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES - we will be able to delete all rows
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self listFileAtPath:self.path].count;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        ptMovie = [self.files objectAtIndex:indexPath.row];
        ptTable = [NSString stringWithFormat:@"%@/%@", self.path, ptMovie];
        
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:ptTable error: &error];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	
	NSString *newPath = [self.path stringByAppendingPathComponent:self.files[indexPath.row]];
	
    BOOL isDirectory;
	BOOL fileExists = [[NSFileManager defaultManager ] fileExistsAtPath:newPath isDirectory:&isDirectory];
	
    cell.textLabel.text = self.files[indexPath.row];
	
	if (isDirectory)
		cell.imageView.image = [UIImage imageNamed:@"Folder"];
    
	else if ([[newPath pathExtension] isEqualToString:@"png"] || [[newPath pathExtension] isEqualToString:@"jpg"] || [[newPath pathExtension] isEqualToString:@"jpeg"] || [[newPath pathExtension] isEqualToString:@"tiff"] || [[newPath pathExtension] isEqualToString:@"gif"])
		cell.imageView.image = [UIImage imageNamed:@"Picture"];
    
    else if ([[newPath pathExtension] isEqualToString:@"torrent"])
        cell.imageView.image = [UIImage imageNamed:@"Torrent"];
    
    else if ([[newPath pathExtension] isEqualToString:@"mp3"] || [[newPath pathExtension] isEqualToString:@"m4a"] || [[newPath pathExtension] isEqualToString:@"flac"] || [[newPath pathExtension] isEqualToString:@"wav"] || [[newPath pathExtension] isEqualToString:@"ogg"] || [[newPath pathExtension] isEqualToString:@"aiff"])
        cell.imageView.image = [UIImage imageNamed:@"Audio"];
    
    else if ([[newPath pathExtension] isEqualToString:@"mp4"] || [[newPath pathExtension] isEqualToString:@"m4v"] || [[newPath pathExtension] isEqualToString:@"mov"] || [[newPath pathExtension] isEqualToString:@"avi"] || [[newPath pathExtension] isEqualToString:@"mkv"] || [[newPath pathExtension] isEqualToString:@"wmv"] || [[newPath pathExtension] isEqualToString:@"flv"] || [[newPath pathExtension] isEqualToString:@"mpg"])
        cell.imageView.image = [UIImage imageNamed:@"Video"];
    
    else if ([[newPath pathExtension] isEqualToString:@"pdf"])
        cell.imageView.image = [UIImage imageNamed:@"PDF"];
    
    else if ([[newPath pathExtension] isEqualToString:@"zip"] || [[newPath pathExtension] isEqualToString:@"bzip"] || [[newPath pathExtension] isEqualToString:@"rar"] || [[newPath pathExtension] isEqualToString:@"bzip"] || [[newPath pathExtension] isEqualToString:@"tar"] || [[newPath pathExtension] isEqualToString:@"gz"] || [[newPath pathExtension] isEqualToString:@"bz"] || [[newPath pathExtension] isEqualToString:@"bzip2"] || [[newPath pathExtension] isEqualToString:@"bz2"] || [[newPath pathExtension] isEqualToString:@"cpgz"] || [[newPath pathExtension] isEqualToString:@"bin"] || [[newPath pathExtension] isEqualToString:@"7z"])
        cell.imageView.image = [UIImage imageNamed:@"ZIP"];
    
    else if ([[newPath pathExtension] isEqualToString:@"rtfd"] || [[newPath pathExtension] isEqualToString:@"txt"] || [[newPath pathExtension] isEqualToString:@"rtf"])
        cell.imageView.image = [UIImage imageNamed:@"Text"];
    
    else if ([[newPath pathExtension] isEqualToString:@"html"] || [[newPath pathExtension] isEqualToString:@"xml"] || [[newPath pathExtension] isEqualToString:@"htm"] || [[newPath pathExtension] isEqualToString:@"plist"])
        cell.imageView.image = [UIImage imageNamed:@"HTML"];
    
    else if ([[newPath pathExtension] isEqualToString:@"iso"] || [[newPath pathExtension] isEqualToString:@"dmg"] || [[newPath pathExtension] isEqualToString:@"vmdk"] || [[newPath pathExtension] isEqualToString:@"img"])
        cell.imageView.image = [UIImage imageNamed:@"Disk"];
    
    else if ([[newPath pathExtension] isEqualToString:@"doc"] || [[newPath pathExtension] isEqualToString:@"docx"])
        cell.imageView.image = [UIImage imageNamed:@"Word"];
    
    else if ([[newPath pathExtension] isEqualToString:@"ppt"] || [[newPath pathExtension] isEqualToString:@"pptx"])
        cell.imageView.image = [UIImage imageNamed:@"PowerPoint"];
    
    else if ([[newPath pathExtension] isEqualToString:@"xls"] || [[newPath pathExtension] isEqualToString:@"xlsx"])
        cell.imageView.image = [UIImage imageNamed:@"Excel"];
    
    else if ([[newPath pathExtension] isEqualToString:@"srt"] || [[newPath pathExtension] isEqualToString:@"sub"])
        cell.imageView.image = [UIImage imageNamed:@"Subtitle"];
    
	else
		cell.imageView.image = nil;
	
    
//	if (fileExists && !isDirectory)
//		cell.accessoryType = UITableViewCellAccessoryDetailButton;
//	else
//		cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *newPath = [self.path stringByAppendingPathComponent:self.files[indexPath.row]];
	
	
	BOOL isDirectory;
	BOOL fileExists = [[NSFileManager defaultManager ] fileExistsAtPath:newPath isDirectory:&isDirectory];
	
	
	if (fileExists)
	{
		if (isDirectory)
		{
			FilesTableViewController *vc = [[FilesTableViewController alloc] initWithPath:newPath];
			[self.navigationController pushViewController:vc animated:YES];
		}
		else if ([CustomPreviewController canHandleExtension:[newPath pathExtension]])
		{
			CustomPreviewController *preview = [[CustomPreviewController alloc] initWithFile:newPath];
			[self.navigationController pushViewController:preview animated:YES];
		}
		else
		{
			QLPreviewController *preview = [[QLPreviewController alloc] init];
			preview.dataSource = self;
			
			[self.navigationController pushViewController:preview animated:YES];
		}
	}
}

-(NSArray *)listFileAtPath:(NSString *)path
{
    int count;
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++)
    {
        [directoryContent objectAtIndex:count];
    }
    return directoryContent;
}

#pragma mark - QuickLook

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item {
	
    return YES;
}

- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller {
    return 1;
}

- (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index {
	
	NSString *newPath = [self.path stringByAppendingPathComponent:self.files[self.tableView.indexPathForSelectedRow.row]];
	
    return [NSURL fileURLWithPath:newPath];
}

@end
