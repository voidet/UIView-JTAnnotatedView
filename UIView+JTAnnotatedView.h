//
//  UIView+UIView_AnnotatedView.h
//  Hubs
//
//  Created by Richard S on 23/03/2014.
//  Copyright (c) 2014 Jotlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JTAnnotatedView)

@property (nonatomic, strong) UIFont *annotationFont;

- (void)addAnnotation:(NSString *)title;

@end
