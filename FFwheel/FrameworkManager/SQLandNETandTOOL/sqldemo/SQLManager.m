//
//  SQLManager.m
//  iOSTest-OC
//
//  Created by ffzp on 2020/7/30.
//  Copyright © 2020 ffzp. All rights reserved.
//
#import <YYKit/YYKit.h>
#import "SQLManager.h"
static NSString *_dbPath = nil;
static NSString *_dbName = @"demoDB";
@interface SQLManager()
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
@property (nonatomic, strong) NSMutableArray *tableArr;
@end
@implementation SQLManager

+(instancetype)shareInstance{
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    });
    return _instance;
}

-(BOOL)createTableWithSql:(NSString *)sql tableName:(NSString *)tableName{
    //检测表
    for (NSString * name in self.tableArr) {
        if(tableName == name){
            NSLog(@"已有重复的表");
            return NO;
        }
    }
    [self.tableArr addObject:tableName];
    __block BOOL _result = NULL;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        _result = [db executeStatements:sql];
        if (_result) {
            NSLog(@"创建表成功");
        }else {
            NSLog(@"创建表失败");
        }
    }];
    return _result;
}

-(void)insertWithSql:(NSString *)sql dict:(id)dict finish:(void(^)(void))finish{
    if(!dict)return;    //字典不能为空，为空时直接返回
    if(!sql) return;
    //如果需要整合处理，需要在这之前完成。在dict里的需要打包的东西转换成nsdata
    
    //NSData *data = [NSJSONSerialization dataWithJSONObject:dictData options:0 error:nil];
    NSString *newSql = [self formatInsertSqlWithDic:dict sql:sql];
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        @try {
            
            if(![db executeUpdate:newSql withArgumentsInArray:[dict values]]){
                //插入失败，作回滚
                *rollback = YES;
            }
        } @catch (NSException *exception) {
            NSLog(@"存储错误：%@",exception);
        } @finally {
        }
        !finish?:finish();
    }];
}

-(void)selectWithSql:(NSString *)sql finish:(void (^)(NSMutableArray<NSMutableDictionary *> * _Nonnull data))finish{
    if(!sql) return;
    NSMutableArray<NSMutableDictionary *> *dictArrayM = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:sql withArgumentsInArray:@[]];
        //查完解析json
        while (result.next) {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
            for (int i = 0; i < result.columnCount; i++) {
                
                NSString *colName  = [result columnNameForIndex:i];
                NSString *colValue = [result objectForColumn:colName];
                dictM[colName] = colValue;
                
            }
            //NSData *data = dictM[@"notice"];
            //[dictArrayM addObject:[data jsonValueDecoded]];
        }
        !finish?:finish(dictArrayM);
    }];
}

-(void)deleteWithSql:(NSString *)sql{
    if(!sql) return;
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        if([db executeUpdate:sql withArgumentsInArray:@[]]){
            NSLog(@"%d 删除成功!",db.changes);
            *rollback = NO;
        }else{
            *rollback = YES;
        }
    }];
}



- (FMDatabaseQueue *)dbQueue{
    if(_dbQueue == nil)
    {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:_dbPath];
    }
    return _dbQueue;
}

+ (void)load{
    _dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:_dbName];
    //NSLog(@"%@", _dbPath);
}


-(NSString *)formatInsertSqlWithDic:(NSDictionary *)dict sql:(NSString *)sql{
    NSString * keyStr = @"(";
    NSString * valueStr = @" values(";
    NSArray *keyArr = [dict allKeys];
    for (int i = 0; i < keyArr.count; i++) {
        if (i == keyArr.count - 1) {    //最后一个
            keyStr   =  [NSString stringWithFormat:@"%@%@)",keyStr,keyArr[i]];
            valueStr =  [NSString stringWithFormat:@"%@?)",valueStr];
        }else{
            keyStr   =  [NSString stringWithFormat:@"%@%@,",keyStr,keyArr[i]];
            valueStr =  [NSString stringWithFormat:@"%@?,",valueStr];
        }
    }
    return [NSString stringWithFormat:@"%@%@%@",sql,keyStr,valueStr];
}

@end
