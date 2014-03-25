##UIView+JTAnnotatedView
UIView+JTAnnotatedView is a category to add a speech bubble with some text above any view you may want. It auto sizes the bubble according to it's parent view and also positions itself in relation to the target view.

##Usage
***Step 1:***

After importing the category to your project; on your view or in your view controller add in the category via the import statement.

	#import "UIView+JTAnnotatedView.h"

***Step 2:***

Add the annotation to your view:

	UIView *winner = [[UIView alloc] init];
	[winner addAnnotation:@"I am the best!"];

From here the view is now tappable, which will bring the subview to the front. Also tapping outside of the view area or on the annotation again will dismiss the bubble.

##Example
![Example](https://raw.githubusercontent.com/voidet/UIView-JTAnnotatedView/master/example.png)

##Work in progress
Currently the view is displaying, centering is a bit off and there is no tap on tap off functionality to hide/show just yet. Also need to remove the define macros into constants.
