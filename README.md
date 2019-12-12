### One line toast:

![Imgur](https://i.imgur.com/v5DU5rI.png)

### Multiple lines toast:

![Imgur](https://i.imgur.com/5N5xhAN.png)


## EMRToast.m

```objective-c
#import "EMRToast.h"
#import "EMRToastTextCell.h"

@interface EMRToast() {
    NSTextField *contentLabel;
}
@end

@implementation EMRToast


+ (void)Show:(NSString *)text {
    // create a toast
    CGFloat parentWidth = [NSApplication sharedApplication].windows[0].frame.size.width;
    CGRect frame = CGRectMake(0, 20, parentWidth, 100);  // make the toast hight big enough to show multiple lines
    EMRToast *toast = [[EMRToast alloc] initWithFrame:frame text:text];
    
    // add toast to window
    [[NSApplication sharedApplication].keyWindow.contentView addSubview:toast];
    
    // make toast center in the bottom
    NSLayoutConstraint *makeToastCenter = [NSLayoutConstraint constraintWithItem:toast
                                                                       attribute:NSLayoutAttributeCenterX
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:[toast superview]
                                                                       attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1
                                                                        constant:0];
    [[toast superview] addConstraint:makeToastCenter];
}

- (instancetype)initWithFrame:(NSRect)frame text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config:text];
    }
    return self;
}

- (void)config:(NSString *)text {
    // Add a label to toast
    contentLabel = [[NSTextField alloc] initWithFrame:CGRectMake(20, 0, (self.bounds.size.width - 40), 50)];
    
    // use customTextCell
    contentLabel.cell = [[EMRToastTextCell alloc] initTextCell:text];
    
    // label property
    contentLabel.backgroundColor = [NSColor clearColor];
    contentLabel.textColor = [NSColor whiteColor];
    contentLabel.font = [NSFont systemFontOfSize:15];
    contentLabel.alignment = NSTextAlignmentCenter;
    
    // size and frame
    CGSize size = [contentLabel sizeThatFits:CGSizeMake(self.bounds.size.width - 40, 50)];
    contentLabel.frame = CGRectMake((self.bounds.size.width - size.width)/2, 0, size.width + 20, size.height + 20);
    
    // round corner
    contentLabel.bordered = YES;
    contentLabel.wantsLayer = YES;
    contentLabel.layer.borderColor = [NSColor grayColor].CGColor;
    contentLabel.layer.borderWidth = 2.0f;
    contentLabel.layer.cornerRadius = 7.0f;
    if ([text containsString:@"\n"]) {
        contentLabel.layer.cornerRadius = 10.0f;
    }
    contentLabel.layer.masksToBounds = YES;
    contentLabel.layer.backgroundColor = [NSColor grayColor].CGColor;
    [[contentLabel cell] setBezeled:NO];   // must set this to NO;
    [[contentLabel cell] setBordered:NO];  // must set this to NO;
    
    // ToastView add label as subview
    [self addSubview:contentLabel];
    
    // label constraints
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *makeLabelCenter = [NSLayoutConstraint constraintWithItem:contentLabel
                                                                       attribute:NSLayoutAttributeCenterX
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1
                                                                        constant:0];
    [self addConstraint:makeLabelCenter];
    
    // dismiss the toast after 2 seconds
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
}


- (void)dismiss {
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = 2;
        self.animator.alphaValue = 0;
    } completionHandler:^{
        [self removeFromSuperview];
    }];
}

@end

```
## EMRToastTextCell.m

```objective-c
#import "EMRToastTextCell.h"

@implementation EMRToastTextCell

// make text content centered vertically
- (NSRect)drawingRectForBounds:(NSRect)rect {
    NSRect newRect = [super drawingRectForBounds:rect];
    NSSize textSize = [self cellSizeForBounds:rect];
    CGFloat deltaHight = newRect.size.height - textSize.height;
    if (deltaHight > 0) {
        newRect.size.height = textSize.height;
        newRect.origin.y += deltaHight * 0.5;
        
    }
    return newRect;
}
@end
```

## How to use a toast

In `ViewController.m`
```objective-c
#import "ViewController.h"
#import "EMRToast.h"
@interface ViewController() {
    NSButton *showToastButton;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    showToastButton = [NSButton buttonWithTitle:@"ShowToast" target:self action:@selector(showToastAction)];
    showToastButton.frame = CGRectMake(50, 200, 200, 50);
    [self.view addSubview:showToastButton];
    
}

- (void)showToastAction {
    // one line
    //[EMRToast Show:@"This is a toast!"];
    
    // multiple line
    [EMRToast Show:@"The blatant disparity between software \n theory and practice befuddles many \n Computer Science students."];
}


@end
```
