class HomeController
  constructor: (@geolocation, @location, @endpoint, @http) ->
    @value1 = "Value 1" 
   
    
angular.module('angularseed').controller 'HomeController', ['geolocation', '$location', 'endpoint', '$http', HomeController] 
