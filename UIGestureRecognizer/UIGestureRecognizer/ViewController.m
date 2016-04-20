//
//  ViewController.m
//  UIGestureRecognizer
//
//  Created by  江苏 on 16/4/20.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIImageView* imageView;
@end

@implementation ViewController


-(UIImageView *)imageView{
    
    if (_imageView==nil) {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
        _imageView.image=[UIImage imageNamed:@"IMG_2388"];
        _imageView.userInteractionEnabled=YES;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //点击手势
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate=self;
    [self.imageView addGestureRecognizer:tap];
    
    //拖动手势
    UIPanGestureRecognizer* pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    pan.delegate=self;
    [self.imageView addGestureRecognizer:pan];
    
    //捏合手势
    UIPinchGestureRecognizer* pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    pinch.delegate=self;
    [self.imageView addGestureRecognizer:pinch];
    
    //旋转手势
    UIRotationGestureRecognizer* rotate=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotate:)];
    rotate.delegate=self;
    [self.imageView addGestureRecognizer:rotate];
    
    //轻扫手势
    UISwipeGestureRecognizer* swipeDefault=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDefault:)];
    swipeDefault.delegate=self;
    swipeDefault.direction=UISwipeGestureRecognizerDirectionRight;
    [self.imageView addGestureRecognizer:swipeDefault];
    
    UISwipeGestureRecognizer* swipeLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDefault:)];
    swipeLeft.delegate=self;
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.imageView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer* swipeDown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDefault:)];
    swipeDown.delegate=self;
    swipeDown.direction=UISwipeGestureRecognizerDirectionDown;
    [self.imageView addGestureRecognizer:swipeDown];
    
    UISwipeGestureRecognizer* swipeUp=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDefault:)];
    swipeUp.delegate=self;
    swipeUp.direction=UISwipeGestureRecognizerDirectionUp;
    [self.imageView addGestureRecognizer:swipeUp];
    
    //长按手势
    UILongPressGestureRecognizer* longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.delegate=self;
    [self.imageView addGestureRecognizer:longPress];
}

-(void)longPress:(UILongPressGestureRecognizer *)longPress{
    //按住的时候回调用一次，松开的时候还会再调用一次
    NSLog(@"长按图片");
}

-(void)swipeDefault:(UISwipeGestureRecognizer*)swipe{
    if (swipe.direction==UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"向右轻扫");
    }else if(swipe.direction==UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"向左轻扫");
    }else if(swipe.direction==UISwipeGestureRecognizerDirectionUp){
        NSLog(@"向上轻扫");
    }else{
        NSLog(@"向下轻扫");
    }
}

-(void)rotate:(UIRotationGestureRecognizer*)rotate{
    
    self.imageView.transform=CGAffineTransformRotate(self.imageView.transform, rotate.rotation);
    //复位
    rotate.rotation=0;
}

-(void)pinch:(UIPinchGestureRecognizer*)pinch{
    CGFloat scale=pinch.scale;
    
    self.imageView.transform=CGAffineTransformScale(self.imageView.transform, scale, scale);
    
    pinch.scale=1;
}

-(void)pan:(UIPanGestureRecognizer*)pan{
//    CGPoint transP=[pan locationInView:self.view];
//    self.imageView.center=transP;
    CGPoint transP=[pan translationInView:self.imageView];
    
    self.imageView.transform=CGAffineTransformTranslate(self.imageView.transform, transP.x, transP.y);
    
    [pan setTranslation:CGPointZero inView:self.imageView];
    
}

-(void)tap:(UITapGestureRecognizer*)tap{
    NSLog(@"点击了图片");
}

//允许多事件同时发生
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return  YES;
}

@end
