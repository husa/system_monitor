angular.module 'Services', []
  .factory 'ChromeSystem', ->
    @getCPUInfo = (callback) ->
      chrome.system.cpu.getInfo callback

    @getMemoryInfo = (callback) ->
      chrome.system.memory.getInfo callback

    @getStorageInfo = (callback) ->
      chrome.system.storage.getInfo callback

    @onStorageAttached = (callback) ->
      chrome.system.storage.onAttached.addListener callback

    @onStorageDetached = (callback) ->
      chrome.system.storage.onDetached.addListener callback

    @getDisplayInfo = (callback) ->
      chrome.system.display.getInfo callback

    @onDisplayChanged = (callback) ->
      chrome.system.display.onDisplayChanged.addListener callback

    @getNetworkInfo = (callback) ->
      chrome.system.network.getNetworkInterfaces callback
    return this
