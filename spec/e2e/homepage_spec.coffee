describe "homepage", ->
  beforeEach ->
    browser.get('/#')
  it "has the correct browser title", ->
    expect(browser.getTitle()).toBe('Angular Starter Kit')
  it "has my name in the subtitle", ->
    expect(element(By.css(".jumbotron h3")).getText()).toMatch("Adam Albrecht")
