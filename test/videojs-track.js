(function() {
  "use strict";
  var $, evoClass;

  $ = jQuery;

  evoClass = function(className, hasDot) {
    return "" + (hasDot ? "." : "") + "vjs-" + className;
  };

  vjs.parseUrl = function(url) {
    url = vjs.parseUrl(url);
    if (url.host.replace(/:80\b/, "") === url.hostname) {
      url.host = url.hostname;
    }
    return url;
  };

}).call(this);
