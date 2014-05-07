app = angular.module("starter-app.data", [])
app = angular.module("starter-app.directives", ['starter-app.data'])
app = angular.module("starter-app", ['starter-app.data', 'starter-app.directives', 'ui.router', 'ui.bootstrap'])
