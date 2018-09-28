Pod::Spec.new do |s|
    s.name         = 'BAWKWebView'
    s.version      = '1.0.9'
s.summary      = 'WKWebView 的封装，用分类封装 WKWebView，代码无任何侵入更改，用 block 方式实现所需代理回调，更加方便，代码更简洁，cell 高度完美自适应！'
    s.homepage     = 'https://github.com/BAHome/BAWKWebView'
    s.license      = 'MIT'
    s.authors      = { 'boai' => 'sunboyan@outlook.com' }
    s.platform     = :ios, '7.0'
    s.source       = { :git => 'https://github.com/BAHome/BAWKWebView.git', :tag => s.version.to_s }
    s.source_files = 'BAWKWebView/BAWKWebView/*.{h,m}'
    s.requires_arc = true
end
