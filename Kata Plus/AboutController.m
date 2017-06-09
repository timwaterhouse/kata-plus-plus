//
//  AboutController.m
//  Kata Counter
//
//  Created by Tim Waterhouse on 24/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutController.h"


@implementation AboutController
@synthesize webView, version, adSwitch, trackSwitch, adButton, spinner, dimView, validProduct;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([SKPaymentQueue canMakePayments]) {
		NSLog(@"In-App Purchases are enabled");
		
		SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:@"com.obdurodon.kata.support"]];
		productsRequest.delegate = self;
		[productsRequest start];
	} else {
		NSLog(@"In-App Purchases are disabled");
	}
	
//	NSString *htmlString = [[NSString alloc] init];
    NSString *htmlString;
	htmlString = @" <html>\
					<head>\
					<style type=\"text/css\">\
					body {font-family: \"futura\"; font-size: 12;}\
					</style>\
					</head>\
					<body>\
					<center>\
					Timothy Waterhouse<br>\
					<a href=\"mailto:support@obdurodon.com\">support@obdurodon.com</a>\
					</center>\
					</body>\
					</html>";
	//htmlString = @"hi";
	[webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@""]];
	[htmlString release];
	
	UIScrollView *scrollView = [[webView subviews] lastObject];
	scrollView.scrollEnabled = FALSE;
	
	NSString *theVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	version.text = [@"Version " stringByAppendingString:theVersion];
	
	adSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"showAds"];
	trackSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"track"];
	adButton.hidden = ![[NSUserDefaults standardUserDefaults] boolForKey:@"showAds"];
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    UIScreenMode *screenMode = [mainScreen currentMode];
    CGSize size = [screenMode size];

    dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    dimView.backgroundColor = [UIColor blackColor];
    dimView.alpha = 0.0f;
    dimView.userInteractionEnabled = NO;
    [self.view addSubview:dimView];

}

- (IBAction)backgroundTap:(id)sender {
//	[self.navigationController setNavigationBarHidden:NO];
	[self dismissViewControllerAnimated:YES completion:nil];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType;
{
	NSURL *loadURL = [ [ request URL ] retain ]; // retain the loadURL for use
	// Check if the scheme is http/https. You can also use these for custom links to open parts of your application.
	if (([[loadURL scheme ] isEqualToString: @"http" ] || [[ loadURL scheme ] isEqualToString: @"mailto" ] 
		  || [ [ loadURL scheme ] isEqualToString: @"https" ] ) && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) 
		// Auto release the loadurl because we wont get to release later.
		// then return the opposite of openURL, so if safari cant open the url, open it in the UIWebView.
		return ![ [ UIApplication sharedApplication ] openURL: [ loadURL autorelease ] ]; 
	[ loadURL release ];
	return YES; // URL is not http/https and should open in UIWebView
}

- (IBAction)switchChanged:(id)sender {
	[[NSUserDefaults standardUserDefaults] setBool:[(UISwitch *)sender isOn] forKey:@"showAds"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)trackSwitchChanged:(id)sender {
	[[NSUserDefaults standardUserDefaults] setBool:[(UISwitch *)sender isOn] forKey:@"track"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)adButtonPressed:(id)sender
{
    SKPayment *payment = [SKPayment paymentWithProduct:self.validProduct];
	[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
	[[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
	self.validProduct = nil;
	NSUInteger count = [response.products count];
	if (count > 0) {
		self.validProduct = [response.products objectAtIndex:0];
	} else if (!self.validProduct) {
		NSLog(@"No products available");
	}
    
    if (self.validProduct)
    {
        NSLog(@"Product title: %@" , self.validProduct.localizedTitle);
        NSLog(@"Product description: %@" , self.validProduct.localizedDescription);
        NSLog(@"Product price: %@" , self.validProduct.price);
        NSLog(@"Product id: %@" , self.validProduct.productIdentifier);
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:self.validProduct.priceLocale];
        NSString *formattedString = [numberFormatter stringFromNumber:self.validProduct.price];
        [numberFormatter release];
        NSLog(@"Localised Product price: %@" , formattedString);
    }
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        NSLog(@"Invalid product id: %@" , invalidProductId);
    }

}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
	for (SKPaymentTransaction *transaction in transactions) {
		switch (transaction.transactionState) {
			case SKPaymentTransactionStatePurchasing:
                [spinner startAnimating];
                dimView.alpha = 0.3f;
                self.view.userInteractionEnabled = NO;

				break;
				
			case SKPaymentTransactionStatePurchased:
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showAds"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                adButton.hidden = YES;
                UIAlertView *supportAlert = [[UIAlertView alloc]
                                               initWithTitle:nil
                                               message:@"Thanks! Your kindness has not gone unnoticed."
                                               delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
                [supportAlert show];
                [supportAlert release];

				
				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				
                [spinner stopAnimating];
                dimView.alpha = 0.0f;
                self.view.userInteractionEnabled = YES;
				break;
				
			case SKPaymentTransactionStateRestored:
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showAds"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                adButton.hidden = YES;
                UIAlertView *supportAlert2 = [[UIAlertView alloc]
                                             initWithTitle:nil
                                             message:@"It looks like you've already helped out.  Thanks! Your kindness has not gone unnoticed."
                                             delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
                [supportAlert2 show];
                [supportAlert2 release];

				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				
                [spinner stopAnimating];
                dimView.alpha = 0.0f;
                self.view.userInteractionEnabled = YES;
				break;
				
			case SKPaymentTransactionStateFailed:
				if (transaction.error.code != SKErrorPaymentCancelled) {
					NSLog(@"An error encounterd");
				}
				
				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				
                [spinner stopAnimating];
                dimView.alpha = 0.0f;
                self.view.userInteractionEnabled = YES;
				break;
                
            case SKPaymentTransactionStateDeferred:
                break;
		}
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	self.webView = nil;
	self.version = nil;
	self.adSwitch = nil;
    self.adButton = nil;
    self.spinner = nil;
    self.dimView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[webView release];
	[version release];
	[adSwitch release];
    [adButton release];
    [spinner release];
    [dimView release];
    [super dealloc];
}


@end
