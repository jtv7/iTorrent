//
//  CustomPreviewController.m
//  iTorrent
//
//  Created by VerVelde on 06/27/2015.
//  Copyright (c) 2015 VerVelde. All rights reserved.
//

#import "CustomPreviewController.h"

@interface CustomPreviewController ()

@end

@implementation CustomPreviewController

- (instancetype)initWithFile:(NSString *)file
{
	self = [super init];
	if (self) {
		textView = [[UITextView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
		textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		textView.editable = NO;
		
		self.view = textView;
		
		[self loadFile:file];
	}
	return self;
}

+(BOOL)canHandleExtension:(NSString *)fileExt
{
	return ([fileExt isEqualToString:@"plist"] || [fileExt isEqualToString:@"strings"]);
}

-(void)loadFile:(NSString *)file
{
	if ([file.pathExtension isEqualToString:@"plist"] || [file.pathExtension isEqualToString:@"strings"])
	{
		NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:file];
		[textView setText:[d description]];
	}
	
	self.title = file.lastPathComponent;
}

@end
