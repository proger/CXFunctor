#import "NSSet+CXFunctional.h"

@implementation NSSet (CXFunctional)

- (instancetype)cx_map:(id (^)(id))mapper
{
    NSMutableSet *ret = [NSMutableSet set];
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        id fx = mapper(obj);
        if (fx != nil)
            [ret addObject:fx];
    }];
    
    return ret;
}

- (instancetype)cx_mapObjectsUsingBlock:(id (^)(id obj, BOOL *stop))mapper
{
    NSMutableSet *ret = [NSMutableSet set];
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        id fx = mapper(obj, stop);
        if (fx != nil)
            [ret addObject:fx];
    }];
    
    return ret;
}

- (id)cx_foldLeftInto:(id)initial usingBlock:(id (^)(id initial, id object))folder
{
    id result = initial;
    for (id obj in self) {
        result = folder(result, obj);
    }
    return result;
}

- (instancetype)cx_filter:(BOOL (^)(id object))test
{
    return [self cx_foldLeftInto:[NSMutableSet set] usingBlock:^id(id initial, id obj) {
        if (test(obj) == YES)
            [(NSMutableSet *)initial addObject:obj];
        return initial;
    }];
}

- (instancetype)cx_flatten
{
    return [self cx_foldLeftInto:[NSMutableSet set] usingBlock:^id(id initial, id obj) {
        [(NSMutableSet *)initial unionSet:obj];
        return initial;
    }];
}

- (NSArray *)cx_array
{
    return [self allObjects];
}
@end
