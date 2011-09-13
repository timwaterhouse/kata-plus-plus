//
//  AboutController.h
//  Kata Counter
//
//  Created by Tim Waterhouse on 24/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <MessageUI/MessageUI.h>
//#import <MessageUI/MFMailComposeViewController.h>


//@interface AboutController : UIViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate> {
@interface AboutController : UIViewController <UIWebViewDelegate> {
	UIWebView *webView;
	UILabel *version;
	UISwitch *adSwitch;
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UILabel *version;
@property (nonatomic, retain) IBOutlet UISwitch *adSwitch;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)switchChanged:(id)sender;
@end
