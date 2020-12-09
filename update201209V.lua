--注意：
--[[
请确保存储权限OK,设置中的自动更新配置,放在启动事件最前面,utf-8的异步请求哦
—喀兰工作室
--]]



--[[
--启动--代码顺序不可颠倒
activity.getGlobalData()['主程序key']=2020/12/09--默认key，建议自己改改
import"/source/update201209V"--这里指调用source文件夹里名字是update201209V的文件
--预配置
检测更新无网退出=false--谨慎测试
更新报错=true
workaddress="xiaow3493@gmail.com"
双线更新=true
adddsss=("https://miaocat.baklib.com/ceshi/8582")--注意，只有首次请求页面返回码不是200时才有第二次请求
--ua设置
ua_set('Mozilla/5.0 (Linux; U; Android 7.1.2; zh-cn; Redmi 4X Build/N2G47H) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/71.0.3578.141 Mobile Safari/537.36 XiaoMi/MiuiBrowser/11.7.34')--不填默认电脑
update_tip=true--没有网络是否报错提示
--自动更新模块设置
Auto_update_protection=true
Automaticdownloadfailed="自动更新下载不可预料的出错弹出的地址"

--发起请求
update_cat('https://miaocat.baklib.com/ceshi/8582')



--调试数据
--一般变量nil的情况很多，需要分辨是本地还是云端的锅，所以提供调试函数来查看变量  : ) 
-- 其实直接print就行，不过这个调试模式可以配置一些IDE里才会执行的功能
调试模式=false--打包时要删掉
窗口化=false--弹窗的形式
--使用函数
调试量(catkey)

if 调试模式==true then
  print("远程单独公告配置时版本号这这个"..tostring(packinfo.versionName))
end
--]]



--云格式示范
--[[
--云端配置--
【开关】开【开关】
【版本】3.0.1.2【版本】
【公告】测试公告【公告】
【直链】开【直链】
【可选直链】https://assets.baklib.com/t/dc4e44f9-5791-4f40-ad50-e5b9c7a67514/u/6ccbb5e8-7af1-4ad9-99ac-4cb5fa416f7e/ASMR%E9%9F%B3%E9%A2%91-1.1.41605882622191.apk【可选直链】
【强制】关【强制】
【更新链接】http://c.biancheng.net/view/2947.html【更新链接】
【单控】
【1.5.1】
@单强制@关@单强制@
@单公告@这是单独控制的公告@单公告@
【1.5.1】
【单控】
]]

---------------------------------------------代码配置分割线

--远程更新具体代码
--验证主程序
--防止模块被删除
catkey=(activity.getGlobalData().主程序key)
if catkey==2020/12/09 then--建议在文件中替换自己的比对key
 else
  print("文件key匹配失败！")
  activity.finish()--关闭当前页面
end
--预制函数库
require "import"
import "android.app.*"
import "android.os.*"
import "java.io.*"
import "android.content.Intent"
import "android.content.Context"
import "android.widget.*"
import "android.view.*"
import "android.content.Context"
import "android.net.Uri"
import "android.app.DownloadManager$Query"
import "android.content.Intent"
import "java.io.File"
import "android.view.animation.LayoutAnimationController"
import "android.view.animation.Animation"
import "android.view.animation.AlphaAnimation"
import "android.view.animation.TranslateAnimation"
import "android.view.animation.AnimationSet"
import "android.graphics.drawable.GradientDrawable"
import "android.view.animation.Animation$AnimationListener"
import "android.graphics.drawable.ColorDrawable"
import "android.content.res.ColorStateList"
import "android.view.animation.RotateAnimation"
import "android.animation.Animator$AnimatorListener"
--信息获取模块
--网页源码过滤表（不可删除）
function handle(content)
  content=tostring(content)
  --处理获取的内容
  content = content:gsub('<br>', '') or content
  content = content:gsub('<div>', '') or content
  content = content:gsub('</div>', '') or content
  content = content:gsub('amp;', '') or content
  content = content:gsub('&nbsp;', '') or content
  content = content:gsub('<br>', '\n') or content
  --   content=content:gsub("<","") or content;
  --    content=content:gsub("/","") or content;
  --    content=content:gsub(">","") or content;
  content = content:gsub('<p>', '\n') or content
  content = content:gsub('</p>', '\n') or content
  return content
end
--自定义ua设置
function ua_set(ua)
  headerua=tostring(ua)
  return headerua
end
--报错反馈模块
function 更新报错反馈()
  if 更新报错==true then
    if code==nil or workaddress==nil or content==nil then
      自定义错误提示样式('错误信息缺失或地址缺失')
      if code==nil then
        code="\nThere is no status code returned"
      end
      if workaddress==nil then
        workaddress="\n开发者邮箱预设错误，请通过其他方式联系开发者"
      end
      if content==nil then
        content="\nCan't get the source code for parsing"
      end

    end
    import "android.content.Intent"
    i = Intent(Intent.ACTION_SEND)
    i.setType("message/rfc822")
    i.putExtra(Intent.EXTRA_EMAIL, {wordaddress})
    i.putExtra(Intent.EXTRA_SUBJECT,"报错反馈")
    i.putExtra(Intent.EXTRA_TEXT,"请反馈至地址"..workaddress.."\n\n更新报错日志"..code..'\n\n访问数据'..content)
    activity.startActivity(Intent.createChooser(i, "开发报错邮箱反馈"))
  end
end

function 多彩提示样式(sth)
  sth=tostring(sth)
  body={
    CardView;
    CardBackgroundColor="#FF0091F2";
    elevation="10dp";
    layout_width="95%w";
    layout_height="42dp";
    radius="10";
    id="body";
    {
      TextView;
      textSize="15sp";
      TextColor="#FFffffff";
      layout_width="95%w";
      layout_height="42dp";
      gravity="center";
      text="出错";
      id="messagess";
    };
  }
  local body=Toast.makeText(activity,"内容",Toast.LENGTH_SHORT).setView(loadlayout(body))
  body.setGravity(Gravity.BOTTOM,0,60)
  messagess.Text=tostring(sth)
  body.show()
  return sth,body
end
--错误提示样式
function 自定义错误提示样式(sth)
  sth=tostring(sth)
  miao={
    LinearLayout,
    layout_width="100%w";
    gravity="center";
    layout_height="fill";
    background="#C8006ED8";
    {
      TextView;
      gravity="center";
      text=sth;
      textColor="#FFFDFDFD";
      textSize=="15sp";
      layout_width="110%w";
      layout_height="35dp";
    };
  }
  lay=loadlayout(miao)
  local toast=Toast.makeText(activity,"提示",Toast.LENGTH_LONG).setView(lay).show().setGravity(Gravity.BOTTOM, 0, 0).show()
  .show()
  return sth
end






-----------------主模块
function update_cat(up)
  update =tostring(up)--转换
  --导入包
  import 'android.text.SpannableString'
  import 'android.text.style.ForegroundColorSpan'
  import 'android.text.Spannable'

  --APP信息获取
  packinfo =
  this.getPackageManager().getPackageInfo(
  this.getPackageName(),
  ((32552732 / 2 / 2 - 8183) / 10000 - 6 - 231) / 9
  )
  version = tostring(packinfo.versionName) --版本信息
  --网络状况获取
  local wangluo=activity.getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE).getActiveNetworkInfo();
  if wangluo== nil then
    if 检测更新无网退出==true then
      os.exit()--结束程序
    end
  end

  --自定义ua设置
  function ua_set(ua)
    headerua=tostring(ua)
    return headerua
  end
  header={
    ['User-Agent'] = headerua
  }
  if header==nil then
    header = {
      ['User-Agent'] = 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36'
    }
  end

  --具体请求
  Http.get(update,nil,'utf-8',header,function(code, content)
    if code == 200 then
      content=handle(content)
      --截取
      switchs = content:match('【开关】(.-)【开关】')
      message = content:match('【公告】(.-)【公告】')
      appdate = content:match('【版本】(.-)【版本】')
      auto = content:match('【直链】(.-)【直链】')
      dongtailink = content:match('【可选直链】(.-)【可选直链】')
      must = content:match('【强制】(.-)【强制】')
      activity.getGlobalData()['must'] = content:match('【强制】(.-)【强制】')
      jingtailink = content:match('【更新链接】(.-)【更新链接】')
      单控= content:match('【单控】(.-)【单控】')
      --调试量(单控)
      --      versions=tostring(packinfo.versionName)--转换字符串
      单版本= 单控:match('【'..tostring(packinfo.versionName)..'】(.-)【'..tostring(packinfo.versionName)..'】')
      if 单版本==nil or 单版本=="" then
       else
        activity.getGlobalData()['must'] =单版本:match('@单强制@(.-)@单强制@')
        must=单版本:match('@单强制@(.-)@单强制@')
        message=单版本:match('@单公告@(.-)@单公告@')
      end
      --没有获取到
      if switchs ==nil or switchs=="" then
        自定义错误提示样式("没有获取到更新状态{"..code)
        updatefall()
      end
      --公共更新
      if switchs == '开' then
        if not ((usevername and version == appdate) or (not usevername and version >= appdate)) then--判断版本号
          if auto=="开" then
            调用系统下载()
           else
            弹窗更新()
          end
         else
          --print('没有更新可用')
        end
       elseif switchs == '关' then
        --云端更新关闭
        return true
      end
     else--检查失败
      更新报错反馈()
      if update_tip==true then
        自定义错误提示样式("云更新服务异常"..code)
      end
      updatefall()
    end
  end
  )
end



function updatefall()
  if 双线更新==true then
    Http.get(adddsss,nil,'utf-8',header,function(code, content)
      if code == 200 then
        content=handle(content)
        --截取
        switchs = content:match('【开关】(.-)【开关】')
        message = content:match('【公告】(.-)【公告】')
        appdate = content:match('【版本】(.-)【版本】')
        auto = content:match('【直链】(.-)【直链】')
        dongtailink = content:match('【可选直链】(.-)【可选直链】')
        must = content:match('【强制】(.-)【强制】')
        activity.getGlobalData()['must'] = content:match('【强制】(.-)【强制】')
        jingtailink = content:match('【更新链接】(.-)【更新链接】')
        单控= content:match('【单控】(.-)【单控】')
        --调试量(单控)
        --      versions=tostring(packinfo.versionName)--转换字符串
        单版本= 单控:match('【'..tostring(packinfo.versionName)..'】(.-)【'..tostring(packinfo.versionName)..'】')
        if 单版本==nil or 单版本=="" then
         else
          activity.getGlobalData()['must'] =单版本:match('@单强制@(.-)@单强制@')
          must=单版本:match('@单强制@(.-)@单强制@')
          message=单版本:match('@单公告@(.-)@单公告@')
        end
        --没有获取到
        if switchs ==nil then
          自定义错误提示样式("没有获取到更新状态{"..code)
        end
        --公共更新
        if switchss == '开' then
          if not ((usevername and version == appdate) or (not usevername and version >= appdate)) then--判断版本号
            if auto=="开" then
              调用系统下载()
             else
              弹窗更新()
            end
           else
            --print('没有更新可用')
          end
         elseif switchss == '关' then
          --云端更新关闭
          return true
        end
       else
        自定义错误提示样式("备用线路异常{"..code)
      end
    end)
  end
end


--弹窗更新模块
function 弹窗更新()
  --then
  dialogs =
  AlertDialog.Builder(this).setTitle('公告').setMessage(message).setPositiveButton(
  --占用了dialog
  --这里不是标题，真正的标题在下面
  --消息
  ('确定'),
  {
    onClick = function(v)
      if must == '开' then
        activity.finish()--关闭当前页面
      end
      import 'android.content.Intent'
      import 'android.net.Uri'
      url = jingtailink
      viewIntent = Intent('android.intent.action.VIEW', Uri.parse(url))
      activity.startActivity(viewIntent)
      --跳转外部链接
    end
  }
  ).setNegativeButton('', nil).show()
  --.setNeutralButton("",nil)   中立按钮，也就是多一个
  dialogs.create()
  --对话框的设置
  if must == '开' then
    --设置禁用返回和外部
    dialogs.setCancelable(false)
   else
  end
  --按钮颜色
  dialogs.getButton(dialogs.BUTTON_POSITIVE).setTextColor(0xff1DA6DD)
  --积极
  dialogs.getButton(dialogs.BUTTON_NEGATIVE).setTextColor(0xff1DA6DD)
  --消极
  dialogs.getButton(dialogs.BUTTON_NEUTRAL).setTextColor(0xff1DA6DD)
  --中立
  --消息颜色
  message = dialogs.findViewById(android.R.id.message)
  message.setTextColor(0xFF333333)
  --更改Title颜色
  --这里是设置标题
  sp = SpannableString('公告')
  sp.setSpan(ForegroundColorSpan(0xff1DA6DD), 0, #sp, Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  dialogs.setTitle(sp)
end

function 配置自动更新()--删了报错 : (
  if appdate==nil then--避免更新公告内容报错
    appdate="错误版本号"
    dongtailink="nil"
   else
  end
  --获取内置路径，避免出错
  to=Environment.getExternalStorageDirectory().toString()
  --安装包名称获取
  local 应用名称 = this.applicationInfo.loadLabel(activity.getPackageManager())
  --配置用到的变量
  --安装文件夹
  fileto="Download"
  apk=应用名称..appdate.."版本更新.apk"
  --安装包路径
  apkto=to.."/"..fileto.."/"..apk
  --判定内容
  if message==nil then--避免更新公告内容报错
    message="  "
  end
  down_path=apkto
  --可以结合远程更新使用
  return message,apkto,fileto,apk,appdate,dongtailink,down_path
end


if pcall(function()
    file,err=io.open("/data/data/"..activity.getPackageName().."/updatenil.lua")
    if err==nil then
      noauto=io.open("/data/data/"..activity.getPackageName().."/updatenil.lua"):read("*a")
     else
      io.open("/data/data/"..activity.getPackageName().."/updatenil.lua","w+"):write('0.0.0.000000'):close()
    end
  end) then

 else
  自定义错误提示样式("发生错误，请开放读取存储权限")
end

function statement()
  print("署名喵：xiaow3493@gmail.com")
  --请勿删除声明，版权声明不会影响使用的。
end


--自动更新模块

--自动更新失败事件
ti=AlertDialog.Builder(this)
ti.setTitle("提示")
ti.setMessage("自动下载出现错误，但是云端检测到了更新，是否前往固定更新地址?")
ti.setPositiveButton("是的",{onClick=function(v)
    import "android.content.Intent"
    import "android.net.Uri"
    url=Automaticdownloadfailed
    viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
    activity.startActivity(viewIntent)
  end})
ti.setNeutralButton("忽略",{onClick=function(v)
    io.open("/data/data/"..activity.getPackageName().."/updatenil.lua","w+"):write(版本号):close()
    自定义错误提示样式("已暂忽略此版本的更新")
  end})
ti.setNegativeButton("关闭",nil)

function 调用系统下载()
  --配置自动更新
  if appdate==nil then--避免更新公告内容报错
    appdate="错误版本号"
    dongtailink="nil"
   else
  end
  --获取内置路径，避免出错
  to=Environment.getExternalStorageDirectory().toString()
  --安装包名称获取
  local 应用名称 = this.applicationInfo.loadLabel(activity.getPackageManager())
  --配置用到的变量
  --安装文件夹
  fileto="Download"
  apk=应用名称..appdate.."版本更新.apk"
  --安装包文件夹
  down_path=to.."/"..fileto.."/"
  --安装包路径
  apkto=to.."/"..fileto.."/"..apk
  --判定内容
  if message==nil then--避免更新公告内容报错
    message="  "
  end
  down_path=apkto
  --比对版本号码
  if pcall(function()
      if ((noauto==appdate) and (not must=='否')) then
       else
        --      file,err=io.open(apkto)
        file,err=io.open(down_path)
        if err==nil then
          miao=AlertDialog.Builder(this)
          miao.setTitle("检测到新的更新")
          miao.setMessage("新版本更新已经为你下载完毕，是否安装?\n"..message.."\n\n下载路径为"..apkto)
          if must == '开' then
            --设置禁用返回和外部
            miao.setCancelable(false)
            miao.setPositiveButton("安装",{onClick=function(v)
                intent = Intent(Intent.ACTION_VIEW)
                安装包路径=apkto
                intent.setDataAndType(Uri.parse("file://"..安装包路径), "application/vnd.android.package-archive")
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                activity.startActivity(intent)
                task(700,function()
                  退出程序()
                end)

              end})
           else
            miao.setPositiveButton("安装",{onClick=function(v)
                intent = Intent(Intent.ACTION_VIEW)
                安装包路径=apkto
                intent.setDataAndType(Uri.parse("file://"..安装包路径), "application/vnd.android.package-archive")
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                activity.startActivity(intent)
              end})
            miao.setNeutralButton("忽略",{onClick=function(v)
                io.open("/data/data/"..activity.getPackageName().."/updatenil.lua","w+"):write(appdate):close()
                自定义错误提示样式("已经忽略此版本的更新")
                os.remove(apkto)
              end})
            miao.setNegativeButton("关闭",nil)
          end
          miao.show()
         else
          if dongtailink==nil then
            自定义错误提示样式("云端或本地动态链接配置为空")
           else
            AlertDialog.Builder(this)
            .setTitle("提示")
            .setMessage("有新的自动更新")
            .setCancelable(false)
            .setPositiveButton("现在下载",{onClick=function(v)
                if pcall(function()
                    --"Download"不能变
                    downlaodFile(dongtailink,"Download", apk, apk, enable)
                  end) then
                 else
                  自定义错误提示样式("自动下载出现错误—启用固态更新\n动态地址不支持的类型")
                  弹窗更新()
                end
              end})
            --.setNeutralButton("中立",nil)
            .setNegativeButton("取消更新",{onClick=function(v)
                if (activity.getGlobalData().must)=="开" then
                  activity.finish()
                end
              end})
            .show()
            --[[
          --  print("不存在安装文件")
          downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
          url=Uri.parse(dongtailink);
          request=DownloadManager.Request(url);
          request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
          request.setDestinationInExternalPublicDir(fileto,apk);--这里也要改的
          request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
          downloadManager.enqueue(request);
]]
          end
        end
      end
    end) then
    --  print("未报错")
   else
    自定义错误提示样式("自动更新出现不可预料的错误")
    if Auto_update_protection==true then
      ti.show()
    end
  end
end

--调试函数
function 调试量(debug)
  if 调试模式==true then
    --   if pcall(function()
    if 窗口化==true then
      debugs=tostring(debug)--转换字符串
      AlertDialog.Builder(this)
      .setTitle("结果")
      .setMessage(debugs)
      .setPositiveButton("复制",{onClick=function(v)
          --复制文本
          import "android.content.*"
          activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(debugs)
        end})
      .setNegativeButton("关闭",nil)
      .show()
     else
      print(debug)
    end
    --end) then
    --  else
    --print("错误，可能无值或其他")
    --    end
  end
end
--模块版权识别
if statement==true then
  statement()
end
--down_path="/sdcard/download/"
toz=Environment.getExternalStorageDirectory().toString()
down_path=toz.."/download/"
local dlprogress={
  LinearLayout;
  orientation="vertical";
  layout_height="60%h";
  layout_width="100%w";
  gravity="center";
  id="dc";
  backgroundColor="#FFEEEEEE";
  {
    CardView;
    layout_height="wrap";
    id="card";
    backgroundColor="#FFEEEEEE";
    {
      ScrollView;
      layout_height="fill";
      layout_width="fill";
      VerticalScrollBarEnabled=false;
      layout_marginTop="10dp";
      OverScrollMode=2;
      backgroundColor="#FFEEEEEE";
      {
        LinearLayout;
        orientation="vertical";
        layout_height="fill";
        BackgroundColor="#FFEEEEEE";
        layout_width="100%w";
        {
          CardView;
          radius="10dp";
          layout_margin="1dp";
          layout_width="fill";
          elevation="2dp";
          CardBackgroundColor="#ffffffff";
          layout_height="wrap";
          layout_marginTop="2dp";
          id="UAview";
          {
            LinearLayout;
            orientation="vertical";
            layout_height="wrap";
            layout_width="fill";
            backgroundColor="#ffffffff";
            {
              LinearLayout;
              gravity="center";
              layout_height="wrap";
              layout_width="fill";
              layout_gravity="center";
              {
                TextView;
                textSize="19";
                layout_gravity="top";
                text="软件更新下载";
                layout_width="45%w";
                layout_height="fill";
                gravity="center";
                textColor="#F5141414";
              };
              {
                TextView;
                textSize="16sp";
                layout_width="45%w";
                text="取消更新";
                style="?android:attr/buttonBarButtonStyle";
                layout_height="37dp";
                textColor="#FF0099FF";
                id="取消更新";
              };
            };
            {
              LinearLayout;
              orientation="vertical";
              layout_height="fill";
              layout_width="fill";
              layout_margin="20";
              {
                LinearLayout;
                layout_height="90dp";
                layout_width="fill";
                layout_margin="7dp";
                {
                  LinearLayout;
                  orientation="horizontal";
                  layout_height="wrap";
                  layout_width="fill";
                  backgroundColor="#ffffffff";
                  {
                    CircleImageView;
                    layout_margin="10dp";
                    src="icon.png";
                    layout_height="50dp";
                    layout_width="50dp";
                    layout_gravity="center";
                  };
                  {
                    LinearLayout;
                    orientation="vertical";
                    layout_height="wrap";
                    layout_width="fill";
                    layout_gravity="center";
                    {
                      TextView;
                      layout_width="fill";
                      text="下载位置:"..down_path;
                    };
                    {
                      TextView;
                      text="文件信息:";
                      layout_width="fill";
                      id="tv_size";
                    };
                  };
                };
              };
              {
                LinearLayout;
                layout_weight="1";
                layout_height="fill";
                layout_width="fill";
                orientation="horizontal";
                {
                  ProgressBar;
                  layout_width="fill";
                  layout_weight="1";
                  id="progressbar";
                  indeterminate=true;--改成false就直观显示
                  style="?android:attr/progressBarStyleHorizontal";
                  progress=0;
                  layout_height="fill";
                  padding="25";
                  max=100;
                };
                {
                  TextView;
                  text="0%";
                  layout_height="fill";
                  gravity="center";
                  id="progress";
                };
              };
            };
          };
        };
      };
    };
  };
};

function installApk(path)
  intent = Intent(Intent.ACTION_VIEW)
  安装包路径=path
  intent.setDataAndType(Uri.parse("file://"..安装包路径), "application/vnd.android.package-archive")
  intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  activity.startActivity(intent)
end

function downlaodFile(url, path, filename, title, must)
  os.remove(down_path)
  local downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
  local uri=Uri.parse(url)
  local request=DownloadManager.Request(uri)
  request.setTitle(title)
  request.setMimeType("application/vnd.android.package-archive")
  request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI)
  request.setDestinationInExternalPublicDir(path, filename)
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED)
  local dlid = downloadManager.enqueue(request)
  --[[
  AlertDialog.Builder(this)
  .setTitle("下载")
  .setView(loadlayout(dlprogress))
  .setNegativeButton("取消",{onClick = function()
      if t ~= nil then
        t.stop()
      end
      if dlid ~= nil then
        downloadManager.remove(luajava.createArray("long",{dlid}))
      end
      if must == true then
        activity.finish()
      end
    end})
  .show()
]]
  dialog= AlertDialog.Builder(this)
  dialog1=dialog.show()
  dialog1.getWindow().setContentView(loadlayout(dlprogress));
  dialog1.getWindow().setBackgroundDrawable(ColorDrawable(0x00000000));
  dialogWindow = dialog1.getWindow();
  dialogWindow.setGravity(Gravity.BOTTOM);
  --设置弹窗与返回键的响应,true为消失
  dialog1.setCancelable(false)
  --设置点击外部弹窗不消失
  dialog1.setCanceledOnTouchOutside(false)
  --设置弹窗宽度
  p=dialog1.getWindow().getAttributes();
  p.width=(activity.Width);
  dialog1.getWindow().setAttributes(p);
  --弹窗背景和圆角
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(0x00FFFFFF)
  drawable.setCornerRadii({25,25,25,25,0,0,0,0});
  dc.setBackgroundDrawable(drawable)

  function CircleButton(view,InsideColor,radiu)
    import "android.graphics.drawable.GradientDrawable"
    drawable = GradientDrawable()
    drawable.setShape(GradientDrawable.RECTANGLE)
    drawable.setColor(InsideColor)
    drawable.setCornerRadii({radiu,radiu,radiu,radiu,0,0,0,0});
    view.setBackgroundDrawable(drawable)
  end
  角度=40
  控件id=card
  控件颜色=0xFFEEEEEE
  CircleButton(控件id,控件颜色,角度)

  function 上滑动画(id)
    import "android.view.animation.LayoutAnimationController"
    import "android.view.animation.Animation"
    import "android.view.animation.AlphaAnimation"
    import "android.view.animation.TranslateAnimation"
    import "android.view.animation.AnimationSet"
    --定义动画变量,使用AnimationSet类，使该动画可加载多种动画
    animationSet = AnimationSet(true)
    --设置布局动画，布局动画的意思是布局里面的控件执行动画，而非单个控件动画，参数:动画名，延迟
    layoutAnimationController=LayoutAnimationController(animationSet,0.2);
    --设置动画类型，顺序   反序   随机
    layoutAnimationController.setOrder(LayoutAnimationController.ORDER_NORMAL); --   ORDER_     NORMAL     REVERSE     RANDOM
    --id控件加载动画
    id.setLayoutAnimation(layoutAnimationController);
    ganbei_dh2=TranslateAnimation(0,0,activity.height/(5/3),0)
    ganbei_dh2.setDuration(800);
    ganbei_dh2.setStartOffset(0)
    --动画执行次数，-1   Animation.INFINITE  表示不停止
    ganbei_dh2.setRepeatCount(0.5)
    --动画执行完后是否停留在执行完的状态
    -- yuxuan_dh2.setFillAfter(true)
    --添加动画
    animationSet.addAnimation(ganbei_dh2);
  end
  上滑动画(dc)
  取消更新.onClick=function()
    if t ~= nil then
      t.stop()
    end
    if dlid ~= nil then
      downloadManager.remove(luajava.createArray("long",{dlid}))
    end
    if (activity.getGlobalData().must)=="开" then
      activity.finish()
    end
    下滑动画(dc)
  end
  function 下滑动画(id)
    ganbei_dh3=TranslateAnimation(0,0,0,activity.height/(5/3))
    ganbei_dh3.setDuration(800);
    ganbei_dh3.setStartOffset(0)
    --动画执行次数，-1   Animation.INFINITE  表示不停止
    ganbei_dh3.setRepeatCount(0.5)
    --动画执行完后是否停留在执行完的状态
    ganbei_dh3.setFillAfter(true)
    id.startAnimation(ganbei_dh3)--设置
    import "android.view.animation.Animation$AnimationListener"
    ganbei_dh3.setAnimationListener(AnimationListener{
      onAnimationEnd=function()
        dialog1.dismiss()
      end,
    })
  end
  function CircleButton(view,InsideColor,radiu)
    import "android.graphics.drawable.GradientDrawable"
    drawable = GradientDrawable()
    drawable.setShape(GradientDrawable.RECTANGLE)
    drawable.setColor(InsideColor)
    drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
    view.setBackgroundDrawable(drawable)
  end
  --  progressbar.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(0xFF00B0FF,PorterDuff.Mode.SRC_ATOP))
  --ProgressBar颜色修改
  if pcall(function()
      t=Ticker()
      t.Period=200
      t.onTick=function()
        local downloadQuery = DownloadManager.Query()
        downloadQuery.setFilterById(luajava.createArray("long",{dlid}))
        cursor = downloadManager.query(downloadQuery)
        if cursor ~= nil and cursor.moveToFirst() then
          status = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS))
          if status == DownloadManager.STATUS_SUCCESSFUL then
            progressbar.setProgress(100)
            local bytesDownloadSoFar = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_BYTES_DOWNLOADED_SO_FAR))
            local totalSizeBytes = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_TOTAL_SIZE_BYTES))
            tv_size.setText("文件信息:"..bytesDownloadSoFar.."/"..totalSizeBytes)
            progress.setText("100%")
            t.stop()
            installApk(apkto)
           elseif status == DownloadManager.STATUS_FAILED then
            自定义错误提示样式("自动下载出现错误—启用固态更新\n资源地址无响应请求")
            弹窗更新()
            t.stop()
           elseif status == DownloadManager.STATUS_RUNNING then
            local bytesDownloadSoFar = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_BYTES_DOWNLOADED_SO_FAR))
            local totalSizeBytes = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_TOTAL_SIZE_BYTES))
            progressbar.setProgress(bytesDownloadSoFar*100/totalSizeBytes)
            tv_size.setText("文件信息:"..bytesDownloadSoFar.."/"..totalSizeBytes)
            progress.setText(string.format("%.2f", bytesDownloadSoFar*100/totalSizeBytes).."%")
          end
        end
      end
      t.start()
    end) then
   else
    print("下载出现错误")
    弹窗更新()
  end
end














--[[

--其他函数
--解压缩方法
to=Environment.getExternalStorageDirectory().toString()

--先导入io包
import "java.io.*"
file,err=io.open(to.."/FusionApp/测试更新.zip")
if err==nil then
  print("存在")
  ZipUtil.unzip(to.."/FusionApp/测试更新.zip",to.."/FusionApp")

import "android.content.Intent"
import "android.net.Uri"
intent = Intent(Intent.ACTION_VIEW)
安装包路径=to.."/FusionApp/0.apk"
intent.setDataAndType(Uri.parse("file://"..安装包路径), "application/vnd.android.package-archive")
intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
activity.startActivity(intent)


 else
  print("不存在")
  
  --导入包
import "android.content.Context"
import "android.net.Uri"

downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
url=Uri.parse("https://static01.imgkr.com/temp/887928496e44403c8982a9a7f0e413cd.png");
request=DownloadManager.Request(url);
request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
request.setDestinationInExternalPublicDir("FusionApp","测试更新.zip");
request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
downloadManager.enqueue(request);
end


 --函数：匹配链接
  string.gkeepUrl = function(str)
    local strurltab = {}
    for i, v in string.gfind(str, 'https?://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]') do
      strurltab[#strurltab + 1] = string.sub(str, i, v)
    end
    return strurltab
  end
      --处理链接获取，确保匹配
      ----匹配起始
      local str1 = ''
      for i, v in ipairs(string.gkeepUrl(link)) do
        str1 = str1 .. v .. ' '
      end
      linkb = str1
      --匹配结束（可删除）把确定按钮中linkb改为link即可


]]
