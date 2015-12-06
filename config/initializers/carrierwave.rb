::CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = $system.qiniu.access_key
  config.qiniu_secret_key    = $system.qiniu.secret_key
  config.qiniu_bucket        = $system.bucket
  config.qiniu_bucket_domain = $system.domain
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"
  config.qiniu_can_overwrite = true
end
