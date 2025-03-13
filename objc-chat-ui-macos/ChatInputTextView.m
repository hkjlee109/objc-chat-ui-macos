#import "ChatInputTextView.h"

@implementation ChatInputTextView

- (void)keyDown:(NSEvent *)event {
    if (event.keyCode == 36) {
        if ((event.modifierFlags & NSEventModifierFlagShift) != 0) {
            [self insertNewline:self];
        } else {
            if (self.onEnterKeyPress) {
                self.onEnterKeyPress();
            }
        }
    } else {
        [super keyDown:event];
    }
}

@end
