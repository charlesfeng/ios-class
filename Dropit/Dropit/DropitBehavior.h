//
//  DropitBehavior.h
//  Dropit
//
//  Created by Charles Feng on 3/2/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior

- (void)addItem:(id <UIDynamicItem>)item;
- (void)removeItem:(id <UIDynamicItem>)item;

@end
