# Given a github username and repo name, it fetches the json
# metadata about the repository
angular.module('starter-app.github').factory 'GithubAPI', ($http) ->
  fetchRepoInfo: (username, repoName) ->
    $http.get("https://api.github.com/repos/#{username}/#{repoName}")
