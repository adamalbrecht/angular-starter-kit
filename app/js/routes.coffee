app = angular.module('starter-app')

app.config(($stateProvider, $urlRouterProvider) ->

  $urlRouterProvider.otherwise("/")

  $stateProvider
    .state('info', {
      url: "",
      abstract: true,
      template: "<div class='info-page' data-ui-view></div>"
    })
    .state('home', {
      url: "/",
      templateUrl: "/templates/home.html"
    })
    .state('info.features', {
      url: "/features",
      templateUrl: "/templates/features.html"
    })
    .state('info.libraries-tools', {
      url: "/libraries-tools",
      templateUrl: "/templates/libraries-tools.html"
    })
    .state('info.getting-started', {
      url: "/getting-started",
      templateUrl: "/templates/getting-started.html"
    })
)
