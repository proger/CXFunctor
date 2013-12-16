#import "NSDictionary+CXFunctional.h"

@implementation NSDictionary (CXFunctional)

+ (instancetype)cx_dictionaryWithArrayOfObjectsAndKeys:(NSArray *)a
{
    assert([a count] % 2 == 0);
    NSMutableDictionary *d = [[NSMutableDictionary alloc] initWithCapacity:[a count] / 2]; 
    
    for (int i = 0; i < [a count]; i += 2) {
        [d setObject:[a objectAtIndex:i] forKey:[a objectAtIndex:i+1]];
    }
    return d;
}

- (instancetype)cx_map:(id (^)(id key, id value))mapper
{
    NSMutableDictionary *d = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    
    for (id key in self) {
        id obj = [self objectForKey:key];
        id nobj = mapper(key, obj);
        if (nobj == nil)
            continue;
        
        [d setObject:nobj forKey:key];
    }
    return d;
}

- (NSArray *)cx_array
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [array addObject:@[key, obj]];
    }];
    return array;
}
@end
