describe 'diagnostics page', ->

  it 'should have environment == test', ->
        # Load the AngularJS homepage.
    browser.get('/#/diagnostics')
    expect(element(By.id('environment')).getText()).
      toEqual('test')
