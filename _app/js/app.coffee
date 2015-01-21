'use strict'

appName = 'angularseed'
# Declare app level module which depends on filters, and services
ng = @angular.module(appName, ['ngRoute', 'angularseed.filters', 'angularseed.services', 'angularseed.directives', 'config', 'angularytics', 'geolocation', 'ngResource', 'ui.bootstrap', 'uiGmapgoogle-maps'])
ng = ng.config (['$routeProvider', 'AngularyticsProvider','uiGmapGoogleMapApiProvider', ($routeProvider, AngularyticsProvider, GoogleMapApi) =>
  $routeProvider.
    when('/home', {templateUrl: 'partials/home.html', controller: MyCtrl1}).

    otherwise({redirectTo: '/home'})
  GoogleMapApi.configure({
      key: 'AIzaSyCjNjBbwFf-kxNv7qPz3Q9RtcR4vCvVJd4',
      v: '3.17',
      libraries: 'weather,geometry,visualization'
  })

  AngularyticsProvider.setEventHandlers(['Console', 'GoogleUniversal'])

  return
])

ng.run(['Angularytics', (Angularytics) =>
  Angularytics.init()
])
