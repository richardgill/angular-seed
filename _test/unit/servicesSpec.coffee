describe 'service', ->
  beforeEach module('angularseed.services')

  describe 'version123', ->
    it 'should return current version', inject (version123) ->
      expect(version123).toEqual('123')
