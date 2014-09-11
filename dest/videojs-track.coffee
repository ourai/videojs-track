"use strict"

$ = jQuery

evoClass = ( className, hasDot ) ->
  return "#{if hasDot then "." else ""}vjs-#{className}"

# 在 IE8、9 中如果未指定端口号的话，host 后面会跟上 :80，
# 这会导致在 vjs.get 发送请求时即使是同域也会判断为跨域。
vjs.parseUrl = ( url ) ->
  url = vjs.parseUrl url

  url.host = url.hostname if /:80\b/.test url.host

  return url


