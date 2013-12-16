#import <Foundation/Foundation.h>
#import "NSArray+CXFunctional.h"

@implementation NSArray (CXFunctional)

- (instancetype)cx_map:(id (^)(id))mapper
{
    NSMutableArray *ret = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id fx = mapper(obj);
        if (fx != nil)
            [ret addObject:fx];
    }];
    
    return ret;
}

- (instancetype)cx_mapObjectsUsingBlock:(id (^)(id obj, int, BOOL *stop))mapper
{
    NSMutableArray *ret = [NSMutableArray array];
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
    return [self cx_foldLeftInto:[NSMutableArray array] usingBlock:^id(id initial, id obj) {
        if (test(obj) == YES)
            [(NSMutableArray *)initial addObject:obj];
        return initial;
    }];
}

- (instancetype)cx_flatten
{
    return [self cx_foldLeftInto:[NSMutableArray array] usingBlock:^id(id initial, id obj) {
        [(NSMutableArray *)initial addObjectsFromArray:obj];
        return initial;
    }];
}

- (NSArray *)cx_array
{
    return self;
}

@end
