command: "date +\"%I:%M %p\""

refreshFrequency: 10000 # ms

render: (output) ->
  # "<div class='screen'><div class='right'>✮ #{output}</div></div>"
  "<div class='screen'><div class='right'> #{output}</div></div>"

