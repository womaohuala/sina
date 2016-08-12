//
//  ThemeViewController.m
//  tracywb
//
//  Created by jimmy on 16/6/25.
//  Copyright © 2016年 yk. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManager.h"
#import "ThemeLabel.h"
#import "UIFactory.h"
#import "Contants.h"

@interface ThemeViewController ()

@end

@implementation ThemeViewController
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title= @"主题";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setThemeData];
}

//从theme.plist中获取主题内容
- (void) setThemeData{
    NSDictionary *dic = [ThemeManager shareThemeManager].themePlist;
    self.themes = [dic allKeys];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_themes count];
}

#pragma mark - UITableViewDataSource delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"theme";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        ThemeLabel *label = [[UIFactory alloc] createThemeLable:kThemeListLabel];
        label.tag = 2016;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:16.0f];
        label.frame = CGRectMake(10, 5, 200, 40);
        [cell.contentView addSubview:label];
    }
    ThemeLabel *label = [cell.contentView viewWithTag:2016];
    label.text = [_themes objectAtIndex:indexPath.row];
    NSString *themeName = [[NSUserDefaults standardUserDefaults] objectForKey:kDefaultThemeName];
    if([label.text isEqualToString:themeName]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *newThemeName = [_themes objectAtIndex:indexPath.row];
    if([newThemeName isEqualToString:@"默认"]){
        newThemeName = nil;
    }
    [ThemeManager shareThemeManager].themeName =newThemeName;
    //刷新列表
    [tableView reloadData];
    
    //同步到本地
    [[NSUserDefaults standardUserDefaults] setObject:[_themes objectAtIndex:indexPath.row] forKey:kDefaultThemeName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeNotification object:nil];
    
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
