//
//  Detail.h
//  Kata Counter
//
//  Created by Tim Waterhouse on 22/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Kata;

#define kLeftMargin		20
#define kRightMargin	20

@interface DetailController : UIViewController <UITextFieldDelegate> {
	UITextField *nameField;
	UITextField *totalField;
	UITextField *textFieldBeingEdited;
	NSMutableDictionary *tempValues;
	Kata *kata;
	BOOL newKata;
	BOOL newTechnique;
}
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *totalField;
@property (nonatomic, retain) UITextField *textFieldBeingEdited;
@property (nonatomic, retain) Kata *kata;
@property (nonatomic, retain) NSMutableDictionary *tempValues;
@property (nonatomic) BOOL newKata;
@property (nonatomic) BOOL newTechnique;
- (IBAction)buttonPressed:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)deleteButtonPressed:(id)sender;
@end
