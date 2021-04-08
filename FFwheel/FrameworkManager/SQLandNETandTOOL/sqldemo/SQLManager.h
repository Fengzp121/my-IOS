//
//  SQLManager.h
//  iOSTest-OC
//
//  Created by ffzp on 2020/7/30.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface SQLManager : NSObject

@property (nonatomic, strong, readonly) FMDatabaseQueue *dbQueue;

+(instancetype)shareInstance;

/// 提供创建多个表，建议每个模块创建一个表
/// @param sql 创表的sql，建议写在一个头文件用宏展开
/// @param tableName 表名，用于做重复建表检测
/// @note 有内部检测，不会重复建表
-(BOOL)createTableWithSql:(NSString *)sql tableName:(NSString *)tableName;



/// 插入数据，没有批量和事务操作
/// @param sql 插入语句，例子：insert of replace into table 就行了，后面的根据字典自动拼接
/// @param dict 需要插入的数据，插入前建议检查每个键值对的完整性
/// @param finish 完成回调
-(void)insertWithSql:(NSString *)sql dict:(id)dict finish:(void(^)(void))finish;



@end

NS_ASSUME_NONNULL_END
