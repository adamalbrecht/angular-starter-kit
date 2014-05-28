describe 'Sample Controller', ->
  ctrl = null
  $scope = null
  beforeEach(angular.mock.module('starter-app'))
  beforeEach(inject(($rootScope, $controller) ->
    $scope = $rootScope.$new()
    ctrl = $controller("SampleController", {$scope: $scope})
    return # Be careful with coffeescript's implicit returns in Angular DI setup code
  ))
  describe 'by default', ->
    it 'has an equation of 1 + 2 = 3', ->
      expect($scope.equation.a).toEqual(1)
      expect($scope.equation.b).toEqual(2)
      expect($scope.equation.c).toEqual(3)
    it 'has a correct equation label', ->
      expect($scope.equationLabel).toEqual("correct")

  describe 'When A is changed to make the equation incorrect', ->
    beforeEach ->
      $scope.equation.a = 5
      $scope.$apply()

    it 'sets the equation label to incorrect', ->
      expect($scope.equationLabel).toEqual("incorrect")

  describe 'When A is set to an invalid number', ->
    beforeEach ->
      $scope.equation.a = "hello"
      $scope.$apply()

    it 'sets A to NaN', ->
      expect($scope.equation.a).toBeNaN()

    it 'sets the equation label to incorrect', ->
      expect($scope.equationLabel).toEqual('incorrect')
