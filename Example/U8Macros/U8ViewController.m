//
//  U8ViewController.m
//  U8Macros
//
//  Created by Upping8 on 10/29/2022.
//  Copyright (c) 2022 Upping8. All rights reserved.
//

#import "U8ViewController.h"
#import <U8Macros/U8Macros.h>

@interface U8Person : NSObject
@property (nonatomic, copy)void(^block)();
@end
@implementation U8Person

- (instancetype)init {
    if (self = [super init]) {
        @weakify(self);
        self.block = ^{
//            @strongify(self);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [NSThread sleepForTimeInterval:2.0];
                NSLog(@"strongify - %@", self_weak_); // null; without @strongify(self)
            });
        };
    }
    return self;
}

@end

@interface U8ViewController ()

@end

@implementation U8ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self testMacros];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testMacros {
    @onExit {
        NSLog(@"onExit test");
    };
    NSLog(@"testMacros");
    
    //@strongify, @weakify
    U8Person *person = [[U8Person alloc] init];
    person.block();
}

@end
