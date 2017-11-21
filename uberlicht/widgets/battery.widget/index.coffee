# appearance
filledStyle  = false # set to true for the second style variant. bgColor will become the text color

width        = '367px'
barHeight    = '36px'
labelColor   = '#fff'
dchgColor    = '#d7051d'
chrgColor    = '#1dd705'
freeColor    = '#525252'
bgColor      = '#fff'
borderRadius = '3px'
bgOpacity    = 0.9

command: "pmset -g batt | grep -o '[0-9]*%; [a-z]*'"

refreshFrequency: 5000

style: """
  // Change bar height
  bar-height = 6px

  // Align contents left or right
  widget-align = left

  // Position this where you want
  top 30px
  left 72.5%

  // Statistics text settings
  color #fff
  font-family Helvetica Neue
  background rgba(#000, .5)
  padding 10px 10px 15px
  border-radius 5px

  .container
    width: 300px
    text-align: widget-align
    position: relative
    clear: both

  .container:not(:first-child)
    margin-top: 20px

  .widget-title
    text-align: widget-align

  .stats-container
    margin-bottom 5px
    border-collapse collapse

  td
    font-size: 14px
    font-weight: 300
    color: rgba(#fff, .9)
    text-shadow: 0 1px 0px rgba(#000, .7)
    text-align: widget-align

  td.pctg
    float: right

  .widget-title, p
    font-size 10px
    text-transform uppercase
    font-weight bold

  .label
    font-size 8px
    text-transform uppercase
    font-weight bold

  .bar-container
    width: 100%
    height: bar-height
    border-radius: bar-height
    float: widget-align
    clear: both
    background: rgba(#fff, .5)
    position: absolute
    margin-bottom: 5px

  .bar
    height: bar-height
    float: widget-align
    transition: width .2s ease-in-out

  .bar:first-child
    if widget-align == left
      border-radius: bar-height 0 0 bar-height
    else
      border-radius: 0 bar-height bar-height 0

  .bar:last-child
    if widget-align == right
      border-radius: bar-height 0 0 bar-height
    else
      border-radius: 0 bar-height bar-height 0

  .bar-discharging
    background: rgba(#d7051d, 0.5)

  .bar-charging
    background: rgba(#1dd705, 0.5)
"""

getChargeColor: (status) -> 'bar-'+status

renderInfo: (status, used, free, pctg, name) -> """
  <div class="container">
    <div class="widget-title">#{name}</div>
    <table class="stats-container" width="100%">
      <tr>
        <td class="stat"><span class="used">#{used}</span></td>
        <td class="stat pctg"><span class="pctg">#{free}%</span></td>
      </tr>
      <tr>
        <td class="label">used</td>
        <td class="label pctg">free</td>
      </tr>
    </table>
    <div class="bar-container">
      <div class="bar #{@getChargeColor(status)}" style="width: #{pctg}%;"></div>
    </div>
  </div>
"""

update: (output, domEl) ->
  values = output.split(';')
  percent = values[0]
  status = values[1].replace(' ', '').replace('\n', '')

  $(domEl).html ''
  $(domEl).append @renderInfo(status, percent, 100-parseInt(percent), parseInt(percent), "Battery")
  $(domEl).append ''
