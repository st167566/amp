﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///WeiXinRequest 的摘要说明
/// </summary>
public class WeiXinRequest
{
    public WeiXinRequest()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }
    private string toUserName;
    /// <summary>
    /// 消息接收方微信号，一般为公众平台账号微信号
    /// </summary>
    public string ToUserName
    {
        get { return toUserName; }
        set { toUserName = value; }
    }

    private string fromUserName;
    /// <summary>
    /// 消息发送方微信号
    /// </summary>
    public string FromUserName
    {
        get { return fromUserName; }
        set { fromUserName = value; }
    }

    private string createTime;
    /// <summary>
    /// 创建时间
    /// </summary>
    public string CreateTime
    {
        get { return createTime; }
        set { createTime = value; }
    }

    private string msgType;
    /// <summary>
    /// 信息类型 地理位置:location,文本消息:text,消息类型:image，音频：voice，视频：video,取消关注：Action
    /// </summary>
    public string MsgType
    {
        get { return msgType; }
        set { msgType = value; }
    }

    private string content;
    /// <summary>
    /// 信息内容
    /// </summary>
    public string Content
    {
        get { return content; }
        set { content = value; }
    }

    private string msgId;
    /// <summary>
    /// 消息ID（文本）
    /// </summary>
    public string MsgId
    {
        get { return msgId; }
        set { msgId = value; }
    }

    private string wxevent;
    /// <summary>
    /// 事件响应的Event节点
    /// </summary>
    public string Wxevent
    {
        get { return wxevent; }
        set { wxevent = value; }
    }
    private string eventKey;
    /// <summary>
    /// 事件响应的EventKey节点
    /// </summary>
    public string EventKey
    {
        get { return eventKey; }
        set { eventKey = value; }
    }


    private string location_X;
    /// <summary>
    /// 地理位置纬度
    /// </summary>
    public string Location_X
    {
        get { return location_X; }
        set { location_X = value; }
    }

    private string location_Y;
    /// <summary>
    /// 地理位置经度
    /// </summary>
    public string Location_Y
    {
        get { return location_Y; }
        set { location_Y = value; }
    }

    private string scale;
    /// <summary>
    /// 地图缩放大小
    /// </summary>
    public string Scale
    {
        get { return scale; }
        set { scale = value; }
    }

    private string label;
    /// <summary>
    /// 地理位置信息
    /// </summary>
    public string Label
    {
        get { return label; }
        set { label = value; }
    }

    private string picUrl;
    /// <summary>
    /// 图片链接，开发者可以用HTTP GET获取
    /// </summary>
    public string PicUrl
    {
        get { return picUrl; }
        set { picUrl = value; }
    }
}
