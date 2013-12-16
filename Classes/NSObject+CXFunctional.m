#import "NSObject+CXFunctional.h"

@implementation NSObject (CXFunctional)
- (instancetype)cx_map:(id (^)(id))mapper
{
    return mapper(self);
}

- (NSArray *)cx_array
{
    return @[self];
}
@end
