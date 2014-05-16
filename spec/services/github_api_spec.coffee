describe "Github Repo Badge Directive", ->
  GithubAPI = null
  $httpBackend = null
  mockGithubApiResponse = {
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


  beforeEach(angular.mock.module('starter-app.github'))
  beforeEach(inject((_GithubAPI_, _$httpBackend_) ->
    GithubAPI = _GithubAPI_
    $httpBackend = _$httpBackend_
    return # Coffeescript's implicit returns can cause issues when using DI in angular tests
  ))

  describe '#fetchRepoInfo', ->
    it 'pulls data from the github api', ->
      $httpBackend.expect('GET', 'https://api.github.com/repos/angular/angular.js').respond(200, mockGithubApiResponse)

      GithubAPI.fetchRepoInfo("angular", "angular.js").then(
        (resp) ->
          expect(resp.data.name).toEqual("Angular.js")
      )
      $httpBackend.flush()
