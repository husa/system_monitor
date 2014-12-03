# log = (data) -> console.log data

# chrome.system.cpu.getInfo log
# chrome.system.memory.getInfo log
# chrome.system.storage.getInfo log
# chrome.system.display.getInfo log
# chrome.system.network.getNetworkInterfaces log


app = angular.module 'systemMonitor', []

app.controller 'CPUController', [
  '$scope'
  '$timeout'
  '$interval'
  'ChromeSystem'
  ($scope, $timeout, $interval, System) ->
    $scope.data = {}
    $scope.processors = []
    $scope.showJSON = off
    processors = []

    updateCPU = ->
      System.getCPUInfo (data) ->
        $scope.data = data
        if processors.length isnt 0
          $scope.processors = updateProcessorsData(data.processors)
        processors = data.processors
        $scope.$apply()

    updateProcessorsData = (newProcs) ->
      oldProcs = processors.map((a)->a.usage)
      newProcs = newProcs.map((a)->a.usage)
      for oldProc, i in oldProcs
        newProc = newProcs[i]
        usage = ((newProc.user + newProc.kernel) - (oldProc.user + oldProc.kernel)) / (newProc.total - oldProc.total)

    updateCPU()
    $timeout updateCPU, 100
    $interval updateCPU, 1000
]

app.controller 'MemoryController', [
  '$scope'
  '$interval'
  'ChromeSystem'
  ($scope, $interval, System) ->
    $scope.memory = {}
    $scope.showJSON = off

    updateMemory = ->
      System.getMemoryInfo (data) ->
        $scope.memory = data

    updateMemory()
    $interval updateMemory, 1000
]

app.controller 'StorageController', [
  '$scope'
  '$interval'
  'ChromeSystem'
  ($scope, $interval, System) ->
    $scope.storage = {}
    $scope.showJSON = off

    updateStorage = ->
      System.getStorageInfo (data) ->
        $scope.storage = data

    updateStorage()
    System.onStorageAttached updateStorage
    System.onStorageDetached updateStorage
]

app.controller 'DisplayController', [
  '$scope'
  'ChromeSystem'
  ($scope, System) ->
    $scope.displays = []
    $scope.showJSON = off

    updateDisplays = ->
      System.getDisplayInfo (data) ->
        $scope.displays = data

    updateDisplays()
    System.onDisplayChanged updateDisplays
]

app.controller 'NetworkController', [
  '$scope'
  'ChromeSystem'
  ($scope, System) ->
    $scope.interfaces = [];
    $scope.showJSON = off

    updateInterfaces = ->
      System.getNetworkInfo (data) ->
        $scope.interfaces = data

    updateInterfaces()
]

app.factory 'ChromeSystem', ->
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
