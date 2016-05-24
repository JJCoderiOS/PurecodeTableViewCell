//
//  Constants.h
//  ddtc
//
//  Created majianjie on 1/27/16.
//  Copyright (c) 2015 ddtc. All rights reserved.
//

#ifndef ddtc_Constants_h
#define ddtc_Constants_h
#define VERSION @"2.19.2"


#define NJNameFont [UIFont systemFontOfSize:13]

//小
#define Small_Font [UIFont systemFontOfSize:14]

// 屏幕尺寸
#define HMScreenW  [UIScreen mainScreen].bounds.size.width
#define HMScreenH [UIScreen mainScreen ].bounds.size.height

#define VIPW 14
#define VIPH VIPW

#define Color(r, g, b , a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define LayerColor(r, g, b , a) [[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a] CGColor]
#define LightGrayColor [UIColor lightGrayColor]

#define White [UIColor whiteColor]
#define Red [UIColor redColor]



#define NavHeight 64




#endif
