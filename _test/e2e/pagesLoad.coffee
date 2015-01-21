PageLoads = require(__dirname + '/common/pageLoads').PageLoads

describe 'about page', ->
  it 'should load', ->
    new PageLoads().assertLoads('/#/about')


describe 'diagnostics page', ->
  it 'should load', ->
    new PageLoads().assertLoads('/#/diagnostics')


describe 'privacy page', ->
  it 'should load', ->
    new PageLoads().assertLoads('/#/privacy')


describe 'erms-of-service page', ->
  it 'should load', ->
    new PageLoads().assertLoads('/#/terms-of-service')
