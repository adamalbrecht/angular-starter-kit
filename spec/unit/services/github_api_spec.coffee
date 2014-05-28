describe "Github Repo Badge Directive", ->
  GithubAPI = null
  $httpBackend = null
  $rootScope = null
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


  # Inject and/or mock our dependencies
  beforeEach(angular.mock.module('starter-app.github'))
  beforeEach(inject((_GithubAPI_, _$httpBackend_, _$rootScope_) ->
    # Note: Surrounding underscores are ignored by the dependency injector. This allows us to use the original names in our code.
    GithubAPI = _GithubAPI_
    $httpBackend = _$httpBackend_
    $rootScope = _$rootScope_
    return # Coffeescript's implicit returns can cause issues when using DI in angular tests
  ))

  describe '#fetchRepoInfo', ->
    it 'pulls data from the github api', ->
      $httpBackend.expect('GET', 'https://api.github.com/repos/angular/angular.js').respond(200, mockGithubApiResponse)
      onFetch = {
        run: (resp) ->
          expect(resp.name).toEqual("Angular.js")
      }
      spyOn(onFetch, 'run').and.callThrough()
      GithubAPI.fetchRepoInfo("angular", "angular.js").then(onFetch.run)
      $httpBackend.flush() # This must be run in our tests order to complete our fake http requests.
      expect(onFetch.run).toHaveBeenCalled()

    describe 'Given a request for a repo has been made', ->
      beforeEach ->
        $httpBackend.when('GET', 'https://api.github.com/repos/angular/angular.js').respond(200, mockGithubApiResponse)
        GithubAPI.fetchRepoInfo("angular", "angular.js")
        $httpBackend.flush()

      it 'will cache a 2nd request for the same repo', ->
        $httpBackend.when('GET', 'https://api.github.com/repos/angular/angular.js').respond(200, {name: 'bad repo'})
        onFetch = {
          run: (resp) ->
            expect(resp.name).toEqual("Angular.js")
        }
        spyOn(onFetch, 'run').and.callThrough()
        GithubAPI.fetchRepoInfo("angular", "angular.js").then(onFetch.run)
        # TODO: I'm not sure why this needs to be called and why it always fails, but if I don't flush the $httpBackend, the promise never resolves.
        try
          $httpBackend.flush()
        catch err
        expect(onFetch.run).toHaveBeenCalled()
        $httpBackend.verifyNoOutstandingRequest()

      it 'will not cache a request for another repo', ->
        $httpBackend.expect('GET', 'https://api.github.com/repos/rails/rails').respond(200, {name: 'Ruby on Rails'})
        onFetch = {
          run: (resp) ->
            expect(resp.name).toEqual("Ruby on Rails")
        }
        spyOn(onFetch, 'run').and.callThrough()
        GithubAPI.fetchRepoInfo("rails", "rails").then(onFetch.run)
        $httpBackend.flush()
        expect(onFetch.run).toHaveBeenCalled()
