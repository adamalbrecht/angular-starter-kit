# Given a github username and repo name, it displays the repo's
# Stars, Watcher count, primary language, open issue count,
# fork count, avatar, etc
angular.module('starter-app').directive 'githubRepoDashboard', (GithubRepoAPI) ->
  {
    restrict: 'A'
    scope: {
      username: '@'
      repoName: '@'
    }
    replace: true
    link: (scope, elem, attrs) ->
      scope.hello = 'world'
      GithubRepoAPI.fetchInfo(scope.username, scope.repoName)
        .success((data) ->
          scope.data = data
        )

    template: """
                <div class='github-repo-dash'>
                  <img ng-src='{{data.owner.avatar_url}}size=72' />
                  <strong class='github-repo-dash-name' ng-bind='data.name'></strong>
                  <div class='github-repo-dash-description' ng-bind='data.description'></div>
                </div>
              """
  }

# Given a github username and repo name, it fetches the json
# metadata about the repository
angular.module('starter-app').factory 'GithubRepoAPI', ($http) ->
  fetchInfo: (username, repoName) ->
    $http.get("https://api.github.com/repos/#{username}/#{repoName}")
