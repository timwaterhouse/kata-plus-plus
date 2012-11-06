//
//  RootViewController.h
//  Kata Plus
//
//  Created by Timothy Waterhouse on 9/5/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "iAd/ADBannerView.h"
//#import "AdWhirlDelegateProtocol.h"
//#import "AdWhirlView.h"

#define _MY_AD_WHIRL_APPLICATION_KEY	@"5bc56f7588424c2ea9741f3b8f430825"

#define kKataFilename		@"kataArchive"
#define kTechniqueFilename	@"techniqueArchive"
#define kKataDataKey		@"KataData"
#define kTechniqueDataKey	@"TechniqueData"

#define kAddNewSection		0
#define kKataSection		1
#define kTechniqueSection	2

#define kStatusBarHeight		20
#define kNavigationBarHeight	44
#define kScreenHeight			480
#define	kScreenWidth			320

//@interface RootViewController : UITableViewController {
//@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate> {
@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView *_tableView;
	UIView *_contentView;
	NSMutableArray *kataArray;
	NSMutableArray *techniqueArray;
//	AdWhirlView *_adBannerView;
//	BOOL _adBannerViewIsVisible;
//	BOOL showAds;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) NSMutableArray *kataArray;
@property (nonatomic, retain) NSMutableArray *techniqueArray;
//@property (nonatomic, retain) AdWhirlView *adBannerView;
//@property (nonatomic) BOOL adBannerViewIsVisible;
//@property (nonatomic) BOOL showAds;
- (void)infoButtonAction;
- (NSString *)kataDataFilePath;
- (NSString *)techniqueDataFilePath;
//- (void)createAdBannerView;
//- (void)fixupAdView:(UIInterfaceOrientation)toInterfaceOrientation;
@end
