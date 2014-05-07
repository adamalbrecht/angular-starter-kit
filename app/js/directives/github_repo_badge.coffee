# Given a github username and repo name, it displays the repo's
# Stars, Watcher count, primary language, open issue count,
# fork count, avatar, etc
angular.module('starter-app.directives').directive 'githubRepoBadge', (GithubRepoAPI) ->
  {
    restrict: 'A'
    scope: {
      githubRepoBadge: '@'
    }
    replace: true
    link: (scope, elem, attrs) ->
      vars = scope.githubRepoBadge.split("/")
      username = vars[0]
      repo = vars[1]
      scope.data = null
      GithubRepoAPI.fetchInfo(username, repo)
        .success((data) ->
          scope.data = data
        )

    template: """
                <div class='github-repo-badge' data-ng-show='data'>
                  <img class='github-repo-badge-avatar' data-ng-src="{{data.owner.avatar_url + 'size=30'}}" />
                  <strong class='github-repo-badge-name' data-ng-bind='data.name'></strong>
                  <div class='github-repo-badge-description' data-ng-bind='data.description'></div>
                  <i class='fa fa-star fa-fw'></i>
                  <span class='github-repo-badge-stars' data-ng-bind='data.stargazers_count'></span><br/>
                  <i class='fa fa-exclamation fa-fw'></i>
                  <span class='github-repo-badge-issues' data-ng-bind='data.open_issues'></span>
                </div>
              """
  }

# Given a github username and repo name, it fetches the json
# metadata about the repository
angular.module('starter-app.data').factory 'GithubRepoAPI', ($http) ->
  fetchInfo: (username, repoName) ->
    $http.get("https://api.github.com/repos/#{username}/#{repoName}")
