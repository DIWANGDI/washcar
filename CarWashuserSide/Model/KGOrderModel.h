//
//  KGOrderModel.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGOrderModel : NSObject

@property(nonatomic,copy)NSString                   *O_IDS;
@property(nonatomic,copy)NSString                   *O_ID;                         
@property(nonatomic,copy)NSString                   *O_UTel;                       
@property(nonatomic,copy)NSString                   *O_CarTel;                     
@property(nonatomic,copy)NSString                   *O_CarName;                    
@property(nonatomic,copy)NSString                   *O_PlateNumber;                
@property(nonatomic,copy)NSString                   *O_CarImage;                   
@property(nonatomic,copy)NSString                   *O_CarColor;                   
@property(nonatomic,copy)NSString                   *O_WPart;                      
@property(nonatomic,copy)NSString                   *O_CTID;                       

@property(nonatomic,copy)NSString                   *O_TypeID;                     
@property(nonatomic,copy)NSString                   *O_Price;                      
@property(nonatomic,copy)NSString                   *O_WriteAdress;                
@property(nonatomic,copy)NSString                   *O_Adress;                     
@property(nonatomic,copy)NSString                   *O_Lng;                        
@property(nonatomic,copy)NSString                   *O_Lat;
@property(nonatomic,copy)NSString                   *O_Time;                   
@property(nonatomic,copy)NSString                   *O_StartTime;              
@property(nonatomic,copy)NSString                   *O_TimeEnd;                
@property(nonatomic,copy)NSString                   *O_IsPhone;                

@property(nonatomic,copy)NSString                   *O_EvaluateStar;           
@property(nonatomic,copy)NSString                   *O_EvaluateType;           
@property(nonatomic,copy)NSString                   *O_EvaluateImage;          
@property(nonatomic,copy)NSString                   *O_EvaluateAnonymous;      
@property(nonatomic,copy)NSString                   *O_EvaluateReward;         
@property(nonatomic,copy)NSString                   *O_Evaluate;               
@property(nonatomic,copy)NSString                   *O_IsEvaluate;             
@property(nonatomic,copy)NSString                   *O_Money;                  
@property(nonatomic,copy)NSString                   *O_TID;                    
@property(nonatomic,copy)NSString                   *O_Ticket;                 

@property(nonatomic,copy)NSString                   *O_TType;                  
@property(nonatomic,copy)NSString                   *O_TMoney;                 
@property(nonatomic,copy)NSString                   *O_TTime;                  
@property(nonatomic,copy)NSString                   *O_ISCancel;               
@property(nonatomic,copy)NSString                   *O_ISCancelValue;          
@property(nonatomic,copy)NSString                   *O_ISRefund;               
@property(nonatomic,copy)NSString                   *O_RefundMoney;
@property(nonatomic,copy)NSString                   *O_WorkerID;
@property(nonatomic,copy)NSString                   *O_WorkerImage;
@property(nonatomic,copy)NSString                   *O_WorkerName;

@property(nonatomic,copy)NSString                   *O_WorkerTel;
@property(nonatomic,copy)NSString                   *O_Province;
@property(nonatomic,copy)NSString                   *O_City;
@property(nonatomic,copy)NSString                   *O_County;
@property(nonatomic,copy)NSString                   *O_WType;
@property(nonatomic,copy)NSString                   *O_BeforePic;
@property(nonatomic,copy)NSString                   *O_AfterPic;
@property(nonatomic,copy)NSString                   *O_WashTime;
@property(nonatomic,copy)NSString                   *O_WashType;
@property(nonatomic,copy)NSString                   *O_BrandName;

@property(nonatomic,copy)NSString                   *O_BrandTypeName;
@property(nonatomic,copy)NSString                   *O_Scratch;
@property(nonatomic,copy)NSString                   *O_ScratchImage1;
@property(nonatomic,copy)NSString                   *O_ScratchImage2;
@property(nonatomic,copy)NSString                   *O_ScratchImage3;
@property(nonatomic,copy)NSString                   *O_ScratchImage4;
@property(nonatomic,copy)NSString                   *O_ScratchImage5;
@property(nonatomic,copy)NSString                   *O_ScratchImage6;
@property(nonatomic,copy)NSString                   *O_Remark;

@end
