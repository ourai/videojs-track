(function() {
  "use strict";
  var $, evoClass;

  $ = jQuery;

  evoClass = function(className, hasDot) {
    return "" + (hasDot ? "." : "") + "vjs-" + className;
  };

  vjs.parseUrl = function(url) {
    url = vjs.parseUrl(url);
    if (/:80\b/.test(url.host)) {
      url.host = url.hostname;
    }
    return url;
  };

}).call(this);
