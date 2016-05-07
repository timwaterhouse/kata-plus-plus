//
//  Detail.m
//  Kata Counter
//
//  Created by Tim Waterhouse on 22/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "DetailController.h"
#import "Kata.h"

#define kNameTag	0
#define kTotalTag	1

@implementation DetailController
@synthesize nameField, totalField, kata;
@synthesize textFieldBeingEdited;
@synthesize tempValues;
@synthesize newKata, newTechnique;

- (void)buttonPressed:(id)sender {
	[tempValues setObject:[NSNumber numberWithInt:([[tempValues objectForKey:[NSNumber numberWithInt:1]] intValue]
						   + [sender tag])]
				   forKey:[NSNumber numberWithInt:1]];
	totalField.text = [NSString stringWithFormat:@"%@", [tempValues objectForKey:[NSNumber numberWithInt:1]]];
}

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

- (IBAction)cancel:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
//	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender {
	if (textFieldBeingEdited != nil) {
		NSNumber *tagAsNum = [[NSNumber alloc] initWithLong:textFieldBeingEdited.tag];
		[tempValues setObject:textFieldBeingEdited.text forKey:tagAsNum];
		[tagAsNum release];
	}
	for (NSNumber *key in [tempValues allKeys]) {
		switch ([key intValue]) {
			case 0:
				kata.name = [tempValues objectForKey:key];
				break;
			case 1:
				kata.total = [[tempValues objectForKey:key] intValue];
			default:
				break;
		}
	}
	if (self.newKata) {
		NSArray *allControllers = self.navigationController.viewControllers;
		UITableViewController *parent = [allControllers objectAtIndex:0];
		[((RootViewController *)parent).kataArray insertObject:kata atIndex:0];
	}
	if (self.newTechnique) {
		NSArray *allControllers = self.navigationController.viewControllers;
		UITableViewController *parent = [allControllers objectAtIndex:0];
		[((RootViewController *)parent).techniqueArray insertObject:kata atIndex:0];
	}
//	[self.navigationController popViewControllerAnimated:YES];
	[self.navigationController popToRootViewControllerAnimated:YES];

	// Couldn't get this reloadData to work, so I put it in viewWillAppear in RootViewController.m
	/*
	NSArray *allControllers = self.navigationController.viewControllers;
	UITableViewController *parent = [allControllers lastObject];
	[parent.tableView reloadData];
	 */
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
//    NSString *verticalConstraint = @"V:|[v]|";
//    NSMutableDictionary *views = [NSMutableDictionary new];
//    NSMutableArray *constraints = [NSMutableArray new];
//    views[@"v"] = self.view;
//    if ([self respondsToSelector:@selector(topLayoutGuide)]) {
//        views[@"topLayoutGuide"] = self.topLayoutGuide;
//        verticalConstraint = @"V:[topLayoutGuide][v]|";
//    }
//    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:verticalConstraint options:0 metrics:nil views:views]];
//    [self.view addConstraints:constraints];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
																	 style:UIBarButtonItemStylePlain
																	target:self
																	action:@selector(cancel:)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
																	 style:UIBarButtonItemStyleDone
																	target:self
																	action:@selector(save:)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	self.tempValues = dict;
	[dict release];
	[tempValues setObject:[NSNumber numberWithUnsignedInteger:kata.total] forKey:[NSNumber numberWithInt:1]];
	
	self.nameField.text = kata.name;
	NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
	[nf setGroupingSize:3];
	[nf setUsesGroupingSeparator:NO];
	NSString *totalString = [nf stringFromNumber:[NSNumber numberWithInteger:kata.total]];
	self.totalField.text = totalString;
	[nf release];
}

- (IBAction)deleteButtonPressed:(id)sender {
	NSLog(@"delete");
}

- (IBAction)backgroundTap:(id)sender {
	[nameField resignFirstResponder];
	[totalField resignFirstResponder];
}

 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if (interfaceOrientation == UIInterfaceOrientationPortrait)
		return YES;
	return NO;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.nameField = nil;
	self.totalField = nil;
	self.textFieldBeingEdited = nil;
	self.tempValues = nil;
    [super viewDidUnload];
}


- (void)dealloc {
	[nameField release];
	[totalField release];
	[textFieldBeingEdited release];
	[tempValues release];
    [super dealloc];
}

#pragma mark -
#pragma mark Text Field Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	self.textFieldBeingEdited = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	NSNumber *tagAsNum = [[NSNumber alloc] initWithInteger:textField.tag];
	[tempValues setObject:textField.text forKey:tagAsNum];
	[tagAsNum release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

@end
