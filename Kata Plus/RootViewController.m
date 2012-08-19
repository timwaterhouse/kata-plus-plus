//
//  RootViewController.m
//  Kata Plus
//
//  Created by Timothy Waterhouse on 9/5/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "RootViewController.h"
#import "DetailController.h"
#import "Kata.h"
#import "AddNewController.h"
#import "AboutController.h"
#import "UITableViewCellFixed.h"

@implementation RootViewController
@synthesize kataArray, techniqueArray;
@synthesize tableView = _tableView;
@synthesize contentView= _contentView;
@synthesize adBannerView = _adBannerView;
@synthesize adBannerViewIsVisible = _adBannerViewIsVisible;
@synthesize showAds;

#pragma mark -
#pragma mark View lifecycle

- (NSString *)kataDataFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kKataFilename];
} 

- (NSString *)techniqueDataFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kTechniqueFilename];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	showAds = [defaults boolForKey:@"showAds"];
	
	NSString *kataFilePath = [self kataDataFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:kataFilePath]) {
		NSData *kataData = [[NSMutableData alloc] initWithContentsOfFile:kataFilePath];
		NSKeyedUnarchiver *kataUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:kataData];
		self.kataArray = [kataUnarchiver decodeObjectForKey:kKataDataKey];
		[kataUnarchiver finishDecoding];
		[kataUnarchiver release];
		[kataData release];
	} else {
		NSArray *kataNamesArray = [[NSArray alloc] initWithObjects:
                                   @"Taikyoku Shodan", @"Taikyoku Nidan", @"Taikyoku Sandan",
                                   @"Heian Shodan", @"Heian Nidan", @"Heian Sandan", @"Heian Yodan", @"Heian Godan",
                                   @"Bassai", @"Kwanku", @"Empi", @"Gankaku", @"Jutte", @"Hangetsu",
                                   @"Tekki Shodan", @"Tekki Nidan", @"Tekki Sandan", @"Jion", nil];
		self.kataArray = [[NSMutableArray alloc] init];
		for (NSString *name in kataNamesArray) {
			Kata *kata = [[Kata alloc] init];
			kata.name = name;
			[self.kataArray addObject:kata];
			[kata release];
		}
		[kataNamesArray release];
	}
    
    NSString *techniqueFilePath = [self techniqueDataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:techniqueFilePath]) {
		NSData *techniqueData = [[NSMutableData alloc] initWithContentsOfFile:techniqueFilePath];
		NSKeyedUnarchiver *techniqueUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:techniqueData];
		self.techniqueArray = [techniqueUnarchiver decodeObjectForKey:kTechniqueDataKey];
		[techniqueUnarchiver finishDecoding];
		[techniqueUnarchiver release];
		[techniqueData release];
	} else {
		NSArray *techniqueNamesArray = [[NSArray alloc] initWithObjects:
                                        @"Gedan Barai",
                                        @"Ageuke",
                                        @"Udeuke",
                                        @"Tetsui",
                                        @"Shuto-uke",
                                        @"Morote-uke",
                                        @"Kakiwake",
                                        @"Yamagamae",
                                        @"Oizuki",
                                        @"Gyakuzuki",
                                        @"Oizuki",
                                        @"Gyakuzuki",
                                        @"Maete",
                                        @"Kibadachi-zuki",
                                        @"Suwari-zuki",
                                        @"Uraken",
                                        @"Enpi",
                                        @"Maegeri",
                                        @"Mawashigeri",
                                        @"Yokogeri Keage",
                                        @"Yokogeri Kekomi",
                                        @"Mikazukigeri",
                                        @"Fumikomi",
                                        @"Hiza Geri", nil];
        //		NSArray *techniqueNamesArray = [[NSArray alloc] initWithObjects:
        //					  @"Gedan Barai (Down Block)",
        //					  @"Ageuke (Rising Block)",
        //					  @"Udeuke (Forearm Block)",
        //					  @"Tetsui (Hammer Block)",
        //					  @"Shuto-uke (Sword Hand Block)",
        //					  @"Morote-uke (Two Hand Block)",
        //					  @"Kakiwake (Opening Technique)",
        //					  @"Yamagamae (Mountain Posture)",
        //					  @"Oizuki (Front Punch)",
        //					  @"Gyakuzuki (Reverse Punch)",
        //					  @"Oizuki (Front Punch)",
        //					  @"Gyakuzuki (Reverse Punch)",
        //					  @"Maete (Jab)",
        //					  @"Kibadachi-zuki (Punch from Horse Riding Stance)",
        //					  @"Suwari-zuki (Sitting Attack)",
        //					  @"Uraken (Back Fist)",
        //					  @"Enpi (Elbow Attack)",
        //					  @"Maegeri (Front Kick)",
        //					  @"Mawashigeri (Round Kick)",
        //					  @"Yokogeri Keage (Side Up Kick)",
        //					  @"Yokogeri Kekomi (Side Thrust Kick)",
        //					  @"Mikazukigeri (Crescent Kick)",
        //					  @"Fumikomi (Stamping Kick)",
        //					  @"Hiza Geri (Knee  Attack)", nil];
		self.techniqueArray = [[NSMutableArray alloc] init];
		for (NSString *name in techniqueNamesArray) {
			Kata *kata = [[Kata alloc] init];
			kata.name = name;
			[self.techniqueArray addObject:kata];
			[kata release];
		}
		[techniqueNamesArray release];
	}
    
	UIApplication *app = [UIApplication sharedApplication];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(applicationWillResignActive:)
												 name:UIApplicationWillResignActiveNotification
											   object:app];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(applicationWillTerminate:)
												 name:UIApplicationWillTerminateNotification
											   object:app];
	
	
	[self.navigationItem setRightBarButtonItem:self.editButtonItem];
	UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[infoButton addTarget:self action:@selector(infoButtonAction) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
	[self.navigationItem setLeftBarButtonItem:modalButton animated:YES];
	[modalButton release];
	[self.navigationItem setLeftBarButtonItem:modalButton];
	[self.navigationItem setTitle:@"Kata++"];
	
    //	AdWhirlView *adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
    //	[self.view addSubview:adWhirlView];
}

- (void)applicationWillResignActive:(NSNotification *)notification {
	NSMutableData *kataData = [[NSMutableData alloc] init];
	NSKeyedArchiver *kataArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:kataData];
	[kataArchiver encodeObject:kataArray forKey:kKataDataKey];
	[kataArchiver finishEncoding];
	[kataData writeToFile:[self kataDataFilePath] atomically:YES];
	[kataArchiver release];
	[kataData release];
	
	NSMutableData *techniqueData = [[NSMutableData alloc] init];
	NSKeyedArchiver *techniqueArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:techniqueData];
	[techniqueArchiver encodeObject:techniqueArray forKey:kTechniqueDataKey];
	[techniqueArchiver finishEncoding];
	[techniqueData writeToFile:[self techniqueDataFilePath] atomically:YES];
	[techniqueArchiver release];
	[techniqueData release];
}

// make sure objects are achived in iOS pre-4.0
- (void)applicationWillTerminate:(NSNotification *)notification {
	NSMutableData *kataData = [[NSMutableData alloc] init];
	NSKeyedArchiver *kataArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:kataData];
	[kataArchiver encodeObject:kataArray forKey:kKataDataKey];
	[kataArchiver finishEncoding];
	[kataData writeToFile:[self kataDataFilePath] atomically:YES];
	[kataArchiver release];
	[kataData release];
	
	NSMutableData *techniqueData = [[NSMutableData alloc] init];
	NSKeyedArchiver *techniqueArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:techniqueData];
	[techniqueArchiver encodeObject:techniqueArray forKey:kTechniqueDataKey];
	[techniqueArchiver finishEncoding];
	[techniqueData writeToFile:[self techniqueDataFilePath] atomically:YES];
	[techniqueArchiver release];
	[techniqueData release];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	showAds = [[NSUserDefaults standardUserDefaults] boolForKey:@"showAds"];
	if (showAds)
		[self createAdBannerView];
	[self.tableView reloadData];
    //	[self fixupAdView:[UIDevice currentDevice].orientation];
	[self fixupAdView:UIInterfaceOrientationPortrait];
}

- (void)infoButtonAction {
	AboutController *aboutController = [[AboutController alloc] init];
	aboutController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:aboutController animated:YES];
	[aboutController release];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
    //	if (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown)
    //		return YES;
    //	return NO;
	if (interfaceOrientation == UIInterfaceOrientationPortrait)
		return YES;
	return NO;
}

/*
 - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
 duration:(NSTimeInterval)duration {
 if (showAds) {
 [_adBannerView rotateToOrientation:toInterfaceOrientation];
 
 CGSize adSize = [_adBannerView actualAdSize];
 CGRect newFrame = _adBannerView.frame;
 
 newFrame.size = adSize;
 if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
 newFrame.origin.x = (320 - adSize.width)/ 2;
 } else {
 newFrame.origin.x = (480 - adSize.width)/ 2;
 }
 
 _adBannerView.frame = newFrame;
 [self fixupAdView:toInterfaceOrientation];		
 }
 }
 */

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case kAddNewSection:
			if (self.isEditing)
				return 0;
			else 
				return 1;
			break;
		case kKataSection:
			return [kataArray count];
			break;
		case kTechniqueSection:
			return [techniqueArray count];
			break;
		default:
			return 0;
			break;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case kAddNewSection:
			return nil;
			break;
		case kKataSection:
			return @"Kata";
			break;
		case kTechniqueSection:
			return @"Technique";
			break;
		default:
			return nil;
			break;
	}
	/*
     if (section == kKataSection) {
     return @"Kata";
     } else {
     return @"Technique";
     }
	 */
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCellFixed *cell = (UITableViewCellFixed *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCellFixed alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	NSUInteger total;
	NSString *totalString;
	switch ([indexPath section]) {
		case kAddNewSection:
			cell.textLabel.text = @"Add New Kata/Technique...";
			break;
		case kKataSection:
			cell.textLabel.text = [[kataArray objectAtIndex:[indexPath row]] name];
            //            cell.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
			total = [[kataArray objectAtIndex:[indexPath row]] total];
			if (total != 0) {
				NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
				[nf setGroupingSize:3];
				[nf setUsesGroupingSeparator:YES];
				totalString = [nf stringFromNumber:[NSNumber numberWithInteger:total]];
				cell.detailTextLabel.text = totalString;
				[nf release];
			} else
				cell.detailTextLabel.text = nil;
			break;
		case kTechniqueSection:
			cell.textLabel.text = [[techniqueArray objectAtIndex:[indexPath row]] name];
			total = [[techniqueArray objectAtIndex:[indexPath row]] total];
			if (total != 0) {
				NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
				[nf setGroupingSize:3];
				[nf setUsesGroupingSeparator:YES];
				totalString = [nf stringFromNumber:[NSNumber numberWithInteger:total]];
				cell.detailTextLabel.text = totalString;
				[nf release];
			} else 
				cell.detailTextLabel.text = nil;
			break;
		default:
			break;
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source.
		if ([indexPath section] == kKataSection) {
			[kataArray removeObjectAtIndex:[indexPath row]];
		} else {
			[techniqueArray removeObjectAtIndex:[indexPath row]];
		}
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
						 withRowAnimation:UITableViewRowAnimationFade];
		
	}   
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
		Kata *kata = [[Kata alloc] init];
		DetailController *detailController = [[DetailController alloc] initWithNibName:@"DetailController" bundle:nil];
		if ([indexPath section] == kKataSection) {
			detailController.newKata = YES;
			detailController.title = @"Add Kata";
		} else {
			detailController.newTechnique = YES;
			detailController.title = @"Add Technique";
		}
		detailController.kata = kata;
		[self.navigationController pushViewController:detailController animated:YES];
		[detailController release];
		[kata release];
	}   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
	if ([fromIndexPath section] == kKataSection) {
		Kata *kata = [kataArray objectAtIndex:[fromIndexPath row]];
		[kata retain];
		[kataArray removeObjectAtIndex:[fromIndexPath row]];
		[kataArray insertObject:kata atIndex:[toIndexPath row]];
		[kata release];
	} else {
		Kata *kata = [techniqueArray objectAtIndex:[fromIndexPath row]];
		[kata retain];
		[techniqueArray removeObjectAtIndex:[fromIndexPath row]];
		[techniqueArray insertObject:kata atIndex:[toIndexPath row]];
		[kata release];
	}
}

- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	// Make sure we can't drag rows between sections
	if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
		NSInteger row = 0;
		if (sourceIndexPath.section < proposedDestinationIndexPath.section) {
			row = [self tableView:tableView numberOfRowsInSection:sourceIndexPath.section] - 2;
		}
		return [NSIndexPath indexPathForRow:row inSection:sourceIndexPath.section];     
	}
	
	// Make sure we can't drag rows past the "add new" row
	int theCount;
	if ([sourceIndexPath section] == kKataSection)
		theCount = [kataArray count];
	else 
		theCount = [techniqueArray count];
	if ([proposedDestinationIndexPath row] < theCount)
		return proposedDestinationIndexPath;
	NSIndexPath *betterIndexPath = [NSIndexPath indexPathForRow:theCount-1
													  inSection:[sourceIndexPath section]];
	return betterIndexPath;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Detemine if it's in editing mode
//    if (self.editing) {
    if (self.editing | ([indexPath section]!=kAddNewSection)) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}


- (void)setEditing:(BOOL)flag animated:(BOOL)animated {
	[super setEditing:flag animated:animated];
	[self.tableView setEditing:flag animated:animated];
	
	// Remove the "add new..." row when editing
	if (flag) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0	inSection:0];
		NSMutableArray *paths = [NSMutableArray arrayWithObject:indexPath];
		[self.tableView deleteRowsAtIndexPaths:paths
							  withRowAnimation:UITableViewRowAnimationFade];
	} else {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0	inSection:0];
		NSMutableArray *paths = [NSMutableArray arrayWithObject:indexPath];
		[self.tableView insertRowsAtIndexPaths:paths
							  withRowAnimation:UITableViewRowAnimationLeft];		
	}
	
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	// Return NO if you do not want the item to be re-orderable.
	if ([indexPath section] == kKataSection) {
		if ([indexPath row] < [kataArray count]) {
			return YES;
		}
	} else {
		if ([indexPath row] < [techniqueArray count]) {
			return YES;
		}
	}
	return NO;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// ...
	// Pass the selected object to the new view controller.
	if ([indexPath section] == kAddNewSection) {
		AddNewController *addNewController = [[AddNewController alloc] initWithStyle:UITableViewStyleGrouped];
		[self.navigationController pushViewController:addNewController animated:YES];
		[addNewController release];
	} else {
		DetailController *detailController = [[DetailController alloc] initWithNibName:@"DetailController" bundle:nil];
		if ([indexPath section] == kKataSection) {
			detailController.kata = [kataArray objectAtIndex:[indexPath row]];
			detailController.title = @"Edit Kata";
		} else {
			detailController.kata = [techniqueArray objectAtIndex:[indexPath row]];
			detailController.title = @"Edit Technique";
		}
		[self.navigationController pushViewController:detailController animated:YES];
		[detailController release];
	}
}

/*
 #pragma mark -
 #pragma mark ADBannerViewDelegate
 
 - (void)bannerViewDidLoadAd:(ADBannerView *)banner {
 if (!_adBannerViewIsVisible) {
 _adBannerViewIsVisible = YES;
 [self fixupAdView:[UIDevice currentDevice].orientation];
 }
 }
 
 - (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
 if (_adBannerViewIsVisible) {
 _adBannerViewIsVisible = NO;
 [self fixupAdView:[UIDevice currentDevice].orientation];
 }
 }
 */

#pragma mark -
#pragma mark AdWhirl delegate methods
- (NSString *)adWhirlApplicationKey {
	return _MY_AD_WHIRL_APPLICATION_KEY;
}

- (UIViewController *)viewControllerForPresentingModalView {
	return self;
}

- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView {
	_adBannerView = adWhirlView;
	if (!_adBannerViewIsVisible) {
		_adBannerViewIsVisible = YES;
        //		[self fixupAdView:[UIDevice currentDevice].orientation];
	}
	[UIView beginAnimations:@"AdWhirlDelegate.adWhirlDidReceiveAd:"
					context:nil];
	
	[UIView setAnimationDuration:0.7];
	
	CGSize adSize = [adWhirlView actualAdSize];
	CGRect newFrame = adWhirlView.frame;
	
	newFrame.size = adSize;
	newFrame.origin.x = (self.view.bounds.size.width - adSize.width)/ 2;
	
	adWhirlView.frame = newFrame;
	
	[UIView commitAnimations];
    //	[self fixupAdView:[UIDevice currentDevice].orientation];
	[self fixupAdView:UIInterfaceOrientationPortrait];
}

- (void)adWhirlDidFailToReceiveAd:(AdWhirlView *)adWhirlView usingBackup:(BOOL)yesOrNo {
	if (_adBannerViewIsVisible) {
		_adBannerViewIsVisible = NO;
        //		[self fixupAdView:[UIDevice currentDevice].orientation];
        [self fixupAdView:UIInterfaceOrientationPortrait];
	}
}	

- (int)getBannerHeight:(UIInterfaceOrientation)orientation {
	return [_adBannerView actualAdSize].height;
    //	if (UIInterfaceOrientationIsLandscape(orientation)) {
    //		return 32;
    //	} else {
    //		return 50;
    //	}
}

- (int)getBannerHeight {
    //	return [self getBannerHeight:[UIDevice currentDevice].orientation];
	return [self getBannerHeight:UIInterfaceOrientationPortrait];
}

- (int)getBannerOriginY:(UIInterfaceOrientation)orientation {
    //	return kScreenWidth - kStatusBarHeight - (kNavigationBarHeight - 12) - [_adBannerView actualAdSize].height;
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		return kScreenWidth - kStatusBarHeight - (kNavigationBarHeight - 12) - [_adBannerView actualAdSize].height;
	} else {
		return kScreenHeight - kStatusBarHeight - kNavigationBarHeight - [_adBannerView actualAdSize].height;
	}
}

- (int)getBannerOriginY {
    //	return [self getBannerOriginY:[UIDevice currentDevice].orientation];
	return [self getBannerOriginY:UIInterfaceOrientationPortrait];
}

- (void)createAdBannerView {
	self.adBannerView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
    //	[_adBannerView setRequiredContentSizeIdentifiers:
    //	 [NSSet setWithObjects: ADBannerContentSizeIdentifierPortrait,
    //	  ADBannerContentSizeIdentifierLandscape, nil]];
    //	if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
    //		[_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierLandscape];
    //	} else {
    //		[_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];            
    //	}
	//        [_adBannerView setFrame:CGRectOffset([_adBannerView frame], 0, -[self getBannerHeight])];
	// Hide the Ad Banner View below the bottom of the screen, instead of above the top
	[_adBannerView setFrame:CGRectOffset([_adBannerView frame], 0, [self getBannerOriginY])];
	[_adBannerView setDelegate:self];
	
	[self.view addSubview:_adBannerView];      
    //	[self fixupAdView:[UIDevice currentDevice].orientation];
	[self fixupAdView:UIInterfaceOrientationPortrait];
}

- (void)fixupAdView:(UIInterfaceOrientation)toInterfaceOrientation {
	if (showAds) {
		if (_adBannerView != nil) {        
            //        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
            //            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierLandscape];
            //        } else {
            //            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
            //        }          
			[UIView beginAnimations:@"fixupViews" context:nil];
			//		[UIView setAnimationDuration:0.7];
			if (_adBannerViewIsVisible) {
				CGRect adBannerViewFrame = [_adBannerView frame];
                //            adBannerViewFrame.origin.x = 0;
				if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
					adBannerViewFrame.origin.x = (320 - [_adBannerView actualAdSize].width)/ 2;
				} else {
					adBannerViewFrame.origin.x = (480 - [_adBannerView actualAdSize].width)/ 2;
				}
                //			adBannerViewFrame.origin.x = (self.view.bounds.size.width - [_adBannerView actualAdSize].width)/ 2;
				//			adBannerViewFrame.origin.y = 0;
				adBannerViewFrame.origin.y = [self getBannerOriginY:toInterfaceOrientation];
				[_adBannerView setFrame:adBannerViewFrame];
				CGRect contentViewFrame = _contentView.frame;
				//            contentViewFrame.origin.y = [self getBannerHeight:toInterfaceOrientation];
				contentViewFrame.size.height = self.view.frame.size.height - [self getBannerHeight:toInterfaceOrientation];
				_contentView.frame = contentViewFrame;
			} else {
				CGRect adBannerViewFrame = [_adBannerView frame];
				adBannerViewFrame.origin.x = 0;
				//            adBannerViewFrame.origin.y = -[self getBannerHeight:toInterfaceOrientation];
				adBannerViewFrame.origin.y = [self getBannerOriginY:toInterfaceOrientation];
				[_adBannerView setFrame:adBannerViewFrame];
				CGRect contentViewFrame = _contentView.frame;
				//            contentViewFrame.origin.y = 0;
				contentViewFrame.size.height = self.view.frame.size.height;
				_contentView.frame = contentViewFrame;            
			}
			[UIView commitAnimations];
		}   
	} else {
		_adBannerView.frame = CGRectMake(0, 0, 0, 0);
		_contentView.frame = self.view.frame;
	}
    
}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
	self.kataArray = nil;
	self.techniqueArray = nil;
	self.tableView = nil;
	self.contentView = nil;
    //	self.adBannerView = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[kataArray release];
	[techniqueArray release];
    //	[tableView release];
    //	[contentView release];
    //	[adBannerView release];
	[super dealloc];
}


@end

