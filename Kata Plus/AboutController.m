//
//  AboutController.m
//  Kata Counter
//
//  Created by Tim Waterhouse on 24/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutController.h"


@implementation AboutController
@synthesize webView, version, adSwitch;

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
					Obdurodon LLC<br>\
					<a href=\"http://obdurodon.com\">obdurodon.com</a><br>\
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
}

- (IBAction)backgroundTap:(id)sender {
//	[self.navigationController setNavigationBarHidden:NO];
	[self dismissModalViewControllerAnimated:YES];
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

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	self.webView = nil;
	self.version = nil;
	self.adSwitch = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[webView release];
	[version release];
	[adSwitch release];
    [super dealloc];
}


@end
