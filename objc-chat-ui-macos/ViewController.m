#import "ViewController.h"
#import "ChatInputTextView.h"
#import "ChatInputTextField.h"

@interface ViewController () <NSTextFieldDelegate>

@property (weak) IBOutlet NSScrollView *chatInputScrollView;
@property (weak) IBOutlet ChatInputTextField *chatInputTextField;
@property (weak) IBOutlet NSView *chatInputContainerView;
@property (weak) IBOutlet NSButton *sendButton;

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

    self.chatInputContainerView.wantsLayer = YES;
    self.chatInputContainerView.layer.cornerRadius = 8.0;
    self.chatInputContainerView.layer.masksToBounds = YES;
    self.chatInputContainerView.layer.backgroundColor = [[NSColor controlBackgroundColor] CGColor];
    
    self.chatInputTextField.delegate = self;
    self.chatInputTextField.bezeled = NO;
    self.chatInputTextField.drawsBackground = NO;
    self.chatInputTextField.focusRingType = NSFocusRingTypeNone;
    
    [self.chatInputTextField setTarget:self];
    [self.chatInputTextField setAction:@selector(onEnterKeyPress:)];
}

- (IBAction)onEnterKeyPress:(id)sender {
    self.chatInputTextField.stringValue = @"";
    [self.chatInputTextField invalidateIntrinsicContentSize];
}

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
    if (commandSelector == @selector(insertNewline:) &&
        [[[NSApplication sharedApplication] currentEvent] modifierFlags]
        & NSEventModifierFlagShift) {

        [textView insertNewlineIgnoringFieldEditor:self];
        return YES;
    }

    return NO;
}

@end
