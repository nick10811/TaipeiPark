//
//  DBHelp.m
//  TaipeiPark
//
//  Created by Nick Yang on 29/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "DBHelp.h"
#import <FMDatabase.h>
#import "Attraction.h"

@implementation DBHelp

#pragma mark - public
- (id)init {
    self = [super init];
    if (self) {
        [self createTables];
    }
    return self;
}

- (NSInteger)getCount {
    FMDatabase *db = [self dbPreOpen];
    FMResultSet *resultSet = [db executeQuery:@"SELECT COUNT(name) AS count FROM Attractions "];
    
    int count = 0;
    while ([resultSet next]) {
        count = [resultSet intForColumn:@"count"];
        
    }
    
    [db close];
    
    return count;
    
}

- (void)cleanAttractions {
    FMDatabase *db = [self dbPreOpen];
    
    [db executeUpdate:@"DELETE FROM Attractions"]; // clean table
    
    [db close];
}

- (void)batchInsertAttraction:(NSArray *)atts {
    FMDatabase *db = [self dbPreOpen];
    
    for (Attraction *att in atts) {
        [db executeUpdate:@"INSERT INTO Attractions (parkName, name, yearBuild, openTime, image, introduction) VALUES (?,?,?,?,?,?)", att.ParkName, att.Name, att.YearBuilt, att.OpenTime, att.Image, att.Introduction];
    }
    
    [db close];
}

- (NSMutableDictionary *)getAttractionsByPark {
    FMDatabase *db = [self dbPreOpen];
    FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM Attractions ORDER BY parkName"];
    
    NSMutableDictionary *attractions = [[NSMutableDictionary alloc] init];
    while ([resultSet next]) {
        Attraction *tmp = [[Attraction alloc] init];
        tmp.ParkName = [resultSet stringForColumn:@"parkName"];
        tmp.Name = [resultSet stringForColumn:@"name"];
        tmp.YearBuilt = [resultSet stringForColumn:@"yearBuild"];
        tmp.OpenTime = [resultSet stringForColumn:@"openTime"];
        tmp.Image = [resultSet stringForColumn:@"image"];
        tmp.Introduction = [resultSet stringForColumn:@"introduction"];
        
        if (![[attractions allKeys] containsObject:tmp.ParkName]) {
            NSMutableArray *relations = [[NSMutableArray alloc] init];
            [relations addObject:tmp];
            
            [attractions setObject:relations forKey:tmp.ParkName];
            
        } else {
            NSMutableArray *existRelation = [attractions objectForKey:tmp.ParkName];
            [existRelation addObject:tmp];
            
            [attractions removeObjectForKey:tmp.ParkName];
            [attractions setObject:existRelation forKey:tmp.ParkName];
            
        }
        
    }
    
    [db close];
    
    return attractions;
}

- (NSMutableDictionary *)getAttractionsByKeyword:(NSString *)keyword {
    FMDatabase *db = [self dbPreOpen];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Attractions WHERE parkName LIKE '%%%@%%' OR name LIKE '%%%@%%' ORDER BY parkName", keyword, keyword];
    FMResultSet *resultSet = [db executeQuery:sql];
    
    NSMutableDictionary *attractions = [[NSMutableDictionary alloc] init];
    while ([resultSet next]) {
        Attraction *tmp = [[Attraction alloc] init];
        tmp.ParkName = [resultSet stringForColumn:@"parkName"];
        tmp.Name = [resultSet stringForColumn:@"name"];
        tmp.YearBuilt = [resultSet stringForColumn:@"yearBuild"];
        tmp.OpenTime = [resultSet stringForColumn:@"openTime"];
        tmp.Image = [resultSet stringForColumn:@"image"];
        tmp.Introduction = [resultSet stringForColumn:@"introduction"];
        
        if (![[attractions allKeys] containsObject:tmp.ParkName]) {
            NSMutableArray *relations = [[NSMutableArray alloc] init];
            [relations addObject:tmp];
            
            [attractions setObject:relations forKey:tmp.ParkName];
            
        } else {
            NSMutableArray *existRelation = [attractions objectForKey:tmp.ParkName];
            [existRelation addObject:tmp];
            
            [attractions removeObjectForKey:tmp.ParkName];
            [attractions setObject:existRelation forKey:tmp.ParkName];
            
        }
        
    }
    
    [db close];
    
    return attractions;
}

#pragma mark - private
- (FMDatabase *)dbPreOpen {
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"TaipeiPark.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if (![db open]) {
        NSLog(@"[ERROR][DB] db open failure");
        db = nil;
    }
    
    return db;
}

- (void)createTables {
    FMDatabase *db = [self dbPreOpen];
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Attractions (id INTEGER PRIMARY KEY AUTOINCREMENT, parkName TEXT, name TEXT, yearBuild TEXT, openTime TEXT, image TEXT, introduction TEXT)"];
    [db close];
}

@end
