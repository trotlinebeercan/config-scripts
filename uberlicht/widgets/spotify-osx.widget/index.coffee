
options =
  widgetEnable: true

command: "osascript spotify-osx.widget/spotify.applescript"

refreshFrequency: "1s"

style: """
  background: rgba(#000, 0.5)
  color: #FFFFFF
  font-family: Helvetica Neue
  width: 50%
  height: 50%

  padding 10px 10px 15px
  border-radius 5px

  margin: 0
  position: absolute
  top: 16%
  left: 25%

  .wrapper
    display: flex
    height: 100%

  .image
    position: relative
    width: 50%
    display: flex
    align-items: center

  .image img
    display: block
    margin: auto
    padding: 10px 10px 15px
    border-radius: 5px
    background-color: rgba(#000, 0.2)

  .artist
    font-size: 1.5em
    font-weight: 100
    color: white
    align-self: center
    flex-grow: 1
    text-align: center
    display: flex
    flex-direction: column
    height: 50%

  .name, .title, .album
    height: 100%
    display: flex
    align-content: center
    justify-content: center
    //border: 2px solid white

  .buttons
    height: 100%
    text-align: center
    display: flex
    justify-content: space-around
    align-items: center

  .buttons > button
    width: 70px
    height: 70px
    background-size: 100% 100%
    background-repeat: no-repeat
    background-color: rgba(#bbb, 0.2)
    padding: 10px 10px 15px
    border: 1px solid gray
    border-radius: 5px

  .buttons > button:hover
    background-color: rgba(#fff, 0.2)

  .buttons > button:active
    background-color: rgba(#fff, 0.4)

  #btn-prev
    background-image: url('spotify-osx.widget/images/prev.png')

  #btn-stop
    background-image: url('spotify-osx.widget/images/pause.png')

  #btn-play
    background-image: url('spotify-osx.widget/images/play.png')

  #btn-next
    background-image: url('spotify-osx.widget/images/next.png')

"""

render: (output) ->
  widgetHtml = "
    <div class='wrapper'>
      <div class='image'></div>
      <div class='artist'>
        <div class='name'></div>
        <div class='title'></div>
        <div class='album'></div>
      </div>
    </div>"

  return widgetHtml

update: (output, domEl) ->
  metadata = output.split("`")
  artist   = metadata[0]
  title    = metadata[1]
  album    = metadata[2]
  id       = metadata[3]

  div = $(domEl)

  div.find('.artist').find('.name').html('<p>' + artist + '</p>')
  div.find('.artist').find('.title').html('<p>' + title + '</p>')
  div.find('.artist').find('.album').html('<p>' + album + '</p>')

  response = JSON.parse metadata[4]
  image    = response.album.images[0]
  imageUrl = image.url
  imageW   = image.width / 2
  imageH   = image.height / 2

  div.find('.image').html('<img width="' + imageW + '" height="' + imageH + '" src="' + imageUrl + '" />')

  #$("#btn-prev").on "click", (event) ->
  #  run('osascript -e \'tell app "Spotify" to previous track\'', (error) -> refresh())

  #$("#btn-stop").on "click", (event) ->
  #  run('osascript -e \'tell app "Spotify" to pause\'', (error) -> refresh())

  #$("#btn-play").on "click", (event) ->
  #  run('osascript -e \'tell app "Spotify" to play\'', (error) -> refresh())

  #$("#btn-next").on "click", (event) ->
  #  run('osascript -e \'tell app "Spotify" to next track\'', (error) -> refresh())
















