//
//  UIAlertView+Blocks.m
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

static NSString *RI_BUTTON_ASS_KEY = @"com.random-ideas.BUTTONS";

@implementation UIAlertView (Blocks)

+ (id)errorWithMessage:(NSString*)message {
    return [UIAlertView errorWithMessage:message title:NSLocalizedString(@"Error")];
}

+ (id)errorWithMessage:(NSString*)message title:(NSString*)title {
    return [UIAlertView showWithTitle:title message:message cancelButtonItem:[RIButtonItem itemWithLabel:NSLocalizedString(@"OK")] otherButtonItems:nil];
}

+ (id)showWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... {
    NSMutableArray *buttonsArray = [NSMutableArray array];
    RIButtonItem *eachItem;
    va_list argumentList;
    if (inOtherButtonItems)
    {
        [buttonsArray addObject: inOtherButtonItems];
        va_start(argumentList, inOtherButtonItems);
        while((eachItem = va_arg(argumentList, RIButtonItem *)))
        {
            [buttonsArray addObject: eachItem];
        }
        va_end(argumentList);
    }
    id alert = [[super alloc] initWithTitle:inTitle message:inMessage cancelButtonItem:inCancelButtonItem otherButtonArray:buttonsArray];
    [alert show];

    return alert;
}

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... 
{
    NSMutableArray *buttonsArray = [NSMutableArray array];
    RIButtonItem *eachItem;
    va_list argumentList;
    if (inOtherButtonItems)
    {
        [buttonsArray addObject: inOtherButtonItems];
        va_start(argumentList, inOtherButtonItems);
        while((eachItem = va_arg(argumentList, RIButtonItem *)))
        {
            [buttonsArray addObject: eachItem];
        }
        va_end(argumentList);
    }
    return [self initWithTitle:inTitle message:inMessage cancelButtonItem:inCancelButtonItem otherButtonArray:buttonsArray];
}

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonArray:(NSMutableArray*)buttonsArray
{
    if((self = [self initWithTitle:inTitle message:inMessage delegate:self cancelButtonTitle:inCancelButtonItem.label otherButtonTitles:nil]))
    {
                
        for(RIButtonItem *item in buttonsArray)
        {
            [self addButtonWithTitle:item.label];
        }
        
        if(inCancelButtonItem)
            [buttonsArray insertObject:inCancelButtonItem atIndex:0];
        
        objc_setAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY, buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setDelegate:self];
    }
    return self;
}

- (NSInteger)addButtonItem:(RIButtonItem *)item
{
    NSInteger buttonIndex = [self addButtonWithTitle:item.label];
    [[self buttonItems] addObject:item];
    
    if (![self delegate])
    {
        [self setDelegate:self];
    }
    
    return buttonIndex;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // If the button index is -1 it means we were dismissed with no selection
    if (buttonIndex >= 0)
    {
        NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY);
        RIButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
        if(item.action)
            item.action();
    }
    
    objc_setAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)buttonItems
{
    NSMutableArray *buttonItems = objc_getAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY);
    if (!buttonItems)
    {
        buttonItems = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY, buttonItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return buttonItems;
}

@end
