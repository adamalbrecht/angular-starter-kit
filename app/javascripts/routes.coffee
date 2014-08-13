app = angular.module('starter-app')

app.config(($stateProvider, $urlRouterProvider) ->

  $urlRouterProvider.otherwise("/")

  $stateProvider
    .state('home', {
      url: "/",
      templateUrl: "/templates/home.html"
    })
    .state('info', {
      url: "",
      abstract: true,
      template: "<div class='info-page' data-ui-view></div>"
    })
    .state('info.features', {
      url: "/features"
      templateUrl: "/templates/features.html"
    })
    .state('info.package-management', {
      url: "/package-management"
      templateUrl: "/templates/package-management.html"
    })
    .state('info.included-libraries', {
      url: "/included-libraries"
      templateUrl: "/templates/included-libraries.html"
    })
    .state('info.project-structure', {
      url: "/project-structure"
      templateUrl: "/templates/project-structure.html"
    })
    .state('info.build-system', {
      url: "/build-system"
      templateUrl: "/templates/build-system.html"
    })
    .state('info.dev-server', {
      url: "/dev-server"
      templateUrl: "/templates/dev-server.html"
    })
    .state('info.testing', {
      url: "/testing"
      templateUrl: "/templates/testing.html"
    })
    .state('info.getting-started', {
      url: "/getting-started",
      templateUrl: "/templates/getting-started.html"
    })
    .state('info.sample-code', {
      url: "/sample-code",
      templateUrl: "/templates/sample-code.html"
    })
)
