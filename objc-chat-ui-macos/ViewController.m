#import "ViewController.h"
#import "ChatInputTextView.h"

@interface ViewController () <NSTextViewDelegate>

@property (weak) IBOutlet NSScrollView *chatInputScrollView;
@property (weak) IBOutlet ChatInputTextView *chatInputTextView;
@property (weak) IBOutlet NSButton *sendButton;

@property (weak) IBOutlet NSLayoutConstraint *chatInputScrollViewHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSImage *image = [NSImage imageWithSystemSymbolName:@"paperplane.fill" accessibilityDescription:@"Send"];
    [self.sendButton setImage:image];
    
    self.chatInputScrollView.wantsLayer = YES;
    self.chatInputScrollView.layer.cornerRadius = 8.0;
    self.chatInputScrollView.layer.masksToBounds = YES;
    self.chatInputScrollView.hasVerticalScroller = NO;

    self.chatInputTextView.delegate = self;
    self.chatInputTextView.textContainerInset = NSMakeSize(0, (self.chatInputTextView.bounds.size.height - self.chatInputTextView.font.pointSize) / 2);
    
    __weak typeof(self) weakSelf = self;
    self.chatInputTextView.onEnterKeyPress = ^{
        [weakSelf onEnterKeyPress];
    };
}

- (void)onEnterKeyPress {
    [self.chatInputTextView setString:@""];
    self.chatInputScrollViewHeight.constant = 32;
}

- (void)textDidChange:(NSNotification *)notification {
    CGFloat width = self.chatInputTextView.textContainer.size.width;
    NSRect rect = [self.chatInputTextView.string boundingRectWithSize:NSMakeSize(width, CGFLOAT_MAX)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName: self.chatInputTextView.font}];
    
    CGFloat minHeight = 32.0;
    CGFloat maxHeight = 68.0;
    self.chatInputScrollViewHeight.constant = fmin(fmax(rect.size.height + 18, minHeight), maxHeight);
}

@end
