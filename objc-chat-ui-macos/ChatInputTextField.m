#import "ChatInputTextField.h"

@interface ChatInputTextField() {
	BOOL _hasLastIntrinsicSize;
	BOOL _isEditing;
	NSSize _lastIntrinsicSize;
}

@end

@implementation ChatInputTextField

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    
    return self;
}

- (void)setStringValue:(NSString *)stringValue {
    [super setStringValue:stringValue];

    if ([stringValue isEqual:@""]) {
        _hasLastIntrinsicSize = NO;
    }
}

- (void)textDidBeginEditing:(NSNotification *)notification
{
	[super textDidBeginEditing:notification];
	_isEditing = YES;
}

- (void)textDidEndEditing:(NSNotification *)notification
{
	[super textDidEndEditing:notification];
	_isEditing = NO;
}

- (void)textDidChange:(NSNotification *)notification
{
	[super textDidChange:notification];
	[self invalidateIntrinsicContentSize];
}

- (NSSize)intrinsicContentSize {
	NSSize intrinsicSize = _lastIntrinsicSize;
	
	if(_isEditing || !_hasLastIntrinsicSize) {
        
		intrinsicSize = [super intrinsicContentSize];
    
		NSText *fieldEditor = [self.window fieldEditor:NO forObject:self];
		if([fieldEditor isKindOfClass:[NSTextView class]]) {
			NSTextView *textView = (NSTextView *)fieldEditor;
			NSRect usedRect = [textView.textContainer.layoutManager usedRectForTextContainer:textView.textContainer];
			
			usedRect.size.height += 5.0;
			intrinsicSize.height = usedRect.size.height;
		}
		
		if (intrinsicSize.height > 100) {
            intrinsicSize = _lastIntrinsicSize;
        }
        else {
            _lastIntrinsicSize = intrinsicSize;
            _hasLastIntrinsicSize = YES;
        }
	}
	
    return intrinsicSize;
}

@end
