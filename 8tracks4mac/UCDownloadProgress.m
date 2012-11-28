#import "UCDownloadProgress.h"

@implementation UCDownloadProgress {
    NSNumber *_value;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        _value = [NSNumber new];
    }

    return self;
}

+ (id)initWithValue:(NSNumber *)value {
    UCDownloadProgress *downloadProgress = [[UCDownloadProgress alloc] init];

    [downloadProgress setValue:value];

    return downloadProgress;
}

- (void)setValue:(NSNumber *)newValue {
    _value = newValue;
}

- (NSNumber *)value {
    return _value;
}

- (BOOL)isComplete {
    if ([_value integerValue] == 100) {
        return YES;
    }

    return NO;
}


@end