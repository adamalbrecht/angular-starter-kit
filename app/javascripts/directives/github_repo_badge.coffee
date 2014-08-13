# Given a github username and repo name, it displays the repo's
# Stars, Watcher count, primary language, open issue count,
# fork count, avatar, etc
angular.module('starter-app.github').directive 'githubRepoBadge', (GithubAPI) ->
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
      GithubAPI.fetchRepoInfo(username, repo).then(
        (data) -> scope.data = data
        (errMsg) -> scope.errorMessage = errMsg
      )

    template: """
                <div class='github-repo-badge' data-ng-show='data'>
                  <span class='github-repo-badge-error' data-ng-bind='errorMessage'></span>
                  <div class='github-repo-badge-content' ng-hide='errorMessage'>
                    <img class='github-repo-badge-avatar' ng-if='data.owner.avatar_url' data-ng-src="{{data.owner.avatar_url + 'size=30'}}" />
                    <strong class='github-repo-badge-name' data-ng-bind='data.name'></strong>
                    <div class='github-repo-badge-description' data-ng-bind='data.description'></div>
                    <i class='fa fa-star fa-fw'></i>
                    <span class='github-repo-badge-stars' data-ng-bind='data.stargazers_count'></span><br/>
                    <i class='fa fa-exclamation fa-fw'></i>
                    <span class='github-repo-badge-issues' data-ng-bind='data.open_issues'></span>
                  </div>
                </div>
              """
  }
