//
//  HDChartView.m
//  HengruiHealthy
//
//  Created by Mac on 2017/7/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HDChartView.h"

#import "HDAxis.h"

#define HDChartWidth self.bounds.size.width //视图宽度
#define HDChartHeight self.bounds.size.height // 视图高度
#define HDChartDrawRectX HDChartMarginLeft //绘制区域x坐标 值为绘制区域距视图左边距
#define HDChartDrawRectY HDChartMarginTop //绘制区域y坐标 值为绘制区域距视图右边距
#define HDChartDrawRectW HDChartWidth - HDChartMarginLeft - HDChartMarginRight //绘制区域宽度 值为视图宽度减去绘制区域距视图左、右边距
#define HDChartDrawRectH HDChartHeight - HDChartMarginTop - HDChartMagringBottom //绘制区域高度 值为视图宽度减去绘制区域距视图上、下边距
#define HDChartDrawRect CGRectMake(HDChartDrawRectX, HDChartDrawRectY, HDChartDrawRectW, HDChartDrawRectH) //绘制区域范围
#define HDChartMarginTop 10 //绘制区域距视图上边距
#define HDChartMagringBottom 40 //绘制区域距视图下边距
#define HDChartMarginLeft 30 //绘制区域距视图左边距
#define HDChartMarginRight 20 //绘制区域距视图右边距

@interface HDChartView () {
    NSMutableArray *_xLabels; //x轴显示坐标lebel集合
    NSMutableArray *_yLabels; //y轴显示坐标lebel集合
    
    NSMutableArray *_dataLayers; //绘制折线与折点的layer集合
    
    HDChartData *_chartData; //折线与折点数据
    NSMutableArray<UIColor *> *_lineColors; //折线与折点颜色集合
    NSMutableArray<NSString *> *_titles; //折线与折点标题集合
    NSMutableArray<NSArray<HDChartLineCoordition *> *> *_coorditions; //折点坐标集合
    NSMutableArray *_responseRects; //点击响应区域集合
    
    UILabel *_lblInfo; //折点点击信息展示label
    UIScrollView *_scroll;
//    ObtianFinalSymbolInfo _finalInfo;
}

@end

NSString *const kHDChartX = @"key_chart_hd_x";
NSString *const kHDChartY = @"key_chart_hd_y";
NSString *const kHDChartR = @"key_chart_hd_rect";

@implementation HDChartView


/**
 设置折线数据

 @param chartData 折线数据模型
 */
- (void)setDatas:(HDChartData *)chartData {
//    初始化数据集合
    _lineColors = [NSMutableArray array];
    _titles = [NSMutableArray array];
    _coorditions = [NSMutableArray array];
    
//    获取折线数据
    id datas = [chartData obtainLineDatas];
//    判断返回值类型一条折线时为NSDictionary， 多条时为NSDictionary的集合
    if ([datas isKindOfClass:[NSArray class]]) {
        NSArray<NSDictionary *> *chartDataArray = (NSArray *)datas;
        [chartDataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//          遍历折点值，将x值转换为NSNumber型，并存储其他数据
            [self configCoorditions:obj];
        }];
    } else {
        NSDictionary *chartDataMap = (NSDictionary *)datas;
//          遍历折点值，将x值转换为NSNumber型，并存储其他数据
        [self configCoorditions:chartDataMap];
    }
    _chartData = chartData;
}

/**
 绘制折线
 */
- (void)strokePath {
    _responseRects = [NSMutableArray array];
    _dataLayers = [NSMutableArray array];
//    绘制折线
    [self drawPath];
}


/**
 更新绘制折现

 @param datas 折线数据模型
 */
- (void)updateDatas:(HDChartData *)datas {
    if (_responseRects == nil) {
        _responseRects = [NSMutableArray array];
    }
    if (_dataLayers == nil) {
        _dataLayers = [NSMutableArray array];
    }
//    更新数据时隐藏已显示的信息
    [self hideInfo];
//    移除所有现有折线数据的layer
    [_dataLayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
//    移除所有已存储的数据
    [_lineColors removeAllObjects];
    [_dataLayers removeAllObjects];
    [_titles removeAllObjects];
    [_coorditions removeAllObjects];
    [_responseRects removeAllObjects];
//    配置数据
    [self setDatas:datas];
    [self drawPath];
}

/**
 更新x轴坐标数据
 
 @param xValues x轴坐标点
 @param count 显示的坐标点数量
 */
- (void)updateXLabels:(NSArray *)xValues count:(int)count {
//    更新x坐标时隐藏已显示信息
    [self hideInfo];
//    重新赋值x坐标数组
    self.xAxisValues = xValues;
////    判断显示坐标数量，如果和
//    if (self.xLabelCount != count) {
//    移除现有所有x轴的label，重新计算并绘制x轴label
    if (count > 0) {
        self.xLabelCount = count;
    }
    [_xLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_xLabels removeAllObjects];
    [self configXLabels];
//    } else {
//        [_xLabels enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            obj.text = xValues[obj.tag];
//        }];
//    }
}

/**
 获取折点数据

 @return 折点数据
 */
- (HDChartData *)obtainCharData {
    return _chartData;
}

/**
 初始化方法

 @return 返回实例
 */

- (instancetype)init {
    if (self = [super init]) {
        [self initComponents];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initComponents];
}

/**
 初始化组件
 */
- (void)initComponents {
    //        初始化x、ylabel数组
    _xLabels = [NSMutableArray array];
    _yLabels = [NSMutableArray array];
    //        初始化信息label并配置
    _lblInfo = [[UILabel alloc] init];
//    _lblInfo.layer.borderColor = [UIColor blackColor].CGColor;
//    _lblInfo.layer.borderWidth = 1;
    _lblInfo.layer.cornerRadius = 3;
    _lblInfo.backgroundColor = [UIColor blackColor];
    _lblInfo.textColor = [UIColor whiteColor];
    _lblInfo.numberOfLines = 0;
    _lblInfo.font = [UIFont systemFontOfSize:10.0f];
    _lblInfo.hidden = YES;
    _lblInfo.frame = CGRectMake(0, 0, 0, 0);
    [self addSubview:_lblInfo];
    //        添加单击手势
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchView:)];
    [self addGestureRecognizer:pan];
}

/**
 绘制折线图背景。网格、x、y坐标等
 */
- (void)initChartBG {
//    配置x轴坐标
    [self configXLabels];
//    配置y轴坐标
    [self configYLabels];
//    绘制网格
    [self drawGridLine];
}

/**
 配置x轴坐标
 */
- (void)configXLabels {
//    所有坐标点
    int totalCount =  (int)self.xAxisValues.count - 1;
//    显示的x轴坐标数量平分所有坐标点后剩余的点
    int remainder = totalCount % (self.xLabelCount - 1);
//    每个几个点显示坐标
    int offset = totalCount / (self.xLabelCount - 1);
//    x轴显示的坐标点label的y坐标
    float y = HDChartHeight - HDChartMagringBottom;
//    根据所有坐标点平分绘制区域宽度
    float distance = (HDChartWidth - HDChartMarginLeft - HDChartMarginRight) / totalCount;
//    配置需要显示的x坐标的label--计算平分间隔，如果有余数则由后至前平分，及从最后一个起平均距离加1，余数加完为止
    for (int i = 0;  i < self.xLabelCount; i ++) {
//        创建实际平均间隔，初始值为标准间隔
//        int realOff = offset;
        int index = offset * i;
//        计算实际间隔，i大于余数后每个间隔加1
        if (i >= remainder && remainder != 0) {
//            realOff = offset + 1;
            index = index + i - 1;
        }
//        计算坐标label的实际位置
//        int index = realOff * i;
//        计算label的x坐标
        float x = index * distance + HDChartMarginLeft - 20;
//        创建显示坐标的label并配置
        UILabel *label = [self getLabelWithtextAlignment:NSTextAlignmentCenter];
        label.frame = CGRectMake(x, y, 40, HDChartMagringBottom);
//        获取显示的x坐标的label的值，根据位置由x坐标数组取值
        label.text = self.xAxisValues[index];
//        设置label的标记，为坐标内容在坐标数组中的index，更新x坐标时会用到
        label.tag = index;
//        保存label
        [_xLabels addObject:label];
        [self addSubview:label];
    }
}

/**
 配置y坐标
 */
- (void)configYLabels {
//    计算数据间隔，及绘制区域y轴分度值
    int differ = self.yAxisMax - self.yAxisMin;
//    计算绘制区域y轴分度值
    float distance = (HDChartHeight - HDChartMagringBottom - HDChartMarginTop) / differ;
//    计算显示坐标分度值
    int offCount = differ / self.yLabelCount;
//    创建y轴坐标
    for (int i = self.yLabelCount; i >= 0; i --) {
//        计算显示的label的坐标，规则为i值乘以坐标分度值乘以坐标分度值
        float y = i * offCount * distance;
//        创建label并配置
        UILabel *label = [self getLabelWithtextAlignment:NSTextAlignmentRight];
        label.frame = CGRectMake(0, y, HDChartMarginLeft - 3, 20);
//        格式化显示坐标文本格式
        label.text = [NSString stringWithFormat:@"%.0f", (self.yLabelCount - i) * offCount + self.yAxisMin];
        if (self.formatYAxis) {
            label.text = self.formatYAxis(label.text);
        }
        [_yLabels addObject:label];
        [self addSubview:label];
    }
}

/**
 绘制网格
 */
- (void)drawGridLine {
//    网格背景layer并配置
    CAShapeLayer *grigLayer = [[CAShapeLayer alloc] init];
    ;
    grigLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    grigLayer.lineDashPattern = @[@3,@3];
//    网格layer范围为绘制区域范围
    grigLayer.frame = HDChartDrawRect;
    UIBezierPath *bezier = [[UIBezierPath alloc] init];
    bezier.lineWidth = 1;
//    网格线位置为显示y坐标分度值，长度为绘制区域宽度，参考y轴显示坐标
    int differ = self.yAxisMax - self.yAxisMin;
    float distance = (HDChartHeight - HDChartMagringBottom - HDChartMarginTop) / differ;
    int offCount = differ / self.yLabelCount;
    for (int i = self.yLabelCount; i >= 0; i --) {
        float y = i * offCount * distance;
        [bezier moveToPoint:CGPointMake(0, y)];
        [bezier addLineToPoint:CGPointMake(grigLayer.bounds.size.width, y)];
    }
    grigLayer.path = bezier.CGPath;
    [self.layer addSublayer:grigLayer];
}

/**
 绘制折线与折点数据
 */
- (void)drawPath {
    
//    计算绘制区域x分度值
    int xTotalCount = (int)self.xAxisValues.count;
    float drawWidth = HDChartDrawRectW;
    float xDistance = drawWidth / (xTotalCount - 1);
    NSLog(@"%f", HDChartDrawRectW);
//    计算绘制区域y分度值
    int yTotalCount = self.yAxisMax - self.yAxisMin;
    float drawHeight = HDChartDrawRectH;
    float yDistance = drawHeight / (yTotalCount - 1);
    NSLog(@"%f", HDChartDrawRectH);
//    折线数量
    int lineCount = _chartData.lineCount;
//    配置折线与折点路径及layer
    for (int i = 0; i < lineCount; i ++) {
//      配置layer
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.frame = HDChartDrawRect;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [_lineColors[i] CGColor];
        layer.fillMode = kCAFillModeRemoved;
//       折点数据
        NSArray<HDChartLineCoordition *> *coorditions = _coorditions[i];
        if (coorditions.count == 0 || coorditions == nil) {
            continue;
        }
//        上一个折点坐标
        __block CGPoint point_previous;
//        bezier曲线
        UIBezierPath *bezier = [[UIBezierPath alloc] init];
//        遍历折点数据，配置路径折点位置及路径坐标
        [coorditions enumerateObjectsUsingBlock:^(HDChartLineCoordition * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            折点x坐标，计算方式为x值在x坐标数组中的值乘以x轴分度值
            float x = [obj.x integerValue] * xDistance;
//            折点y坐标，计算方式为y数据值诚意y轴分度值
            float y = HDChartDrawRectH - (obj.y - self.yAxisMin) * yDistance;
            
//            折点坐标
            CGPoint point = CGPointMake(x, y);
//            折点点击范围，折点圆心减去半径为坐标原点，长宽为4
            CGRect responseRect = {{x - 2 + HDChartMarginLeft, y - 2 + HDChartMarginTop}, {4, 4}};
//            保存折点点击范围，NSValue值
            NSMutableDictionary *symbolInfo = [NSMutableDictionary dictionary];
            symbolInfo[kHDChartR] = [NSValue valueWithCGRect:responseRect];
            symbolInfo[kHDChartX] = [self.xAxisValues objectAtIndex:[obj.x integerValue]];
            symbolInfo[kHDChartY] = @(obj.y);
            [_responseRects addObject:symbolInfo];
//            绘制这点，半径为2的空心圆，边宽为1
            [bezier moveToPoint:point];
            [bezier addArcWithCenter:point radius:2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
//            这点index大于0时，计算折线起始坐标，绘制路径
            if (idx != 0) {
//                折线起点坐标，已上一折点圆心为原点，与当前折点坐标与x轴围成直角三角形
//                基准角为x轴与两点圆心连线夹角。x轴为夹角邻边，连线为斜边
//                邻边长度为当前折点圆心x值减去上一折点圆心x值的值
                float distance_start_end_x = point.x - point_previous.x;
//                对边长度为当前折点圆心y值减去上一折点圆心y值的值
                float distance_start_end_y = point.y - point_previous.y;
//                利用三角函数计算斜边长度
                double hytenuse_start_end = hypot(distance_start_end_x, distance_start_end_y);
//                根据相似三角形原理，计算路径起始坐标和结束坐标
//                路径起点坐标为路径与上一折点连接处坐标，及斜边长度为折点半径长度的与两点三角形相似的三角形，邻边长度即为上一折点为原点时x值
                float start_x = distance_start_end_x * 2 / hytenuse_start_end;
//                与x值同理计算y值
                float start_y = distance_start_end_y * 2 / hytenuse_start_end;
//                与起始点同理计算结束点坐标，斜边长度为两点连线减去折点半径，x、y值计算参考起始点
                float end_x = distance_start_end_x - start_x;
                float end_y = distance_start_end_y - start_y;
//                实际起始点坐标为起始点为原点x值加上上一折点x值，y值同理，结束点同理
                CGPoint point_start = {start_x + point_previous.x, start_y + point_previous.y};
                CGPoint point_end = {end_x + point_previous.x, end_y + point_previous.y};
//                绘制路径
                [bezier moveToPoint:point_start];
                [bezier addLineToPoint:point_end];
                
            }
//            保存当前折点为上一折点，下一路径使用
            point_previous = point;
        }];
        layer.path = bezier.CGPath;
        [_dataLayers addObject:layer];
        [self.layer addSublayer:layer];
    }
}

/**
 显示的坐标label

 @param textAlignment 文本对其方式，y轴右对齐，x轴居中
 @return 返回label
 */
- (UILabel *)getLabelWithtextAlignment:(NSInteger)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:10.0f];
    label.numberOfLines = 0;
    label.textAlignment = textAlignment;
    return label;
}

/**
 分类保存折线数据
 转换折点x坐标，将文本转换为其在x坐标数组下标，方便计算折点坐标

 @param chartDataMap 折线数据字典
 */
- (void)configCoorditions:(NSDictionary *)chartDataMap {
    [_lineColors addObject:chartDataMap[kHDChartLineColor]];
    [_titles addObject:chartDataMap[kHDChartLineTitle]];
    NSArray<HDChartLineCoordition *> *coorditions = chartDataMap[kHDChartLineCoorditions];
    [coorditions enumerateObjectsUsingBlock:^(HDChartLineCoordition * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([_xAxisValues containsObject:obj.x]) {
            NSInteger index = [_xAxisValues indexOfObject:obj.x];
            obj.x = @(index);
        }
        
    }];
    [_coorditions addObject:coorditions];
}

/**
视图点击事件

 @param pan 视图单击手势
 */
- (void)touchView:(UITapGestureRecognizer *)pan {
//    被点击的坐标点
    CGPoint touchPoint = [pan locationInView:self];
//    保存被点击到的折点的数组
    NSMutableArray *touchRects = [NSMutableArray array];
//    [_responseRects enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGRect responseRect = [obj[kHDChartR] CGRectValue];
//        if (CGRectContainsPoint(responseRect, touchPoint)) {
//            [touchRects addObject:obj];
//        }
//    }];
//    遍历折点范围数组，找出被点击到的折点范围并保存
    for (NSDictionary *responseRectMap in _responseRects) {
        CGRect responseRect = [responseRectMap[kHDChartR] CGRectValue];
        if (CGRectContainsPoint(responseRect, touchPoint)) {
            [touchRects addObject:responseRectMap];
        }
    }
//    判断点击到的折点数量，如果有显示所有被点击到的折点信息，如果没有则隐藏已显示的折点信息
    if (touchRects.count > 0) {
//        小->大排序被点击折点数组，根据最小y值与最大y值和折点信息label高度判断显示位置
        [touchRects sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
            CGRect rect1 = [obj1[kHDChartR] CGRectValue];
            CGRect rect2 = [obj2[kHDChartR] CGRectValue];
            return rect1.origin.y > rect2.origin.y;
        }];
//        执行代理方法，获取要显示的折点信息
        if ([self.delegate respondsToSelector:@selector(touchSymbol:)]) {
            NSString *finalInfo = [self.delegate touchSymbol:touchRects];
//            显示信息label，配置信息，计算高度
            _lblInfo.hidden = NO;
            _lblInfo.text = finalInfo;
            [_lblInfo sizeToFit];
            float height = _lblInfo.bounds.size.height;
            float width = _lblInfo.bounds.size.width;
/**
    判断label高度大于view高度时label高度等于view高度，字体自适应
    否则判断最小y值距顶端距离大于label高度时label显示在最小y值上方
    否则判断最大y值距底部距离大于label高度时label显示在最大y值下方
    否则判断点击位置y值上下边距，都大于label一半高度则触点为label中心，否则计算差值使labal完全显示在view中
    x横轴位置同理
 */
            float viewHeight = HDChartHeight;
            float viewWidth = HDChartWidth;
            float y_top = [[touchRects firstObject][kHDChartR] CGRectValue].origin.y;
            float y_bottom = [[touchRects lastObject][kHDChartR] CGRectValue].origin.y;
            float x = touchPoint.x;
            float y = touchPoint.y;
            CGPoint center;
            if (x < width / 2) {
                x = width / 2;
            } else if (viewWidth - x < width / 2) {
                x = viewWidth - width / 2;
            }
            if (viewHeight < height) {
                _lblInfo.bounds = CGRectMake(0, 0, width, viewHeight);
                y = viewWidth / 2;
            } else if (y_top - height > 0) {
                y = y_top - height / 2;
//                center = CGPointMake(touchPoint.x, y_top - height / 2);
            } else if (y_bottom + height  < viewHeight) {
                y = y_bottom + height / 2;
//                center = CGPointMake(touchPoint.x, y_bottom + height / 2);
            } else {
//                center = touchPoint;
                if (y < height / 2) {
                    y = height / 2;
                } else if (viewWidth - y < height / 2) {
                    y = viewHeight - height / 2;
                }
            }
            center = CGPointMake(x, y);
            _lblInfo.center = center;
            [_lblInfo sizeToFit];
        }

        
    } else {
        [self hideInfo];
    }
}

- (NSArray *)getLegends {
    HDChartData *data = [self obtainCharData];
    NSMutableArray *legengs = [NSMutableArray array];
    for (int i = 0; i < data.lineCount; i ++) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path setLineWidth:1];
        [path moveToPoint:CGPointMake(0, 2.5)];
        [path addLineToPoint:CGPointMake(16, 2.5)];
        [path moveToPoint:CGPointMake(18, 2.5)];
        [path addArcWithCenter:CGPointMake(18, 2.5) radius:2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        [path moveToPoint:CGPointMake(20, 2.5)];
        [path addLineToPoint:CGPointMake(36, 2.5)];
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(36, 5), NO, 0);
        CGPathRef ref = path.CGPath;
        CGContextRef ctr = UIGraphicsGetCurrentContext();
        CGContextAddPath(ctr, ref);
        CGContextSetLineWidth(ctr, 1);
        CGContextSetStrokeColorWithColor(ctr, [data.colors[i] CGColor]);
//        CGContextSetFillColorWithColor(ctr, [UIColor clearColor].CGColor);
        CGContextStrokePath(ctr);
        UIImage *legendImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = data.titles[i];
        titleLabel.textColor = data.colors[i];
        titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(40, 0, titleLabel.bounds.size.width, titleLabel.bounds.size.height);
        UIView *legend = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40 + titleLabel.bounds.size.width, titleLabel.bounds.size.height)];
        [legend addSubview:titleLabel];
        UIImageView *legendImageView = [[UIImageView alloc] initWithImage:legendImage];
        legendImageView.frame = CGRectMake(0, 0, 36, titleLabel.bounds.size.height);
        legendImageView.contentMode = UIViewContentModeScaleAspectFit;
        [legend addSubview:legendImageView];
        [legengs addObject:legend];
    }
    return legengs;
}

/**
 隐藏折点信息
 */
- (void)hideInfo {
    _lblInfo.hidden = YES;
    _lblInfo.frame = CGRectMake(0, 0, 0, 0);

}
@end
