angular.module 'Controllers', ['Services']
  .controller 'CPUController', [
    '$scope'
    '$timeout'
    '$interval'
    'ChromeSystem'
    ($scope, $timeout, $interval, System) ->
      $scope.data = {}
      $scope.processors = []
      $scope.showJSON = off
      processors = []
      processorsHistory = []

      updateCPU = ->
        System.getCPUInfo (data) ->
          $scope.data = data
          if processors.length isnt 0
            $scope.processors = updateProcessorsData data.processors
          processors = data.processors
          processorsHistory.push processors
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

  .controller 'MemoryController', [
    '$scope'
    '$interval'
    'ChromeSystem'
    ($scope, $interval, System) ->
      $scope.memory = {}
      $scope.showJSON = off

      updateMemory = ->
        System.getMemoryInfo (data) ->
          $scope.memory = data
          $scope.total = data.capacity;
          $scope.available = data.availableCapacity
          $scope.used = $scope.total - $scope.available


      updateMemory()
      $interval updateMemory, 1000
  ]

  .controller 'StorageController', [
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

  .controller 'DisplayController', [
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

  .controller 'NetworkController', [
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
