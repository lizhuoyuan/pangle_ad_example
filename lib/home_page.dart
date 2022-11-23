import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

import 'ads_config.dart';

// 结果信息
String _result = '';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _adEvent = '';

  @override
  void initState() {
    super.initState();
    init().then((value) {
      if (value) {
        showSplashAd();
      }
    });
    //setAdEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterAds pangle plugin'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text('Result: $_result'),
                SizedBox(height: 10),
                Text('onAdEvent: $_adEvent'),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('初始化'),
                  onPressed: () {
                    init();
                  },
                ),
                SizedBox(height: 20),

                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('开屏广告（全屏）'),
                  onPressed: () {
                    showSplashAd();
                  },
                ),
                SizedBox(height: 20),
                // ElevatedButton(
                //   child: Text('新插屏视频广告'),
                //   onPressed: () {
                //     showFullScreenVideoAd(AdsConfig.newInterstitialId);
                //   },
                // ),
                // SizedBox(height: 20),
                // ElevatedButton(
                //   child: Text('新插屏（半屏）广告'),
                //   onPressed: () {
                //     showFullScreenVideoAd(AdsConfig.newInterstitialId2);
                //   },
                // ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('激励视频广告'),
                  onPressed: () {
                    showRewardVideoAd();
                  },
                ),

                // AdBannerWidget(
                //   posId: AdsConfig.bannerId,
                // ),
                // SizedBox(height: 10),
                // AdBannerWidget(
                //   posId: AdsConfig.bannerId01,
                //   width: 300,
                //   height: 75,
                //   interval: 30,
                //   show: true,
                // ),
                // SizedBox(height: 10),
                // AdBannerWidget(
                //   posId: AdsConfig.bannerId02,
                //   width: 320,
                //   height: 50,
                //   autoClose: false,
                // ),
                // SizedBox(height: 20),
                // ElevatedButton(
                //   child: Text('展示全屏视频广告（已过时）'),
                //   onPressed: () {
                //     showFullScreenVideoAd(AdsConfig.fullScreenVideoId);
                //   },
                // ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 初始化广告 SDK
  Future<bool> init() async {
    bool result = await FlutterUnionad.register(
        //穿山甲广告 Android appid 必填
        androidAppId: "5351615",
        //穿山甲广告 ios appid 必填
        iosAppId: "5351615",
        //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView 选填
        useTextureView: true,
        //appname 必填
        appName: "unionad_test",
        //是否允许sdk展示通知栏提示 选填
        allowShowNotify: true,
        //是否在锁屏场景支持展示广告落地页 选填
        allowShowPageWhenScreenLock: true,
        //是否显示debug日志
        debug: true,
        //是否支持多进程，true支持 选填
        supportMultiProcess: true,
        //是否开启个性化推荐 选填 默认开启

        //允许直接下载的网络状态集合 选填
        directDownloadNetworkType: [
          FlutterUnionadNetCode.NETWORK_STATE_2G,
          FlutterUnionadNetCode.NETWORK_STATE_3G,
          FlutterUnionadNetCode.NETWORK_STATE_4G,
          FlutterUnionadNetCode.NETWORK_STATE_WIFI
        ]);
    return result;
  }

  /// 展示激励视频广告
  Future<void> showRewardVideoAd() async {
    await FlutterUnionad.loadRewardVideoAd(
      androidCodeId: AdsConfig.rewardVideoId,
      //Android 激励视频广告id  必填
      iosCodeId: "945418088",
      //ios 激励视频广告id  必填
      supportDeepLink: true,
      //是否支持 DeepLink 选填
      rewardName: "100金币",
      //奖励名称 选填
      rewardAmount: 100,
      //奖励数量 选填
      userID: "123",
      //  用户id 选填
      orientation: FlutterUnionadOrientation.VERTICAL,
      //控制下载APP前是否弹出二次确认弹窗
      downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
      //视屏方向 选填
      mediaExtra: null, //扩展参数 选填
      //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
     );
    await FlutterUnionad.showRewardVideoAd();
  }

  /// 展示开屏广告
  Future<void> showSplashAd() async {
    FlutterUnionad.splashAdView(
      //是否使用个性化模版  设定widget宽高
      mIsExpress: true,
      //android 开屏广告广告id 必填
      androidCodeId: AdsConfig.splashId,
      //ios 开屏广告广告id 必填
      iosCodeId: "887367774",
      //是否支持 DeepLink 选填
      supportDeepLink: true,
      // 期望view 宽度 dp 选填 mIsExpress=true必填
      expressViewWidth: 750,
      //期望view高度 dp 选填 mIsExpress=true必填
      expressViewHeight: 800,
      //控制下载APP前是否弹出二次确认弹窗
      downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
      //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，

      callBack: FlutterUnionadSplashCallBack(
        onShow: () {
          print("开屏广告显示");
        },
        onClick: () {
          print("开屏广告点击");
          Navigator.pop(context);
        },
        onFail: (error) {
          print("开屏广告失败 $error");
        },
        onFinish: () {
          print("开屏广告倒计时结束");
          Navigator.pop(context);
        },
        onSkip: () {
          print("开屏广告跳过");
          Navigator.pop(context);
        },
        onTimeOut: () {
          print("开屏广告超时");
        },
      ),
    );
  }
}
