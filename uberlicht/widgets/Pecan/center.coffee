command: "date +\"%A, %b %d\""

refreshFrequency: 8000

render: (output) ->
  "<div class='screen'><div class='holder'><div class='center'>#{output}</div></div></div>"

