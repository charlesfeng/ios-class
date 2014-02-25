//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Charles Feng on 2/23/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//
// Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// protected
// for subclasses
- (Deck *)createdDeck; // abstract

@end
