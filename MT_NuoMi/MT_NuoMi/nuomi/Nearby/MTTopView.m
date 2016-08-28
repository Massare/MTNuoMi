//
//  MTTopView.m
//  MT_NuoMi
//
//  Created by Austen on 15/10/2.
//  Copyright © 2015年 mlc. All rights reserved.
//

#import "MTTopView.h"

@interface MTTopView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _bigSelectedIndex;//主
    NSInteger _smallSelectedIndex;//次
}

@property(nonatomic, strong) UITableView *tableViewOfGroup;
@property(nonatomic, strong) UITableView *tableViewOfDetail;

@end

@implementation MTTopView

-(void)initViews
{
    //分组
    self.tableViewOfGroup = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height) style:UITableViewStylePlain];
    self.tableViewOfGroup.tag = 10;
    self.tableViewOfGroup.delegate = self;
    self.tableViewOfGroup.dataSource = self;
    self.tableViewOfGroup.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0];
    self.tableViewOfGroup.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableViewOfGroup];
    
    //详情
    self.tableViewOfDetail = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height) style:UITableViewStylePlain];
    self.tableViewOfDetail.tag = 20;
    self.tableViewOfDetail.dataSource = self;
    self.tableViewOfDetail.delegate = self;
    self.tableViewOfDetail.backgroundColor = [UIColor whiteColor];
    self.tableViewOfDetail.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableViewOfDetail];
    
    self.userInteractionEnabled = YES;
}

-(void)initView
{
    //分组
    self.tableViewOfGroup = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    self.tableViewOfGroup.tag = 10;
    self.tableViewOfGroup.delegate = self;
    self.tableViewOfGroup.dataSource = self;
    self.tableViewOfGroup.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0];
    self.tableViewOfGroup.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableViewOfGroup];
    
    self.userInteractionEnabled = YES;
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // NSLog(@"%ld--%ld",(long)_bigSelectedIndex,tableView.tag);
    if (tableView.tag == 10)
    {
        if ( _bigGroupArray.count == 0)
        {
            return 0;
        }else
        {
            return _bigGroupArray.count-1;
        }
    }
    else if(tableView.tag == 20)
    {
        if ([_bigGroupArray[1][@"array"] count] > 0)
        {
            NSArray *list = _bigGroupArray[_bigSelectedIndex+1][@"array"];
            return list.count;
            
        }else
        {
            return 0;
        }
        
    }else
    {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10)
    {
        if([_bigGroupArray[0] integerValue] != 3)
        {
            static NSString *cellIndentifier = @"filterCell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            }
            
            if ([_bigGroupArray[0] integerValue] == 0)
            {
                cell.textLabel.text = _bigGroupArray[indexPath.row+1][@"name"];
                cell.detailTextLabel.text = _bigGroupArray[indexPath.row+1][@"title"];
                
            }else if([_bigGroupArray[0] integerValue] == 1)
            {
                cell.textLabel.text = _bigGroupArray[indexPath.row+1][@"name"];
                if ([_bigGroupArray[indexPath.row+1][@"title"] integerValue] != 0)
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",[_bigGroupArray[indexPath.row+1][@"title"] integerValue]];
                }
                
            }else
            {
                cell.textLabel.text = _bigGroupArray[indexPath.row+1][@"name"];
                
            }
            
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            
            cell.backgroundColor =[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0];
            cell.textLabel.highlightedTextColor = [UIColor colorWithRed:252/255.0 green:74/255.0 blue:132/255.0 alpha:0.9];
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            return cell;
        }else
        {
            static NSString *cellIndentifier = @"filterCell2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            
            cell.textLabel.text = _bigGroupArray[indexPath.row+1][@"name"];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            cell.backgroundColor =[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0];
            cell.textLabel.highlightedTextColor = [UIColor colorWithRed:252/255.0 green:74/255.0 blue:132/255.0 alpha:0.9];
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            return cell;
        }
        
    }else
    {
        static NSString *cellIndentifier = @"filterCell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            //下划线
            //UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 41.5, cell.frame.size.width, 0.5)];
            //lineView.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0];
            //[cell.contentView addSubview:lineView];
        }
        
        cell.textLabel.text = _bigGroupArray[_bigSelectedIndex+1][@"array"][indexPath.row];
        cell.backgroundColor =[UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.highlightedTextColor = [UIColor colorWithRed:252/255.0 green:74/255.0 blue:132/255.0 alpha:0.9];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10)
    {
        _bigSelectedIndex = indexPath.row;
        
        if ([_bigGroupArray[0] integerValue] != 1)
        {
            [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath withId:_bigGroupArray[0] withName:_bigGroupArray[indexPath.row+1][@"name"]];
            
            [self.tableViewOfDetail reloadData];
            self.tableViewOfDetail.tag = 0;
            self.tableViewOfGroup.tag = 0;
            [self.tableViewOfDetail removeFromSuperview];
            [self.tableViewOfGroup removeFromSuperview];
        }else
        {
            [self.tableViewOfDetail reloadData];
        }
        
    }else
    {
        _smallSelectedIndex = indexPath.row;
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:_bigSelectedIndex];
        
        [self.delegate tableView:tableView didSelectRowAtIndexPath:newIndexPath withId:_bigGroupArray[0] withName:_bigGroupArray[_bigSelectedIndex+1][@"array"][indexPath.row]];
        
        [self.tableViewOfDetail reloadData];
        self.tableViewOfDetail.tag = 0;
        self.tableViewOfGroup.tag = 0;
        [self.tableViewOfDetail removeFromSuperview];
        [self.tableViewOfGroup removeFromSuperview];
    }
}

- (void)setBigGroupArray:(NSMutableArray *)bigGroupArray
{
    _bigGroupArray = [NSMutableArray arrayWithArray:bigGroupArray];
    
    if ([_bigGroupArray[0] integerValue] == 1)
    {
        
        if (_topArray)
        {
            NSIndexPath *indexPath = _topArray[[_bigGroupArray[0] intValue]];
            _smallSelectedIndex = indexPath.row;
            _bigSelectedIndex = indexPath.section;
        }else
        {
            _bigSelectedIndex = 0;
            _smallSelectedIndex = 0;
        }
        
        [self initViews];
        
        //设置初始点击状态
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:_bigSelectedIndex inSection:0];
        [self.tableViewOfGroup selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        NSIndexPath *detailIndexPath = [NSIndexPath indexPathForRow:_smallSelectedIndex inSection:0];
        [self.tableViewOfDetail selectRowAtIndexPath:detailIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }else
    {
        
        if (_topArray)
        {
            NSIndexPath *indexPath = _topArray[[_bigGroupArray[0] intValue]];
            _bigSelectedIndex = indexPath.row;
        }else
        {
            _bigSelectedIndex = 0;
        }
        
        [self initView];
        
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:_bigSelectedIndex inSection:0];
        [self.tableViewOfGroup selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    //[self.tableViewOfGroup reloadData];
}


@end
