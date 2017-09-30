Pod::Spec.new do |s|
  s.name         = "XHNetworkCache"
  s.version      = "1.4.0"
  s.summary      = "一行代码将网络数据持久化 - 支持数据同步/异步写入及更新、缓存数据读取、获取缓存数据大小、缓存数据清除"
  s.homepage     = "https://github.com/CoderZhuXH/XHNetworkCache"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Zhu Xiaohui" => "977950862@qq.com"}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/CoderZhuXH/XHNetworkCache.git", :tag => s.version }
  s.source_files = "XHNetworkCache", "*.{h,m}"
  s.requires_arc = true
    
end
