let thisHref = location.href,
    userAgent = navigator.userAgent,
    isLine = userAgent.indexOf("Line") > -1

if (isLine) {
  // Line 內建瀏覽器 直接用外部瀏覽器開啟網頁
  location.href = thisHref.indexOf("?") > 0 ? thisHref + "&openExternalBrowser=1" : thisHref + "?openExternalBrowser=1";
}
