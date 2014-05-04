describe "githubRepoDashboard", ->
  beforeEach(angular.mock.module('starter-app'))
  element = undefined
  scope = undefined
  describe 'given a mock github api service', ->
    mockData = {
      name: "Angular.js"
      html_url: "https://github.com/angular/angular.js"
      description: "HTML enhanced for web apps"
      stargazers_count: 23361
      watchers_count: 23361
      language: "JavaScript"
      owner: {
        login: "angular"
        avatar_url: "https://avatars.githubusercontent.com/u/139426?"
      }
    }
    mockGithubRepoApi = {
      fetchInfo: ->
        {
          success: (callback) ->
            callback(mockData)
        }
    }
    beforeEach ->
      module ($provide) ->
        $provide.value('GithubRepoAPI', mockGithubRepoApi)
        null

    describe "Given a github repo dash for 'angular/angular.js'", ->
      beforeEach angular.mock.inject(($compile, $rootScope) ->
        scope = $rootScope
        element = $compile("<div data-github-repo-dashboard username='angular' repo-name='angular.js'></div>")(scope)
        scope.$digest()
      )
      it 'displays the description of the repo', ->
        expect($(element).find('.github-repo-dash-description').text()).toEqual("HTML enhanced for web apps")
