//
//  UIView+UIView_AnnotatedView.m
//  Hubs
//
//  Created by Richard S on 23/03/2014.
//  Copyright (c) 2014 Jotlab. All rights reserved.
//

#import "UIView+JTAnnotatedView.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, retain) UIView *annotationView;

@end

#define CORNER_RADIUS 20.0
#define PADDING 10.0
#define BG_ALPHA 0.5
@implementation UIView (JTAnnotatedView)

- (void)addAnnotation:(NSString *)title {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleAnnotation:)];
	[self addGestureRecognizer:tap];
	
	self.annotationTitle = title;
	
	UILabel *titleLabel = [[UILabel alloc] init];
	if (self.annotationFont) {
		titleLabel.font = self.annotationFont;
	}
	
	UIView *annotationView = [[UIView alloc] initWithFrame:[self calculateFrameForString:title withFont:titleLabel.font]];
	titleLabel.frame = CGRectMake(PADDING / 2, PADDING / 2, annotationView.frame.size.width - PADDING, annotationView.frame.size.height - PADDING);
	titleLabel.text = title;
	titleLabel.textColor = [UIColor whiteColor];
	[annotationView addSubview:titleLabel];
	annotationView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:BG_ALPHA];
	annotationView.layer.cornerRadius = (CORNER_RADIUS / 2.0);
	
	if (self.frame.origin.x + annotationView.frame.size.width > [[UIScreen mainScreen] bounds].size.width) {
		CGRect frame = annotationView.frame;
		frame.origin.x = [[UIScreen mainScreen] bounds].size.width - annotationView.frame.size.width - PADDING / 2;
		frame.origin.y = self.frame.origin.y - annotationView.frame.size.height - PADDING / 2;
		annotationView.frame = frame;
	}
	
	UIImageView *annotationTail = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.origin.x + self.frame.size.width / 2 - 3, annotationView.frame.size.height, 5, 4)];
	annotationTail.image = [UIImage imageNamed:@"arrowTail"];
	annotationTail.alpha = BG_ALPHA;
	[annotationView addSubview:annotationTail];

	annotationView.alpha = 0;
	self.annotationView = annotationView;
	
	[self.superview addSubview:annotationView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	__block typeof(self) weakSelf = self;
	[UIView animateWithDuration:0.25 animations:^{
		weakSelf.annotationView.alpha = 0;
	}];
}

- (CGRect)calculateFrameForString:(NSString *)title withFont:(UIFont *)font {
	CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
	CGRect frame = [title boundingRectWithSize:size
														 options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics
													attributes:@{NSFontAttributeName: font}
														 context:nil];
	frame.origin.y = 0 - frame.size.height - PADDING;
	frame.size.height += PADDING;
	frame.size.width += PADDING;
	return frame;
}

- (void)toggleAnnotation:(id)sender {
	NSInteger targetAlpha = ABS(self.annotationView.alpha - 1);
	__block typeof(self) weakSelf = self;
	[UIView animateWithDuration:0.25 animations:^{
		weakSelf.annotationView.alpha = targetAlpha;
	}];
}

#pragma mark Getters & Setters
- (UIFont *)annotationFont {
	return objc_getAssociatedObject(self, @selector(annotationFont));
}

- (void)setAnnotationFont:(UIFont *)font {
	objc_setAssociatedObject(self, @selector(annotationFont), font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)annotationTitle {
	return objc_getAssociatedObject(self, @selector(annotationTitle));
}

- (void)setAnnotationTitle:(NSString *)title {
	objc_setAssociatedObject(self, @selector(annotationTitle), title, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)annotationView {
	return objc_getAssociatedObject(self, @selector(annotationView));
}

- (void)setAnnotationView:(UIView *)view {
	objc_setAssociatedObject(self, @selector(annotationView), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end