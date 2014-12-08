angular.module 'Directives', []
  .directive 'smDonut', ->
    restrict: 'E'
    scope:
      data: '='
      width: '=?'
      height: '=?'
      thick: '=?'
    templateUrl : '../partials/smDonut.html'
    controller: ($scope) ->
      $scope.width ?= 100
      $scope.height ?= 100
      $scope.thick ?= 10
      $scope.radius = 30
      $scope.PI = Math.PI
      # $scope.getDashOffset = ->
      #   "stroke-dash-offset: #{(2*$scope.PI*$scope.radius*(1 - $scope.data))|0}"
      return



