# Given a github username and repo name, it fetches the json
# metadata about the repository
angular.module('starter-app.github').factory 'GithubAPI', ($http, $cacheFactory, $q) ->
  repoCache = $cacheFactory('github-repositories')
  fetchRepoInfo: (username, repoName) ->
    cacheKey = "#{username}/#{repoName}"
    deferred = $q.defer()
    promise = deferred.promise
    cached = repoCache.get(cacheKey)
    if cached
      deferred.resolve(cached)
    else
      $http.get("https://api.github.com/repos/#{username}/#{repoName}").then(
        (data) ->
          repoCache.put(cacheKey, data.data)
          deferred.resolve(data.data)
        (err) ->
          deferred.reject(err)
      )
    return promise
