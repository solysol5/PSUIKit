//
//  PSRecycledScrollView.h
//  PSUIKit
//
//  Created by Steve Kim on 2015. 4. 9..
//  Copyright (c) 2013 ~ 2016 Steve Kim. All rights reserved.
//

/*
 Copyright 2015 Steve Kim
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "PSScrollView.h"

enum {
    PSRecycledScrollViewTypeVertical,
    PSRecycledScrollViewTypeHorizontal,
};
typedef NSInteger PSRecycledScrollViewType;

@protocol PSRecycledScrollViewDataSource;
@protocol PSRecycledScrollViewDelgate;

@interface PSRecycledScrollView : PSScrollView <UIScrollViewDelegate>
@property (nonatomic, weak) IBOutlet id<PSRecycledScrollViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id<PSRecycledScrollViewDelgate> scrollViewDelegate;
@property (nonatomic) CGFloat padding;
@property (nonatomic) PSRecycledScrollViewType type;
@property (nonatomic, readonly) id visibleView;
@property (nonatomic, readonly) NSMutableSet *visibleViews;
- (id)dequeueRecycledView;
- (void)reloadData;
- (void)moveToIndex:(NSInteger)index withAnimation:(BOOL)animation;
- (id)viewAtIndex:(NSInteger)index;
@end

@protocol PSRecycledScrollViewDataSource <NSObject>
@required
- (NSInteger)numberOfViewInScrollView:(PSRecycledScrollView *)scrollView;
- (CGFloat)scrollView:(PSRecycledScrollView *)scrollView sizeAtIndex:(NSInteger)index;
- (id)viewForRecycledInScrollView:(PSRecycledScrollView *)scrollView atIndex:(NSInteger)index;
@end

@protocol PSRecycledScrollViewDelgate <NSObject>
@optional
- (void)scrollView:(PSRecycledScrollView *)scrollView willDisplayView:(UIView *)view forIndex:(NSInteger)index;
@end