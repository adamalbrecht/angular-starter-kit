angular.module("starter-app").controller "SampleController", ($scope) ->
  $scope.equation = {
    a: 1
    b: 2
    c: 3
  }

  isCorrect = ->
    (($scope.equation.a + $scope.equation.b) == $scope.equation.c)

  enforceIntegers = ->
    for key, value of $scope.equation
      $scope.equation[key] = parseInt($scope.equation[key])

  setEquationLabel = ->
    $scope.equationLabel = if isCorrect() then "correct" else "incorrect"

  setEquationLabel()

  $scope.$watch(
    "equation",
    ->
      enforceIntegers()
      setEquationLabel()
    true
  )
