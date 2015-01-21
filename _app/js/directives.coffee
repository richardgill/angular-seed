'use strict'

# Directives

@angular.module('angularseed.directives', [])
	.directive('appVersion', ['version', (version) ->
		return (scope, elm, attrs) ->
			elm.text(version)
	])
	.directive('appEnvironment', ['environment', (environment) ->
		return (scope, elm, attrs) ->
			elm.text(environment)
	])
