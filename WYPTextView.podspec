Pod::Spec.new do |s|
  s.name     = 'WYPTextView'
  s.version  = ‘0.1.1’
  s.platform = :ios
  s.license  = 'MIT'
  s.summary  = 'A similar control to the pull down to refresh control created by atebits in Tweetie 2.'
  s.homepage = 'https://github.com/epingwang/WYPTextView'
  s.author   = { 'EpingWang' => 'epingwang@163.com' }
  s.source   = { :git    => 'https://github.com/epingwang/WYPTextView.git'  }

  s.source_files = 'WYPTextView/Classes/*.{h,m}'
  s.requires_arc = true
end
