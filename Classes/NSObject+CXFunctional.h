@interface NSObject (CXFunctional)
- (instancetype)cx_map:(id (^)(id))mapper;

- (NSArray *)cx_array;
@end
