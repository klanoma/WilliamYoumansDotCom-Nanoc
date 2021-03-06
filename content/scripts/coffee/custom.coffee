animation_effect = "drop"
animation_speed = "slow"

changePage = (new_url) ->
  return  if $("body").attr("id") is new_url
  $("#content_ajax").stop(false, true).toggle animation_effect, animation_speed, ->

    extension = ".html"
    extension = ".php"  if new_url is "photos"
    $.get "/ajax/" + new_url + extension, (data) ->
      $("body").attr "class", new_url
      $("#content_ajax").html(data).toggle animation_effect, animation_speed, ->
        initiateToolTips()

  _gaq.push ["_trackPageview", new_url + "/"]  if typeof _gaq isnt "undefined"

initiateToolTips = () ->
  $(".tooltip").tipsy
    fade: true
    gravity: "w"

$ ->
  initiateToolTips()

  History = window.History
  History.Adapter.bind window, "statechange", ->
    State = History.getState()
    next_page = State.url.replace(/(.*\.com|.*:3000)/, "").replace(/\//g, "")
    next_page = "index"  if next_page is ""
    changePage next_page

  $("nav a, a.logo").click (e) ->
    e.preventDefault()
    change_url = $(this).data("url")
    new_title = "Web Developer, World Traveler"
    if change_url is "index"
      change_url = ""
    else
      new_title = change_url.charAt(0).toUpperCase() + change_url.slice(1)
      change_url = change_url + "/"
    History.pushState change_url, document.title.replace(/^(.*)\|.*$/, "$1 | ") + new_title, "/" + change_url

