//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088821147052387"
//收款支付宝账号
#define SellerID  @"mabangwangluo@163.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"g0w6s8h17orr4s83plolptrzrettg654"

//商户私钥，自助生成k
#define PartnerPrivKey @"MIIEpAIBAAKCAQEAuvEx3/NKdIkmiEqlC4iXRskllnWqddAAi2RDqWaIIOGw2Kvwmi9DvhyFUrhu43uvMhUnZViq7EAVVMsvfRvfc7qaobcSVYA/UL7eolKAzekaSuyFa9o9rooX6jKGhzEdZNeTA5mZ0XUK4UlM0Co71n4UBRzPUvPzE9hbln2wuwNE3p0W2E3T2rcNP7OwgL7+EV/vnyx+g9osqO7oatDRGt9DyONi0BQfmQl0+evJCv70+3bjV7hXNWOavbu/wFMi2llKmDYd/0Z1LWKIwMZwciniN/fEZ6+jcEeJUNem/+7EpNDGN7WsucL2dIBwcHzPuoprCFA0UL0WTbd6tQLgywIDAQABAoIBAQCQ37zcJqpr16IR+28emhNKWzYS/UtGFBVn8SLylDAo817e+5jxlHF2UpoL+jyNdNvX/0bRpr6Haj5dwT0jQseP42xUqRC/TC1FQTY+K5wAd4bVy6i2ZaJpskFIUTGqcaiq7tnS72WiSodNAkZSCHjpCDoxoBsX2VBm78RCw1OECXYDlRKoAwEbmGnYqm/wrGUXd5WolbtWvZoph7MhK4vc5SDzTGAaWFF30rtn4h+W6591E9amyjeyI1KSLRzIUVy0/l1FOCKoGDVi9MbJeRpHLsubKgdQodnI+i0kiocxSQH3G12iTEDwOPxsaWLJn71Go78DgMFH9SZTJFfn8jXhAoGBAPaUh+iJs0sd1On1EWSKJqCx9hRjCsnqKld1SySMHfoDvZ2vDT7slg6Ph/Fs0d8nsE8DzRPEAkmGw1iOenvoZWUJLefQM6pFr3hYEwzVliKiWZ8wizt1gKX/KjJEA7JONSdHfPDdO/1t9Q1OqZeSHFszh58SnUEu5hc5UC6P8lvxAoGBAMIVbLJ82Le7aK5Aal/yuO/4XjEvGaBBMRdFe8+j2lO2qskTFKPP2kmryaBo5eDpH3KQ+kDAmibsR+VKmd3P8aCmsrxtkQg+/H1x4GDirQgLmRrphAVlkF1VHCjzk6+uYdlTR7j1CBTmOrX8MN0eIs5JOESGvpgjX//wrarF3/R7AoGBALqVhA3y/KfPiAgM+D9Cxp38a7/bfhNxzN5nFBgwqpI/+GB0UKqXraiQ9YY7GMgqqR/xOWJGhJCMmA7PqWFPZkJA4uqxwhaLKo7+3lNs33GPtg9eVU0FyfZSEeT9UGrBATmav7EnRziq1q5eIrhdyHU+ldZJ6JKlYVibds/0/qiRAoGALrXzVD3h9s5fElkkgPUs92xiVxoL49rs0roBY2b/G9jB3+T8ubRDyClVPIsikG/rBqrH4B+6uhVx9EhxIcZzVAPqzpjcKAzovdRTeV304RPRhH2hLZ9VEHF0dpKw/75LhH+bqnMmv8jtZnFM3Vrsa5OJvExlwL360+F8GrbHANMCgYAYTPQSXcQYDjWH1vL2Y5rqADOUp3zSUcTiNGrIK4YKJYGqhKWb9rGuwqzleFuPHA4hlso/hpeJizHNwrfYYl3bJWiZoExNPbM3PYcpzMQfG28fsJMPGfta2mJmLpA0mm2DzPiM9wg95F0TuoB1O/8jCDBqnMfoz/02+mxRx+Qoxw==";

//支付宝公钥
#define AlipayPubKey    @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuvEx3/NKdIkmiEqlC4iXRskllnWqddAAi2RDqWaIIOGw2Kvwmi9DvhyFUrhu43uvMhUnZViq7EAVVMsvfRvfc7qaobcSVYA/UL7eolKAzekaSuyFa9o9rooX6jKGhzEdZNeTA5mZ0XUK4UlM0Co71n4UBRzPUvPzE9hbln2wuwNE3p0W2E3T2rcNP7OwgL7+EV/vnyx+g9osqO7oatDRGt9DyONi0BQfmQl0+evJCv70+3bjV7hXNWOavbu/wFMi2llKmDYd/0Z1LWKIwMZwciniN/fEZ6+jcEeJUNem/+7EpNDGN7WsucL2dIBwcHzPuoprCFA0UL0WTbd6tQLgywIDAQAB"

#endif
