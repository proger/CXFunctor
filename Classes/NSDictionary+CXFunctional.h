@interface NSDictionary (CXFunctional)
+ (instancetype)cx_dictionaryWithArrayOfObjectsAndKeys:(NSArray *)a;
- (instancetype)cx_map:(id (^)(id key, id value))mapper;

- (NSArray *)cx_array;
@end
