//
//  MTDataModel.m
//  MT_NuoMi
//
//  Created by Austen on 15/9/13.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTDataModel.h"
#import "MTData.h"

@import CoreData;

@interface MTDataModel ()

@property (nonatomic) NSMutableArray *privateItems;

@property (nonatomic, strong) NSMutableArray *allAssetTypes;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

@end

NSString *itemArchivePath()//辅助函数c语言,返回保存地址
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [pathList[0] stringByAppendingPathComponent:@"n.data"];//
}

@implementation MTDataModel


static MTDataModel *_dataModel = nil;
+ (instancetype)sharedStore {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataModel = [[MTDataModel alloc] initPrivate];
    });
    return _dataModel;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataModel = [super alloc];
    });
    return _dataModel;
}

-(instancetype)initPrivate
{
    self = [super init];
    if (self)
    {
        //读取
        self.model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        
        //设置SQLite路径
        NSURL *storeURL = [NSURL fileURLWithPath:itemArchivePath()];
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error])
        {
            @throw [NSException exceptionWithName:@"OpenFailure"
                                           reason:[error localizedDescription]
                                         userInfo:nil];
        }
        
        //创建NSManagedObjectContext对象
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSManagedObjectContextLockingError];
        _context.persistentStoreCoordinator = psc;
        
        [self loadAllItems];
    }
    return self;
}


- (void)loadAllItems {
    if (!self.privateItems)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"MTData" inManagedObjectContext:self.context];
        request.entity = e;
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        request.sortDescriptors = @[sd];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        
        if (!result)
        {
            [NSException raise:@"Fetch failed" format:@"Reason:%@",[error localizedDescription]];
        }
        self.privateItems = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (BOOL)saveChanges {
    
    NSError *error;
    BOOL successful = [self.context save:&error];//向NSManagedObjectContext发送save消息
    if (!successful)
    {
        NSLog(@"Error saving:%@",[error localizedDescription]);
    }
    return successful;
}


- (NSArray *)allItems {
    
    return self.privateItems;
}

- (void)createItem {
    double order;
    if ([self.allItems count] == 0)
    {
        order = 1.0;
    }else
    {
        MTData *item = [self.privateItems lastObject];
        order = item.orderingValue + 1.0;
    }
    
    MTData *item = [NSEntityDescription insertNewObjectForEntityForName:@"MTData" inManagedObjectContext:self.context];
    
    item.orderingValue = order;
    
    //插入位置
    [self.privateItems addObject:item];
}

- (void)removeItem:(MTData *)item//删除
{
    [self.context deleteObject:item];
    [self.privateItems removeObjectIdenticalTo:item];
}



@end
