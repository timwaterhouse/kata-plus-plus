//
//  AboutController.h
//  Kata Counter
//
//  Created by Tim Waterhouse on 24/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

//#import <MessageUI/MessageUI.h>
//#import <MessageUI/MFMailComposeViewController.h>


//@interface AboutController : UIViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate> {
@interface AboutController : UIViewController <UIWebViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver> {
	UIWebView *webView;
	UILabel *version;
	UISwitch *adSwitch;
	UISwitch *trackSwitch;
    UIActivityIndicatorView *spinner;
    UIView *dimView;
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UILabel *version;
@property (nonatomic, retain) IBOutlet UISwitch *adSwitch;
@property (nonatomic, retain) IBOutlet UISwitch *trackSwitch;
@property (nonatomic, retain) IBOutlet UIButton *adButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UIView *dimView;
@property (strong, nonatomic) SKProduct *validProduct;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)switchChanged:(id)sender;
- (IBAction)trackSwitchChanged:(id)sender;
- (IBAction)adButtonPressed:(id)sender;
@end
