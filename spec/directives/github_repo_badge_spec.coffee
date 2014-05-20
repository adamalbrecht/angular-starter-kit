describe "Github Repo Badge Directive", ->
  element = null
  scope = null
  $compile = null
  $q = null

  mockRepoData = {
    "angular/angular.js": {
      name: "Angular.js"
      html_url: "https://github.com/angular/angular.js"
      description: "HTML enhanced for web apps"
      stargazers_count: 23361
      watchers_count: 23361
      open_issues: 1089
      language: "JavaScript"
      owner: {
        login: "angular"
        avatar_url: "test.png"
      }
    }
  }

  mockGithubApi = {
    fetchRepoInfo: (username, repo) ->
      d = $q.defer()
      repo = mockRepoData["#{username}/#{repo}"]
      if repo
        d.resolve(repo)
      else
        d.reject("Repo Not Found")
      d.promise
  }
  beforeEach ->
    spyOn(mockGithubApi, "fetchRepoInfo").and.callThrough()

  describe 'with a mock github api', ->
    beforeEach(angular.mock.module('starter-app.github', ($provide) ->
      $provide.value('GithubAPI', mockGithubApi)
      return # Coffeescript's implicit returns can cause issues when using DI in angular tests
    ))
    beforeEach(inject((_$compile_, $rootScope, _$q_) ->
      scope = $rootScope
      $compile = _$compile_
      $q = _$q_
      return # Coffeescript's implicit returns can cause issues when using DI in angular tests
    ))
    describe 'and the directive is compiled for angular.js', ->
      beforeEach ->
        element = angular.element("<div data-github-repo-badge='angular/angular.js'></div>")
        $compile(element)(scope)
        scope.$digest()
      it "calls the repo's fetchRepoInfo method", ->
        expect(mockGithubApi.fetchRepoInfo).toHaveBeenCalledWith('angular', 'angular.js')

      describe "The content in the html", ->
        it 'is visible', ->
          expect($(element).find('.github-repo-badge-content').hasClass('ng-hide')).toBeFalsy()
        it "matches the data from the api", ->
          expect($(element).find('.github-repo-badge-name').text()).toEqual('Angular.js')
          expect($(element).find('.github-repo-badge-description').text()).toEqual('HTML enhanced for web apps')
          expect($(element).find('.github-repo-badge-stars').text()).toEqual('23361')
          expect($(element).find('.github-repo-badge-issues').text()).toEqual('1089')
          expect($(element).find('.github-repo-badge-avatar').attr('src')).toMatch('test.png')

    describe 'and the directive is compiled with a bad repo', ->
      beforeEach ->
        element = angular.element("<div data-github-repo-badge='badusername/badrepo'></div>")
        $compile(element)(scope)
        scope.$digest()

      it "still calls the repo's fetchRepoInfo method", ->
        expect(mockGithubApi.fetchRepoInfo).toHaveBeenCalledWith('badusername', 'badrepo')
      describe "The content in the html", ->
        it 'is not visible', ->
          expect($(element).find('.github-repo-badge-content').hasClass('ng-hide')).toBeTruthy()

        it 'displays the error message', ->
          expect($(element).find('.github-repo-badge-error').text()).toEqual("Repo Not Found")
