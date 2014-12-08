angular.module 'Filters', []
  .filter 'GB' , ->
    (input, fraction = 0) ->
      (input / (1024 * 1024 * 1024)).toFixed(fraction) + 'GB'
