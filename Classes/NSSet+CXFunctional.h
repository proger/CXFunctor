@interface NSSet (CXFunctional)
- (instancetype)cx_map:(id (^)(id))mapper;
- (instancetype)cx_mapObjectsUsingBlock:(id (^)(id obj, BOOL *stop))mapper;

- (id)cx_foldLeftInto:(id)obj usingBlock:(id (^)(id initial, id object))folder;
- (instancetype)cx_filter:(BOOL (^)(id object))test;

- (instancetype)cx_flatten;

- (NSArray *)cx_array;
@end
