#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatInputTextView : NSTextView

@property (nonatomic, copy) void (^onEnterKeyPress)(void);

@end

NS_ASSUME_NONNULL_END
