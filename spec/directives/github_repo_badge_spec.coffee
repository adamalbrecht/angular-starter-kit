describe "githubRepoBadge", ->
  beforeEach(angular.mock.module('starter-app.directives'))
  element = undefined
  scope = undefined
  describe 'given a mock github api service', ->
    # This is a mock version of the data that is returned from the Github API
    mockData = {
      name: "Angular.js"
      html_url: "https://github.com/angular/angular.js"
      description: "HTML enhanced for web apps"
      stargazers_count: 23361
      watchers_count: 23361
      open_issues: 1089
      language: "JavaScript"
      owner: {
        login: "angular"
        avatar_url: "https://avatars.githubusercontent.com/u/139426?"
      }
    }
    # Mock the api class, including the promise returned
    mockGithubRepoApi = {
      fetchInfo: (username, repo) ->
        if username == 'angular' && repo == 'angular.js'
          {
            success: (callback) ->
              callback(mockData)
          }
    }
    beforeEach ->
      module ($provide) ->
        $provide.value('GithubRepoAPI', mockGithubRepoApi)
        null

    describe "a github repo badge for 'angular/angular.js'", ->
      beforeEach angular.mock.inject(($compile, $rootScope) ->
        scope = $rootScope
        element = $compile("<div data-github-repo-badge='angular/angular.js'></div>")(scope)
        scope.$digest()
      )
      it 'displays the name and description of the repo', ->
        expect($(element).find('.github-repo-badge-name').text()).toEqual("Angular.js")
        expect($(element).find('.github-repo-badge-description').text()).toEqual("HTML enhanced for web apps")

      it 'displays the star and open issue count', ->
        expect($(element).find('.github-repo-badge-stars').text()).toMatch("23361")
        expect($(element).find('.github-repo-badge-issues').text()).toMatch("1089")

      it 'displays the owner avatar', ->
        expect($(element).find('.github-repo-badge-avatar').attr('src')).toMatch(mockData.owner.avatar_url)
