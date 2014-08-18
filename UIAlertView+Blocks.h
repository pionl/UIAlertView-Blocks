//
//  UIAlertView+Blocks.h
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIButtonItem.h"

@interface UIAlertView (Blocks)

/**
 *  Shows alertView with given message with Error title (localized) and OK button (localized).
 *
 *  @param message
 *
 *  @return UIAlertView
 */
+ (id)errorWithMessage:(NSString*)message ;

/**
 *  Shows alertView with given message with and title. Shows OK button (localized).
 *
 *  @param message
 *
 *  @return UIAlertView
 */
+ (id)errorWithMessage:(NSString*)message title:(NSString*)title ;

/**
 *  Shows alert view with title, message and buttons.
 *
 *  @param inTitle
 *  @param inMessage
 *  @param inCancelButtonItem   a RIButtonItem button, can be nil.
 *  @param inOtherButtonItems   a list of RIButtonItem buttons
 *
 *  @return UIAlertView
 */
+ (id)showWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  Creates alert view with title, message and buttons. You must call show.
 *
 *  @param inTitle
 *  @param inMessage
 *  @param inCancelButtonItem   a RIButtonItem button, can be nil.
 *  @param inOtherButtonItems   a list of RIButtonItem buttons
 *
 *  @return UIAlertView
 */
-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  Creates alert view with title, message and buttons. You must call show.
 *
 *  @param inTitle
 *  @param inMessage
 *  @param inCancelButtonItem a RIButtonItem button, can be nil.
 *  @param buttonsArray       array of RIButtonItem
 *
 *  @return UIAlertView
 */
-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonArray:(NSMutableArray*)buttonsArray;

/**
 *  Adds button to alertView
 *
 *  @param item RIButtonItem
 *
 *  @return button index
 */
- (NSInteger)addButtonItem:(RIButtonItem *)item;

@end
