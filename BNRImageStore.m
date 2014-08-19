//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Archer on 6/10/14.
//  Copyright (c) 2014 Oodalalee. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

- (NSString *)imagePathForKey:(NSString *)key;

@end

@implementation BNRImageStore

//Making singleton thread safe
+ (instancetype)sharedStore
{
    static BNRImageStore *sharedStore = nil;
    /*
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
     */
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
     
    return sharedStore;
}

//No one should call init
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRImageStore sharedStore]" userInfo:nil];
    
    return nil;
}

//Secret designated initializer
- (instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
        
        //registering imagestore as an observer of this low memory notification
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    
    return self;
}

- (void)clearCache:(NSNotification *)note
{
    NSLog(@"Flushing %d image out of the cache", [self.dictionary count]);
    [self.dictionary removeAllObjects];
    //Removing objeccts from a dictionary relinquishes ownership of the object, flushing
    //cache causes all images to lose an over. Images not being used are destroyed, wehn needed, will
    //be reloaded from filesystem.
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
    
    //Use NSData to copy JPEG representation into a buffer in memory.
    
    //Create full path for image
    NSString *imagePath = [self imagePathForKey:key];
    
    //Turn image into JPEG data
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    //Write it to full path
    [data writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key
{
    //Updated to load images loaded in filesystem
    //return self.dictionary[key];
    
    //If possible, get it from the dicitonary
    UIImage *result = self.dictionary[key];
    
    if (!result) {
        NSString *imagePath = [self imagePathForKey:key];
        
        //Create UIImage object from file
        result = [UIImage imageWithContentsOfFile:imagePath];
        
        //If we found an image on the filesystem, place it into the cache
        if (result) {
            self.dictionary[key] = result;
        } else {
            NSLog(@"error:unable to find %@", [self imagePathForKey:key]);
        }
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    
    //When image is deleted from store, also deleted from filesystem
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

//Implement this method to create a path in documents directory using a given key
- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}



@end
