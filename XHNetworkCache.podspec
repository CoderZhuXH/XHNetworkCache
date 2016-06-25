Pod::Spec.new do |s|
  s.name         = "XHNetworkCache"
  s.version      = "1.0"
  s.summary      = "一行代码将请求数据写入磁盘缓存"
  s.homepage     = "https://github.com/CoderZhuXH/XHNetworkCache"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Zhu Xiaohui" => "977950862@qq.com"}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/CoderZhuXH/XHNetworkCache.git", :tag => s.version }
  s.source_files = "XHNetworkCache", "*.{h,m}"
  s.requires_arc = true
    
end
