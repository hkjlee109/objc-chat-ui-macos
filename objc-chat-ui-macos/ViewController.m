#import "ViewController.h"

@interface ViewController () <NSTextViewDelegate>

@property (weak) IBOutlet NSScrollView *chatInputScrollView;
@property (weak) IBOutlet NSTextView *chatTextView;
@property (weak) IBOutlet NSButton *sendButton;

@property (weak) IBOutlet NSLayoutConstraint *chatInputScrollViewHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chatTextView.delegate = self;
    
    NSImage *image = [NSImage imageWithSystemSymbolName:@"paperplane.fill" accessibilityDescription:@"Send"];
    [self.sendButton setImage:image];
    
    
    self.chatInputScrollView.wantsLayer = YES;
    self.chatInputScrollView.layer.cornerRadius = 8.0;
    self.chatInputScrollView.layer.masksToBounds = YES;
    self.chatInputScrollView.hasVerticalScroller = NO;

    self.chatTextView.textContainerInset = NSMakeSize(0, (self.chatTextView.bounds.size.height - self.chatTextView.font.pointSize) / 2);
}

- (void)textDidChange:(NSNotification *)notification {
    CGFloat contentHeight = [self.chatTextView.layoutManager usedRectForTextContainer:self.chatTextView.textContainer].size.height;
    
    CGFloat minHeight = 32.0;
    CGFloat maxHeight = 82.0;
    CGFloat newHeight = fmin(fmax(contentHeight + 18, minHeight), maxHeight);

    self.chatInputScrollViewHeight.constant = newHeight;
}

@end
