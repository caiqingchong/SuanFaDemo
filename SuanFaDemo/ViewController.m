//
//  ViewController.m
//  SuanFaDemo
//
//  Created by 张张凯 on 2018/3/22.
//  Copyright © 2018年 TRS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) UITableView *sfTableView;
@property(nonatomic,retain) NSArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.sfTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.sfTableView.delegate = self;
    self.sfTableView.dataSource = self;
    
    [self.view addSubview:self.sfTableView];
    
    self.arr = @[@"选择排序",@"冒泡排序",@"插入排序",@"快速排序",@"双路快速排序",@"三路快速排序",@"堆排序"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifierString = @"simpleTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierString];
    }
  
    
    cell.textLabel.text = self.arr[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"选择算法为：%@",self.arr[indexPath.row]);
    NSMutableArray *arr_M = [NSMutableArray arrayWithObjects:@8,@4,@2,@3,@3,@5,@7,nil];
      NSMutableArray *array = [NSMutableArray arrayWithObjects:@9,@2,@10,@7,@3,@7,@4,nil];
    switch (indexPath.row) {
        case 0:
            [self selectPaiXu];
            break;
        case 1:
            [self maoPaoPaiXu];
            break;
        case 2:
            [self insertPaiXu];
            break;
        case 3:
//           NSLog(@"快速排序完成后的数据为：%@",[self QuickSorkOC:arr_M Count:arr_M.count]);
            
            //把Integer转化成int格式
//            int high = (int)arr_M.count-1;
         
            [self quickSort:arr_M low:0 high:6];
            break;
        case 4:

            break;
        case 5:

            break;
        case 6:

            break;

        default:
            break;
    }
    
    
}

/*
 选择排序思想：
 1、首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置
 2、再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。
 3、重复第二步，直到所有元素均排序完毕。
 */
- (void)selectPaiXu{
    NSMutableArray *arr_M = [NSMutableArray arrayWithObjects:@1,@4,@2,@3,@5,nil];

 
    for (int i=0; i<arr_M.count; i++) {
        
        for (int j=i+1; j<arr_M.count; j++) {
     
            if (arr_M[i]<arr_M[j]) {
               //此种交换思想首先是找出来一个较大的数A，放到第一个位置，然后再用A比对所有的数，就这样遇到比自己大的数就交换，当第一次遍历完成之后就会找出最大的数在第一个位置。  然后，开始从数据的第二个值开始遍历寻找第二小的数，以此类推可以排序出来。
                [arr_M exchangeObjectAtIndex:i withObjectAtIndex:j];
               
            }
        }
        
    }
    //打印结果  @[@5,@4,@3,@2,@1];
    NSLog(@"选择排序结果：%@",arr_M);
}

/*
 冒泡排序思想：
 它重复地走访过要排序的数列，一次比较两个元素，如果他们的顺序错误就把他们交换过来。走访数列的工作是重复地进行直到没有再需要交换，也就是说该数列已经排序完成。这个算法的名字由来是因为越小的元素会经由交换慢慢“浮”到数列的顶端。
 每一次都会遍历所有的数进行相邻比较。
 */

- (void)maoPaoPaiXu{
    NSMutableArray *arr_M = [NSMutableArray arrayWithObjects:@1,@4,@2,@3,@5,nil];
    for (int i = 0; i < arr_M.count; ++i) {
        
        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
        for (int j = 0; j < arr_M.count-1; ++j) {
            
            //根据索引的`相邻两位`进行`比较`
            if (arr_M[j] < arr_M[j+1]) {
                
                [arr_M exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"冒泡排序最终结果：%@",arr_M);
}


/*
 插入排序思想：
 插入排序是一种最简单直观的排序算法，它的工作原理是通过构建有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入。
 场景：生活中常用的场景就是打扑克牌。
 算法步骤：
 1、将第一待排序序列第一个元素看做一个有序序列，把第二个元素到最后一个元素当成是未排序序列。
 2、从头到尾依次扫描未排序序列，将扫描到的每个元素插入有序序列的适当位置。（如果待插入的元素与有序序列中的某个元素相等，则将待插入元素插入到相等元素的后面。）
 使用情况：直接插入排序适合记录数比較少、给定序列基本有序的情况
 */

- (void)insertPaiXu{
    NSMutableArray *arr_M = [NSMutableArray arrayWithObjects:@8,@4,@2,@3,@5,@7,nil];
    for (NSInteger i = 1; i < arr_M.count; i ++) {
        NSInteger temp = [arr_M[i] integerValue];
        for (NSInteger j = i - 1; j >= 0 && temp < [arr_M[j] integerValue]; j --) {
            arr_M[j + 1] = arr_M[j];
            arr_M[j] = [NSNumber numberWithInteger:temp];
        }
        //输出插入数据的步骤，查看内部思维方式  后一个数据对比前面的一个数据，刷新数组，然后原数组索引再次减一对比，例如index3替换index2，刷新变成index1,index3,index2,再次循环对比index1,index3，这样就能排出顺序了。
    }
    NSLog(@"插入升序排序结果：%@",arr_M);
    
}

/*
 快速排序思想：
 1．先从数列中取出一个数作为基准数。
 2．分区过程，将比这个数大的数全放到它的右边，小于或等于它的数全放到它的左边。
 3．再对左右区间重复第二步，直到各区间只有一个数。
 大致来说它才去的是一种分而治之的处理方式，用一个数不断地对数据进行分块处理。
 使用场景：较大数据的排序，排序快、效率高。
 
 终级思想：选一个比较值A，然后从数组左右两边开始查找，比A大的数放到A的右边，比A小的数放到A的左边，具体的方法就是和A互换值。
 */

#pragma - mark 快速排序 包含相同数据的处理  https://www.jianshu.com/p/34e920acfe1c
- (void)quickSort:(NSMutableArray *)array low:(int)low high:(int)high
{
    if(array == nil || array.count == 0){
        return;
    }
    if (low >= high) {
        return;
    }
    
    //取中值     排序前:9 2 10 7 3 7 4
    int middle = low + (high - low)/2;
        NSLog(@"打印出middle:%d",middle);

    //用中值作为分界线
    NSNumber *prmt = array[middle];
    int i = low;
    int j = high;

    //开始排序，使得left<prmt 同时right>prmt
    while (i <= j) {
        //        while ([array[i] compare:prmt] == NSOrderedAscending) {  该行与下一行作用相同
        while ([array[i] intValue] < [prmt intValue]) {
            i++;
        }
        //        while ([array[j] compare:prmt] == NSOrderedDescending) { 该行与下一行作用相同
        while ([array[j] intValue] > [prmt intValue]) {
            j--;
        }
        //i&j都在向中间逼近
        if(i <= j){
            [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
            j--;
        }
        
        printf("排序中:");
        NSLog(@"快速排序之后的数据位：%@",array);
//        [self printArray:array];
    }

    if (low < j) {
        [self quickSort:array low:low high:j];
    }
    if (high > i) {
        [self quickSort:array low:i high:high];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
