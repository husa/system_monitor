chrome.app.runtime.onLaunched.addListener ->
    chrome.app.window.create '../html/app.html',
      id : 'app'
      bounds:
        width: 400
        height: 500
