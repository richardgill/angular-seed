'use strict'

# Filters

@angular.module('angularseed.filters', []).
	filter('interpolate', ['version', (version) ->
		return (text) ->
			String(text).replace(/\%VERSION\%/mg, version)

	])
