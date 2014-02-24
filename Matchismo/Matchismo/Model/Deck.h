//
//  Deck.h
//  Matchismo
//
//  Created by Charles Feng on 2/23/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
