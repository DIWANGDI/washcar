//
//  AppDelegate.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import<MapKit/MapKit.h>
#import "UserLocationModel.h"
#import "JYJAnimateViewController.h"
#import "ValuePickerView.h"
#import "MycarListModel.h"
#import "WashCarController.h"
#import "JYJLoginController.h"
#import "JYWeiguiController.h"

#define FBStatusBarH ([UIApplication sharedApplication].statusBarFrame.size.height)
#define FBNavigationBarH (FBStatusBarH + 44)

@interface ViewController () 
/** tapGestureRec */
@property (nonatomic, weak) UITapGestureRecognizer *tapGestureRec;
/** panGestureRec */
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRec;
/** profileButton */
@property (nonatomic, weak) UIButton *profileButton;
/** hasClick */
@property (nonatomic, assign) BOOL hasClick;


@property(nonatomic,strong)BMKMapView         *mapView;

@property(nonatomic,strong)NSMutableArray        *locationArr;

@property(nonatomic,strong)BMKGeoCodeSearch         *searcher;
/** vc */
@property (nonatomic, strong) JYJAnimateViewController *vc;
@property (nonatomic, strong) BMKLocationService  *locService;
@property (nonatomic, strong) BMKPointAnnotation* lockedScreenAnnotation;
@property (nonatomic, strong) UILabel                  *carAddressLab;
@property (nonatomic, strong) UIButton                   *addBtn;
@property (nonatomic, strong) UIButton                   *addWeiguiBtn;
@property (nonatomic, strong) UIButton                  *current_location_Btn;
@property (nonatomic, assign) CLLocationCoordinate2D      locationCoordInate2D;
@property (nonatomic, assign)BOOL                       toWashCar;//去发布流程洗车
@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(UIButton *)addBtn
{
    if (!_addBtn)
    {
        _addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"洗车" forState:UIControlStateNormal];
        _addBtn.backgroundColor=wh_RGB(6, 74, 81);
        _addBtn.frame=CGRectMake(winsize.width/2-50, winsize.height-140, 100, 100);
        _addBtn.layer.cornerRadius=50;
        [_addBtn wh_addActionHandler:^(UIButton *sender)
        {
            self.toWashCar=YES;
            [self TableloadData];
        }];
    }
    return _addBtn;
}

-(UIButton *)addWeiguiBtn
{
    if (!_addWeiguiBtn)
    {
        _addWeiguiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_addWeiguiBtn setTitle:@"违规" forState:UIControlStateNormal];
        _addWeiguiBtn.backgroundColor=wh_RGB(6, 74, 81);
        _addWeiguiBtn.frame=CGRectMake(winsize.width/2+80, winsize.height-130, 80, 80);
        _addWeiguiBtn.layer.cornerRadius=40;
        [_addWeiguiBtn wh_addActionHandler:^(UIButton *sender)
         {
             self.toWashCar=NO;
             [self TableloadData];
         }];
    }
    return _addWeiguiBtn;
}

-(UILabel *)carAddressLab
{
    if (!_carAddressLab)
    {
        _carAddressLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 64, winsize.width, 40)];
        _carAddressLab.font=[UIFont systemFontOfSize:15];
        _carAddressLab.textColor=[UIColor darkGrayColor];
        _carAddressLab.backgroundColor=[UIColor whiteColor];
    }
    return _carAddressLab;
}

-(UIButton *)current_location_Btn
{
    if (!_current_location_Btn)
    {
        _current_location_Btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_current_location_Btn setImage:UIImageNamed(@"M_User_location") forState:UIControlStateNormal];
        _current_location_Btn.frame=CGRectMake(10, winsize.height-50, 40, 40);
        [_current_location_Btn wh_addActionHandler:^(UIButton *sender)
        {
            _mapView.userTrackingMode = BMKUserTrackingModeFollow;
            _mapView.showsUserLocation = YES;
        }];
    }
    return _current_location_Btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitleLab.text=@"马帮洗车";
    [self.navLetfItem setImage:UIImageNamed(@"PH_UserPhoto") forState:UIControlStateNormal];

    if ([[OWTool Instance] getLoginUserInform].count>0)
    {
        NSDictionary *userInformDic=[[OWTool Instance] getLoginUserInform];
        //本地有数据则自动登录
        NSMutableDictionary *parms=[@{
                                      @"U_Tel":configEmpty(userInformDic[@"U_Tel"]),
                                      @"U_IMEI":configEmpty(userInformDic[@"U_IMEI"])
                                      }mutableCopy];
        [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkLoginByIMEI withUserInfo:parms success:^(NSDictionary *message,NSString *errorMsg,NSString *okStr)
         {
             if (errorMsg.length>0)
             {
                 [SVProgressHUD showErrorWithStatus:errorMsg];
             }
             else
             {
                 [[OWTool Instance] saveLoginUserInform:message];
                 [self.navLetfItem setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kNewWordBaseURLString,message[@"U_Image"]]]]] forState:UIControlStateNormal];
                 self.navLetfItem.layer.cornerRadius=20;
                 self.navLetfItem.layer.masksToBounds=YES;
                 [OWTool Instance].isLogin=YES;
                 //获取平台信息
                 [self getPingtaiMethod];
                 //获取我的爱车
                 [self getAicarList];
             }
        } failure:^(NSError *error) {
            
        } visibleHUD:NO];
    }
    [OWTool Instance].wasnFinishedToPhone=YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 这个方法是为了，不让隐藏状态栏的时候出现view上移
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 屏幕边缘pan手势(优先级高于其他手势)
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                                          action:@selector(moveViewWithGesture:)];
    leftEdgeGesture.edges = UIRectEdgeLeft;// 屏幕左侧边缘响应
    [self.view addGestureRecognizer:leftEdgeGesture];
    // 这里是地图处理方式，遵守代理协议，实现代理方法
    leftEdgeGesture.delegate = self;
 
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 100, winsize.width, winsize.height-64)];
    [self.view addSubview:self.mapView];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation=YES;
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showMapScaleBar = YES;
    [_mapView setZoomLevel:18];
    
    //自定义比例尺的位置
    _mapView.mapScaleBarPosition = CGPointMake(_mapView.frame.size.width - 70, _mapView.frame.size.height - 68);
    _locService = [[BMKLocationService alloc]init];
    _locService.userLocation.title=@"我";
    _locService.delegate = self;
    //启动LocationService
    self.searcher =[[BMKGeoCodeSearch alloc]init];
    [_locService startUserLocationService];
    
    [self.view addSubview:self.addBtn];
    [self.view addSubview:self.addWeiguiBtn];
    [self.view bringSubviewToFront:self.addBtn];
    [self.view addSubview:self.current_location_Btn];
    [self.view addSubview:self.carAddressLab];
    //定位我的车辆
    self.lockedScreenAnnotation = [[BMKPointAnnotation alloc]init];
    self.lockedScreenAnnotation.isLockedToScreen = YES;
    self.lockedScreenAnnotation.screenPointToLock = CGPointMake(200, 150);
    self.lockedScreenAnnotation.title = @"爱车定位";
    [_mapView addAnnotation:self.lockedScreenAnnotation];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MKCoordinateRegion region;
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    region.center= centerCoordinate;
    
    NSLog(@" regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
    
    
    CGPoint touchPoint = CGPointMake(200, 150);//这里touchPoint是点击的某点在地图控件中的位置
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];//这里touchMapCoordinate就是该点的经纬度了
    self.locationCoordInate2D=touchMapCoordinate;
    NSLog(@"touching %f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
    
    /// geo检索信息类,获取当前城市数据
    BMKReverseGeoCodeOption *reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoCodeOption.reverseGeoPoint = touchMapCoordinate;
    BOOL flag = [self.searcher reverseGeoCode:reverseGeoCodeOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

-(void)getCurrentLocation:(CGFloat)lat andLong:(CGFloat)log
{
//   发起反向地理编码检索
    self.searcher =[[BMKGeoCodeSearch alloc]init];
    self.searcher.delegate = self;
   CLLocationCoordinate2D pt = (CLLocationCoordinate2D){lat, log};
   BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
   reverseGeoCodeSearchOption.reverseGeoPoint = pt;
   BOOL flag = [self.searcher reverseGeoCode:reverseGeoCodeSearchOption];
   if(flag)
   {
     NSLog(@"反geo检索发送成功");
   }
   else
   {
     NSLog(@"反geo检索发送失败");
   }
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      NSLog(@" 在此处理正常结果-");
      NSLog(@"--%@",result.address);
      self.carAddressLab.text=[NSString stringWithFormat:@"车辆位置： %@",result.address];
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}


-(void)getLocation
{
    NSMutableDictionary *parms=[@{
                                  @"Lng":@(self.locationCoordInate2D.longitude),
                                  @"Lat":@(self.locationCoordInate2D.latitude)
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkgetxichegongLocation withUserInfo:parms success:^(NSArray *message,NSString *errorMsg,NSString *okStr)
    {
        if (errorMsg.length>0)
        {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        else
        {
            
            NSArray    *locatioinArr=[UserLocationModel mj_objectArrayWithKeyValuesArray:message];
            [self.locationArr addObjectsFromArray:locatioinArr];
    
            for (UserLocationModel *model in self.locationArr)
            {
                BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
                CLLocationCoordinate2D coor;
                coor.latitude = model.W_Lat.floatValue;
                coor.longitude = model.W_Lng.floatValue;
                annotation.coordinate = coor;
                annotation.title=@"洗车工";
                [self.mapView addAnnotation:annotation];
            }
        }
    } failure:^(NSError *error)
    {
        
    } visibleHUD:NO];
}

//上面方法，从服务器获得经纬度，然后执行此delegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            if (annotation == _lockedScreenAnnotation) {
                // 设置颜色
                annotationView.pinColor = BMKPinAnnotationColorRed;
                // 设置可拖拽
                annotationView.draggable = NO;
            } else {
                // 设置可拖拽
                annotationView.pinColor=BMKPinAnnotationColorPurple;
                
                annotationView.draggable = YES;
            }
            // 从天上掉下效果
            annotationView.animatesDrop = NO;
        }
        return annotationView;
    }
    return nil;
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
    [self.mapView updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [self.mapView updateLocationData:userLocation];
    BMKLocationViewDisplayParam *parm=[[BMKLocationViewDisplayParam alloc] init];
    parm.isRotateAngleValid=YES;
    parm.locationViewImgName=@"pin_red";
    parm.locationViewOffsetY=0;
    [self.mapView updateLocationViewWithParam:parm];
    
    static BOOL is_First_Get_Lication=YES;
    if (is_First_Get_Lication)
    {
        [self getCurrentLocation:userLocation.location.coordinate.latitude andLong:userLocation.location.coordinate.longitude];
        self.locationCoordInate2D=userLocation.location.coordinate;
        is_First_Get_Lication=NO;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
        {
            [self getLocation];
        });
    }
}

-(NSMutableArray *)locationArr
{
    if (!_locationArr)
    {
        _locationArr=[NSMutableArray array];
    }
    return _locationArr;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL result = NO;
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        result = YES;
    }
    return result;
}

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes {
    if (panGes.state == UIGestureRecognizerStateEnded) {
        if ([self.childViewControllers containsObject:self.vc]) return;
        [self profileCenter];
    }
}

- (void)profileCenter {
    // 防止重复点击
    if (self.hasClick) return;
    self.hasClick = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hasClick = NO;
    });
    // 展示个人中心
    JYJAnimateViewController *vc = [[JYJAnimateViewController alloc] init];
    self.vc = vc;
    vc.view.backgroundColor = [UIColor clearColor];
    vc.publishOrderBlock = ^{
        self.toWashCar=YES;
        [self TableloadData];
    };
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}

-(void)leftItemBtnAction
{
    [self profileCenter];
}

-(void)TableloadData
{
    if (![[OWTool Instance] isLogin])
    {
        JYJLoginController *logVc=[[JYJLoginController alloc] init];
        [self.navigationController pushViewController:logVc animated:YES];
        return;
    }
    NSMutableArray *carList=[[OWTool Instance] getUserCarList];
    NSArray    *carListModel=[MycarListModel mj_objectArrayWithKeyValuesArray:carList];
    
    NSMutableArray *dataSourceArr=[NSMutableArray array];
    for (MycarListModel *models in carListModel)
    {
        [dataSourceArr  addObject:models.C_PlateNumber];
    }
    ValuePickerView *picker=[[ValuePickerView alloc] init];
    picker.dataSource=dataSourceArr;
    picker.pickerTitle=@"爱车选择";
    picker.valueDidSelect=^(NSString *value,NSInteger index)
    {
        if (self.toWashCar)
        {
            WashCarController *carVc=[[WashCarController alloc] init];
            if (self.carAddressLab.text.length>0)
            {
                carVc.addressStr=[self.carAddressLab.text componentsSeparatedByString:@"： "][1];
            }
            carVc.O_Lng=self.locationCoordInate2D.longitude;
            carVc.O_Lat=self.locationCoordInate2D.latitude;
            carVc.model=(MycarListModel *)carListModel[index];
            [self.navigationController pushViewController:carVc animated:YES];
        }
        else
        {
            MycarListModel *wjModel=(MycarListModel *)carListModel[index];
            JYWeiguiController *wzVc=[[JYWeiguiController alloc] init];
            wzVc.model=wjModel;
            [self.navigationController pushViewController:wzVc animated:YES];
        }
    };
    [picker show];
}


-(void)getPingtaiMethod
{
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkgetPingtaiInform withUserInfo:nil success:^(NSDictionary *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             [SVProgressHUD dismiss];
             [[OWTool Instance] savePingtaiInform:message];
             [self.navigationController popViewControllerAnimated:YES];
         }
     } failure:^(NSError *error)
     {
         
     } visibleHUD:NO];
}

-(void)getAicarList
{
    NSMutableDictionary *parms=[@{
                                  @"C_UTel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"])
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkMyCarlist withUserInfo:parms success:^(NSArray *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             [[OWTool Instance] saveUsercarList:message];
         }
     } failure:^(NSError *error) {
         
     } visibleHUD:NO];
}

@end
