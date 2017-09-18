//
//  CustomPreviewController.h
//  iTorrent
//
//  Created by VerVelde on 06/27/2015.
//  Copyright (c) 2015 VerVelde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPreviewController : UIViewController
{
	UITextView *textView;
}

+(BOOL)canHandleExtension:(NSString *)fileExt;
- (instancetype)initWithFile:(NSString *)file;

@end
