//
//  VMSNetSDK.h
//  VMSNetSDK
//
//  Created by Dengsh on 13-8-1.
//  Copyright (c) 2013年 hikvision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VMSNetSDKDataType.h"

@interface VMSNetSDK : NSObject
{
    enum
    {
        eVersion_3_0 = 0,   // V3.0系列
        eVersion_4_0 = 1,   // V4.0系列
    };
    
    NSString *_strUserID;
    NSString *_strServerAddress;
    NSString *_strSession;
    int      _version;                                                          // 当前版本
    int      _nLastError;                                                       // 错误码
    NSString *_strLastErrorDescribe;                                            // 错误描述
    NSString *_strPlayToken;                                                    // 播放Token
    int      _totalNumOfDeviceGPS;
    int      _currentNumOfDeviceGPS;
}

@property (copy,   nonatomic) NSString *strUserID;
@property (copy,   nonatomic) NSString *strServerAddress;
@property (copy,   nonatomic) NSString *strSession;
@property (assign, nonatomic) int      version;
@property (assign, nonatomic) int      nLastError;
@property (retain, nonatomic) NSString *strLastErrorDescribe;
@property (copy,   nonatomic) NSString *strPlayToken;
@property (assign, nonatomic) int      totalNumOfDeviceGPS;
@property (assign, nonatomic) int      currentNumOfDeviceGPS;

/**
 *	@brief	获取VMSNetSDK单例
 *
 *	@return	VMSNetSDK单例
 */
+ (VMSNetSDK *)shareInstance;

/**
 *  获取服务器信息
 *
 *  @param servAddr          [IN]服务器地址
 *  @param serverVersionInfo [OUT]服务器信息
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getServerVersion:(NSString *)servAddr
         toServerVersion:(CServerVersionInfo *)serverVersionInfo;

/**
 *  获取通信线路
 *
 *  @param servAddr     [IN]服务器地址
 *  @param lineInfoList [OUT]通信线路列表
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getLineList:(NSString *)servAddr
     toLineInfoList:(NSMutableArray *)lineInfoList;

/**
 *  登录MSP服务器
 *
 *  @param servAddr [IN]服务器地址
 *  @param userName [IN]用户名
 *  @param password [IN]密码
 *  @param lineID   [IN]线路ID
 *  @param mspInfo  [OUT]MSP服务器信息
 *
 *  @return YES - 登录成功 NO - 登录失败
 */
- (BOOL)login:(NSString *)servAddr
   toUserName:(NSString *)userName
   toPassword:(NSString *)password
     toLineID:(int)lineID
   toServInfo:(CMSPInfo *)mspInfo;

/**
 *  登录MSP服务器
 *
 *  @param servAddr [IN]服务器地址
 *  @param userName [IN]用户名
 *  @param password [IN]密码
 *  @param mspInfo  [OUT]MSP服务器信息
 *
 *  @return YES - 登录成功 NO - 登录失败
 */
- (BOOL)loginV40:(NSString *)servAddr
      toUserName:(NSString *)userName
      toPassword:(NSString *)password
      toServInfo:(CMSPInfo *)mspInfo;

/**
 *  注销MSP服务器
 *
 *  @param servAddr  [IN]服务器地址
 *  @param sessionID [IN]会话ID
 *  @param tokenID   [IN]注册标识ID(若没有注册推送服务器，可以为空)
 *
 *  @return YES - 注销成功 NO - 注销失败
 */
- (BOOL)logout:(NSString *)servAddr
   toSessionID:(NSString *)sessionID
     toTokenID:(NSString *)tokenID;

/**
 *  获取指定控制中心下的控制中心列表
 *
 *  @param servAddr        [IN]服务器地址
 *  @param sessionID       [IN]会话ID
 *  @param controlUnitID   [IN]父控制中心id 如果为根控制中心，则为0
 *  @param numPerPage      [IN]分页获取，每页获取的个数
 *  @param curPage         [IN]当前页数
 *  @param controlUnitList [OUT]获取的控制中心列表
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getControlUnitList:(NSString *)servAddr
               toSessionID:(NSString *)sessionID
           toControlUnitID:(int)controlUnitID
              toNumPerOnce:(int)numPerPage
                 toCurPage:(int)curPage
         toControlUnitList:(NSMutableArray *)controlUnitList;

/**
 *  获取指定控制中心下的区域列表
 *
 *  @param servAddr      [IN]服务器地址
 *  @param sessionID     [IN]会话ID
 *  @param controlUnitID [IN]父控制中心ID
 *  @param numPerPage    [IN]分页获取，每页获取的个数
 *  @param curPage       [IN]当前页数
 *  @param regionList    [OUT]获取的区域列表
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getRegionListFromCtrlUnit:(NSString *)servAddr
                      toSessionID:(NSString *)sessionID
                  toControlUnitID:(int)controlUnitID
                     toNumPerOnce:(int)numPerPage
                        toCurPage:(int)curPage
                     toRegionList:(NSMutableArray *)regionList;

/**
 *  获取指定区域下的区域列表
 *
 *  @param servAddr   [IN]服务器地址
 *  @param sessionID  [IN]会话ID
 *  @param regionID   [IN]父区域ID
 *  @param numPerPage [IN]分页获取，每页获取的个数
 *  @param curPage    [IN]当前页数
 *  @param regionList [OUT]获取的区域列表
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getRegionListFromRegion:(NSString *)servAddr
                    toSessionID:(NSString *)sessionID
                     toRegionID:(int)regionID
                   toNumPerOnce:(int)numPerPage
                      toCurPage:(int)curPage
                   toRegionList:(NSMutableArray *)regionList;

/**
 *  获取指定控制中心下的监控点列表
 *
 *  @param servAddr      [IN]服务器地址
 *  @param sessionID     [IN]会话ID
 *  @param controlUnitID [IN]父控制中心ID
 *  @param numPerPage    [IN]分页获取，每页获取的个数
 *  @param curPage       [IN]当前页数
 *  @param cameraList    [OUT]获取的监控点列表
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getCameraListFromCtrlUnit:(NSString *)servAddr
                      toSessionID:(NSString *)sessionID
                  toControlUnitID:(int)controlUnitID
                     toNumPerOnce:(int)numPerPage
                        toCurPage:(int)curPage
                     toCameraList:(NSMutableArray *)cameraList;

/**
 *  获取指定区域下的监控点列表
 *
 *  @param servAddr   [IN]服务器地址
 *  @param sessionID  [IN]会话ID
 *  @param regionID   [IN]父区域ID
 *  @param numPerPage [IN]分页获取，每页获取的个数
 *  @param curPage    [IN]当前页数
 *  @param cameraList [OUT]获取的监控点列表
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getCameraListFromRegion:(NSString *)servAddr
                    toSessionID:(NSString *)sessionID
                     toRegionID:(int)regionID
                   toNumPerOnce:(int)numPerPage
                      toCurPage:(int)curPage
                   toCameraList:(NSMutableArray *)cameraList;

/**
 *  获取设备信息
 *
 *  @param servAddr   [IN]服务器地址
 *  @param sessionID  [IN]会话ID
 *  @param deviceID   [IN]设备ID
 *  @param deviceInfo [OUT]设备信息
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getDeviceInfo:(NSString *)servAddr
          toSessionID:(NSString *)sessionID
           toDeviceID:(NSString *)deviceID
         toDeviceInfo:(CDeviceInfo *)deviceInfo;

/**
 *  获取设备GPS轨迹信息(针对移动设备,如车载、单兵)
 *
 *  @param servAddr         [IN]服务器地址
 *  @param sessionID        [IN]会话ID
 *  @param indexCode        [IN]设备编号
 *  @param startTime        [IN]起始时间
 *  @param endTime          [IN]结束时间
 *  @param GPSTraceInfoList [OUT]GPS轨迹信息列表
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getDeviceGPSTraceInfo:(NSString *)servAddr
                  toSessionID:(NSString *)sessionID
                  toIndexCode:(NSString *)indexCode
                  toStartTime:(ABSTIME *)startTime
                    toEndTime:(ABSTIME *)endTime
           toGPSTraceInfoList:(NSMutableArray *)GPSTraceInfoList;

/**
 *  获取监控点播放地址
 *
 *  @param servAddr    [IN]服务器地址
 *  @param sessionID   [IN]会话ID
 *  @param cameraID    [IN]监控点ID
 *  @param realPlayURL [OUT]监控点播放地址
 *  @param streamType  [IN]流类型
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getRealPlayURL:(NSString *)servAddr
           toSessionID:(NSString *)sessionID
            toCameraID:(NSString *)cameraID
         toRealPlayURL:(CRealPlayURL *)realPlayURL
          toStreamType:(int)streamType;

/**
 *  获取播放token
 *
 *  @return
 */
- (BOOL)getPlayToken;

/**
 *  发送云台开始命令
 *
 *  @param servAddr  [IN]服务器地址
 *  @param port      [IN]服务器端口
 *  @param sessionID [IN]会话ID
 *  @param cameraID  [IN]监控点ID
 *  @param cmdID     [IN]云台命令 见VMSNetSDKDataType.h 云台控制命令宏
 *  @param param1    [IN]云台参数1：云台转动时转动速度（1-10）或者 预置点操作时预置点编号 或者 3d放大时起始点x坐标
 *  @param param2    [IN]云台参数2：3d放大时起始点y坐标
 *  @param param3    [IN]云台参数3：3d放大时终止点x坐标
 *  @param param4    [IN]云台参数4：3d放大时终止点y坐标
 *
 *  @return YES - 发送成功 NO - 发送失败
 */
- (BOOL)sendStartPTZCmd:(NSString *)servAddr
                 toPort:(int)port
            toSessionID:(NSString *)sessionID
             toCameraID:(NSString *)cameraID
                toCmdID:(int)cmdID
               toParam1:(int)param1
               toParam2:(int)param2
               toParam3:(int)param3
               toParam4:(int)param4;

/**
 *  发送云台停止命令
 *
 *  @param servAddr  [IN]服务器地址
 *  @param port      [IN]服务器端口
 *  @param sessionID [IN]会话ID
 *  @param cameraID  [IN]监控点ID
 *
 *  @return YES - 发送成功 NO - 发送失败
 */
- (BOOL)sendStopPTZCmd:(NSString *)servAddr
                toPort:(int)port
           toSessionID:(NSString *)sessionID
            toCameraID:(NSString *)cameraID;

/**
 *  查询录像
 *
 *  @param servAddr   [IN]服务器地址
 *  @param sessionID  [IN]会话ID
 *  @param cameraID   [IN]监控点ID
 *  @param recordType [IN]录像类型：1－计划录像 2－移动录像 16－手动录像 4－报警录像 拼接完的RecordType (用逗号隔开)
 *  @param recordPos  [IN]录像存储位置：0－IPSAN 1－设备录像 2－PCNVR 3-ENVR 4-CISCO 5-DSNVR 7-CVR 目前只提供单条件查询
 *  @param startTime  [IN]录像开始时间
 *  @param endTime    [IN]录像结束时间
 *  @param recordInfo [OUT]查询到的录像信息
 *
 *  @return YES - 查询成功 NO - 查询失败
 */
- (BOOL)queryCameraRecord:(NSString *)servAddr
              toSessionID:(NSString *)sessionID
               toCameraID:(NSString *)cameraID
             toRecordType:(NSString *)recordType
              toRecordPos:(NSString *)recordPos
              toStartTime:(ABSTIME *)startTime
                toEndTime:(ABSTIME *)endTime
             toRecordInfo:(CRecordInfo *)recordInfo;

/**
 *  收藏监控点
 *
 *  @param servAddr  [IN]服务器地址
 *  @param sessionID [IN]会话ID
 *  @param cameraID  [IN]监控点ID
 *  @param groupID   [IN]分组ID 目前都为1
 *
 *  @return YES - 收藏成功 NO - 收藏失败
 */
- (BOOL)collectCamera:(NSString *)servAddr
          toSessionID:(NSString *)sessionID
           toCameraID:(NSString *)cameraID
            toGroupID:(int)groupID;

/**
 *  取消收藏监控点
 *
 *  @param servAddr  [IN]服务器地址
 *  @param sessionID [IN]会话ID
 *  @param cameraID  [IN]监控点ID
 *  @param groupID   [IN]分组ID 目前都为1
 *
 *  @return YES - 取消收藏成功 NO - 取消收藏失败
 */
- (BOOL)discollectCamera:(NSString *)servAddr
             toSessionID:(NSString *)sessionID
              toCameraID:(NSString *)cameraID
               toGroupID:(int)groupID;

/**
 *  获取收藏列表
 *
 *  @param servAddr   [IN]服务器地址
 *  @param sessionID  [IN]会话ID
 *  @param numPerPage [IN]分页获取，每页获取的个数
 *  @param curPage    [IN]当前页数
 *  @param cameraList [OUT]被收藏的监控点列表
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getCollectedCamera:(NSString *)servAddr
               toSessionID:(NSString *)sessionID
              toNumPerOnce:(int)numPerPage
                 toCurPage:(int)curPage
              toCameraList:(NSMutableArray *)cameraList;

/**
 *  获取监控点详细信息
 *
 *  @param servAddr         [IN]服务器地址
 *  @param sessionID        [IN]会话ID
 *  @param cameraID         [IN]监控点ID
 *  @param cameraDetailInfo [OUT]监控点详细信息
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getCameraDetailInfo:(NSString *)servAddr
                toSessionID:(NSString *)sessionID
                 toCameraID:(NSString *)cameraID
         toCameraDetailInfo:(CCameraInfo *)cameraDetailInfo;

/**
 *  MSP包活接口，适用于V4.0系列
 *
 *  @return YES - 成功  NO - 失败
 */
- (BOOL)keepliveV40;

/**
 *  修改用户密码，适用于V4.0系列
 *
 *  @param oldPwd 老密码
 *  @param newPwd 新密码
 *
 *  @return YES - 成功  NO - 失败
 */
- (BOOL)modifyPasswordV40:(NSString *)oldPwd newPassword:(NSString *)newPwd;

#pragma mark - GIS Methods

/**
 *  分页获取带GIS信息的监控点
 *
 *  @param servAddr          [IN]服务器地址
 *  @param sessionID         [IN]会话ID
 *  @param numPerPage        [IN]分页获取，每页获取的个数
 *  @param curPage           [IN]当前页数
 *  @param gisCameraInfoList [OUT]带GIS信息的监控点列表
 *
 *  @return YES - 获取成功 NO - 获取失败
 */
- (BOOL)getGISCamera:(NSString *)servAddr
         toSessionID:(NSString *)sessionID
        toNumPerOnce:(int)numPerPage
           toCurPage:(int)curPage
 toGISCameraInfoList:(NSMutableArray *)gisCameraInfoList;

/**
 *  根据圆形范围、名称关键字、GIS标记点类型，查询GIS标记点信息
 *
 *  @param numPerPage       [IN]每页获取的个数
 *  @param curPage          [IN]当前页数
 *  @param cenLon           [IN]圆形中心点经度
 *  @param cenLat           [IN]圆形中心点纬度
 *  @param radius           [IN]圆形半径
 *  @param keyString        [IN]名称相关的关键字
 *  @param pointTypes       [IN]标记点类型，详见GisPointType
 *  @param gisPointInfoList [OUT]带Gis信息的标记点列表
 *
 *  @return YES - 成功  NO - 失败
 */
- (BOOL)queryGisCameraByCircelV40:(int)numPerPage
                        toCurPage:(int)curPage
                      toCenterLon:(double)cenLon
                      toCenterLat:(double)cenLat
                          toRaius:(int)radius
                      toKeyString:(NSString *)keyString
                      toPointType:(NSUInteger)pointTypes
               toGisPointInfoList:(NSMutableArray *)gisPointInfoList;

/**
 *  根据矩形范围、名称关键字、GIS标记点类型，查询GIS标记点信息
 *
 *  @param numPerPage       [IN]每页获取的个数
 *  @param curPage          [IN]当前页数
 *  @param xmin             [IN]最小经度
 *  @param ymin             [IN]最小纬度
 *  @param xmax             [IN]最大经度
 *  @param ymax             [IN]最大纬度
 *  @param keyString        [IN]名称相关的关键字
 *  @param pointTypes       [IN]标记点类型，详见GisPointType
 *  @param gisPointInfoList [OUT]带Gis信息的标记点列表
 *
 *  @return YES - 成功  NO - 失败
 */
- (BOOL)queryGisCameraByRectV40:(int)numPerPage
                      toCurPage:(int)curPage
                         toXmin:(double)xmin
                         toYmin:(double)ymin
                         toXmax:(double)xmax
                         toYmax:(double)ymax
                    toKeyString:(NSString *)keyString
                    toPointType:(NSUInteger)pointTypes
             toGisPointInfoList:(NSMutableArray *)gisPointInfoList;

/**
 *  根据名称关键字、GIS标记点类型，查询GIS标记点信息
 *
 *  @param numPerPage        [IN]每页获取的个数
 *  @param curPage           [IN]当前页数
 *  @param keyString         [IN]名称相关的关键字
 *  @param pointTypes        [IN]标记点类型，详见GisPointType
 *  @param gisPointInfoList  [OUT]带Gis信息的标记点列表
 *
 *  @return YES - 成功  NO - 失败
 */
- (BOOL)queryGisCameraByNameV40:(int)numPerPage
                      toCurPage:(int)curPage
                    toKeyString:(NSString *)keyString
                    toPointType:(NSUInteger)pointTypes
             toGisPointInfoList:(NSMutableArray *)gisPointInfoList;

/**
 *  根据监控点ID，查询对应的GIS标记点信息
 *
 *  @param cameraID     [IN]监控点ID
 *  @param gisPointInfo [OUT]GIS标记点信息
 *
 *  @return YES - 成功  NO - 失败
 */
- (BOOL)queryGisCameraByCameraIDV40:(NSString *)cameraID
                     toGisPointInfo:(CGISCameraInfo *)gisPointInfo;

/**
 *  根据名称关键字、矩形范围、GIS标记点类型，热点查询GIS标记点
 *
 *  @param pointTypes       [IN]标记点类型，详见GisPointType
 *  @param xmin             [IN]当前地图可见范围，最小经度
 *  @param ymin             [IN]当前地图可见范围，最小纬度
 *  @param xmax             [IN]当前地图可见范围，最大经度
 *  @param ymax             [IN]当前地图可见范围，最大纬度
 *  @param originX          [IN]地图源点经度坐标
 *  @param originY          [IN]地图源点纬度坐标
 *  @param level            [IN]当前地图层级
 *  @param resolution       [IN]当前地图分辨率
 *  @param tileSize         [IN]块大小
 *  @param gisPointInfoList [OUT]带Gis信息的标记点列表
 *  @param clusterInfoList  [OUT]带Gis聚合信息的标记点列表
 *
 *  @return YES - 成功  NO - 失败
 */
- (BOOL)queryTitleV40:(NSUInteger)pointTypes
               toXmin:(double)xmin
               toYmin:(double)ymin
               toXmax:(double)xmax
               toYmax:(double)ymax
            toOriginX:(double)originX
            toOriginY:(double)originY
              toLevel:(int)level
         toResolution:(double)resolution
           toTileSize:(int)tileSize
   toGisPointInfoList:(NSMutableArray *)gisPointInfoList
    toClusterInfoList:(NSMutableArray *)clusterInfoList;

/**
 *  矫正监控点地理位置信息
 *
 *  @param servAddr  [IN]服务器地址
 *  @param sessionID [IN]会话ID
 *  @param cameraID  [IN]监控点ID
 *  @param longitude [IN]经度
 *  @param latitude  [IN]纬度
 *
 *  @return YES - 矫正成功 NO - 矫正失败
 */
- (BOOL)modifyGisInfo:(NSString *)servAddr
          toSessionID:(NSString *)sessionID
           toCameraID:(NSString *)cameraID
          toLongitude:(double)longitude
           toLatitude:(double)latitude;

/**
 *  获取GIS地图初始化信息
 *
 *  @param servAddr    [IN]服务器地址
 *  @param sessionID   [IN]会话ID
 *  @param gisInitInfo [OUT]GIS地图初始化信息
 *
 *  @return YES - 获取成功 NO － 获取失败
 */
- (BOOL)getGISInitInfo:(NSString *)servAddr
           toSessionID:(NSString *)sessionID
         toGisInitInfo:(CGisInitInfo *)gisInitInfo;

#pragma mark - MSP中消息部分接口

/**
 *  上报注册推送服务器信息
 *
 *  @param servAddr  [IN]服务器地址
 *  @param sessionID [IN]会话ID
 *  @param tokenID   [IN]注册标识
 *
 *  @return YES - 上报成功 NO - 上报失败
 */
- (BOOL)pushServerInfo:(NSString *)servAddr
           toSessionID:(NSString *)sessionID
             toTokenID:(NSString *)tokenID;

/**
 *  注册MAG，试用于V4.0.0
 *
 *  @param tokenID 苹果返回的推送Token
 *
 *  @return YES - 注册成功 NO - 注册失败
 */
- (BOOL)registerMagV40:(NSString *)tokenID;

/**
 *  注销MAG，试用于V4.0.0
 *
 *  @return YES - 注销成功 NO - 注销失败
 */
- (BOOL)unregisterMagV40;

/**
 *  获取未读消息数
 *
 *  @param servAddr           [IN]服务器地址
 *  @param sessionID          [IN]会话ID
 *  @param unreadMsgCountInfo [OUT]未读消息数信息
 *
 *  @return YES - 获取未读消息数成功 NO - 获取未读消息数失败
 */
- (BOOL)getUnreadMsgCount:(NSString *)servAddr
              toSessionID:(NSString *)sessionID
     toUnreadMsgCountInfo:(CUnreadMsgCountInfo *)unreadMsgCountInfo;

/**
 *  获取最新的消息列表
 *
 *  @param servAddr  [IN]服务器ID
 *  @param sessionID [IN]会话ID
 *  @param msgNumber [IN]消息数目
 *  @param msgList   [OUT]消息列表
 *
 *  @return YES - 获取最新消息列表成功 NO - 获取最新消息列表失败
 */
- (BOOL)getMsgList:(NSString *)servAddr
       toSessionID:(NSString *)sessionID
       toMsgNumber:(int)msgNumber
         toMsgList:(NSMutableArray *)msgList;

/**
 *  获取历史消息列表
 *
 *  @param servAddr  [IN]服务器ID
 *  @param sessionID [IN]会话ID
 *  @param msgID     [IN]消息ID
 *  @param msgType   [IN]消息类型
 *  @param msgNumber [IN]消息数
 *  @param msgList   [OUT]消息列表
 *
 *  @return YES - 获取成功  NO - 获取失败
 */
- (BOOL)getMsgHistoryList:(NSString *)servAddr
              toSessionID:(NSString *)sessionID
                  toMsgID:(NSString *)msgID
                toMsgType:(MessageType)msgType
              toMsgNumber:(int)msgNumber
                toMsgList:(NSMutableArray *)msgList;

/**
 *  获取最新的消息详情列表
 *
 *  @param servAddr      [IN]服务器地址
 *  @param sessionID     [IN]会话ID
 *  @param msgType       [IN]消息类型
 *  @param msgNumber     [IN]消息数
 *  @param msgDetailList [OUT]消息详情列表
 *
 *  @return YES - 获取成功  NO - 获取失败
 */
- (BOOL)getMsgDetailList:(NSString *)servAddr
             toSessionID:(NSString *)sessionID
               toMsgType:(MessageType)msgType
             toMsgNumber:(int)msgNumber
         toMsgDetailList:(NSMutableArray *)msgDetailList;

/**
 *  获取历史消息详情列表
 *
 *  @param servAddr      [IN]服务器地址
 *  @param sessionID     [IN]会话ID
 *  @param msgID         [IN]消息ID
 *  @param msgType       [IN]消息类型
 *  @param msgNumber     [IN]消息数
 *  @param msgDetailList [OUT]消息详情列表
 *
 *  @return YES - 获取成功  NO - 获取失败
 */
- (BOOL)getMsgDetailHistoryList:(NSString *)servAddr
                    toSessionID:(NSString *)sessionID
                        toMsgID:(NSString *)msgID
                      toMsgType:(MessageType)msgType
                    toMsgNumber:(int)msgNumber
                toMsgDetailList:(NSMutableArray *)msgDetailList;

/**
 *  获取消息详情
 *
 *  @param servAddr    [IN]服务器地址
 *  @param sessionID   [IN]会话ID
 *  @param msgID       [IN]消息ID
 *  @param messageInfo [OUT]消息详情信息
 *
 *  @return YES - 获取成功  NO - 获取失败
 */
- (BOOL)getMsgDetail:(NSString *)servAddr
         toSessionID:(NSString *)sessionID
             toMsgID:(NSString *)msgID
       toMessageInfo:(CMessage *)messageInfo;

/**
 *  根据消息ID标记消息为已读
 *
 *  @param servAddr  [IN]服务器地址
 *  @param sessionID [IN]会话ID
 *  @param msgID     [IN]消息ID
 *
 *  @return YES - 标记成功  NO - 标记失败
 */
- (BOOL)checkMsgByMsgID:(NSString *)servAddr
            toSessionID:(NSString *)sessionID
                toMsgID:(NSString *)msgID;

/**
 *  根据消息类型标记消息为已读
 *
 *  @param servAddr  [IN]服务器地址
 *  @param sessionID [IN]会话ID
 *  @param msgType   [IN]消息类型
 *
 *  @return YES - 标记成功  NO - 标记失败
 */
- (BOOL)checkMsgByMsgType:(NSString *)servAddr
              toSessionID:(NSString *)sessionID
                toMsgType:(MessageType)msgType;

/**
 *  根据消息ID删除消息
 *
 *  @param servAddr  [IN]服务器地址
 *  @param sessionID [IN]会话ID
 *  @param msgID     [IN]消息ID
 *
 *  @return YES - 删除成功  NO - 删除失败
 */
- (BOOL)deleteMsgByMsgID:(NSString *)servAddr
             toSessionID:(NSString *)sessionID
                 toMsgID:(NSString *)msgID;

/**
 *  根据消息类型删除消息
 *
 *  @param servAddr  [IN]服务器地址
 *  @param sessionID [IN]会话ID
 *  @param msgType   [IN]消息类型
 *
 *  @return YES - 删除成功  NO - 删除失败
 */
- (BOOL)deleteMsgByMsgType:(NSString *)servAddr
               toSessionID:(NSString *)sessionID
                 toMsgType:(MessageType)msgType;

#pragma mark -
#pragma mark - 其他辅助方法

/**
 *  获取SDK版本
 *
 *  @return SDK版本
 */
- (NSString *)getSDKVersion;

/**
 *  获取服务器地址
 *
 *  @return msp服务器地址
 */
- (NSString *)getServerAddress;

/**
 *  获取登录以后的sessionID
 *
 *  @return 登录以后的sessionID
 */
- (NSString *)getSessionID;

/**
 *  获取错误码
 *
 *  @return 错误码
 */
- (int)getLastErrorCode;

/**
 *  获取错误描述
 *
 *  @return 错误描述
 */
- (NSString *)getLastErrorDesc;

@end
