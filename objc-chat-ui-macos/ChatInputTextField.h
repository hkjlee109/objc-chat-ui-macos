#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatInputTextField : NSTextField

@property (nonatomic, copy) void (^onEnterKeyPress)(void);

- (NSSize)intrinsicContentSize;

@end

NS_ASSUME_NONNULL_END
