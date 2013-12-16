#import <Foundation/Foundation.h>
#import "NSOrderedSet+CXFunctional.h"

@implementation NSOrderedSet (CXFunctional)

- (instancetype)cx_map:(id (^)(id))mapper
{
    NSMutableOrderedSet *ret = [NSMutableOrderedSet orderedSet];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id fx = mapper(obj);
        if (fx != nil)
            [ret addObject:fx];
    }];
    
    return ret;
}

- (instancetype)cx_mapObjectsUsingBlock:(id (^)(id obj, int, BOOL *stop))mapper
{
    NSMutableOrderedSet *ret = [NSMutableOrderedSet orderedSet];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id fx = mapper(obj, idx, stop);
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
    return [self cx_foldLeftInto:[NSMutableOrderedSet orderedSet] usingBlock:^id(id initial, id obj) {
        if (test(obj) == YES)
            [(NSMutableOrderedSet *)initial addObject:obj];
        return initial;
    }];
}

- (instancetype)cx_flatten
{
    return [self cx_foldLeftInto:[NSMutableOrderedSet orderedSet] usingBlock:^id(id initial, id obj) {
        [(NSMutableOrderedSet *)initial unionOrderedSet:obj];
        return initial;
    }];
}

- (NSArray *)cx_array
{
    return [self array];
}
@end
