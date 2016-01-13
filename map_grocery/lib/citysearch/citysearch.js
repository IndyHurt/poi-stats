// (c) 2015 Mapzen
//
// MAP UI · CITY SEARCH
//
// ----------------------------------------------------------------------------
/* global jQuery, select2 */

var $ = require('jquery')
var select2 = require('Select2')

module.exports = (function () {
  'use strict'

  // Exit if demo is iframed.
  // if (window.self !== window.top) return false

  var SELECT2_STYLESHEET = '//cdnjs.cloudflare.com/ajax/libs/select2/4.0.0/css/select2.min.css'
  var STYLESHEET = '//s3.amazonaws.com/assets-staging.mapzen.com/ui/components/citysearch/citysearch.min.css'
  var CITY_DATA_URL = '//s3.amazonaws.com/assets-staging.mapzen.com/ui/components/citysearch/cities.json'
  var CITY_DATA

  var CITY_SELECT_PLACEHOLDER_TEXT = 'Search for city'

  function _loadExternalStylesheet (stylesheetUrl) {
    var el = document.createElement('link')
    el.setAttribute('rel', 'stylesheet')
    el.setAttribute('type', 'text/css')
    el.setAttribute('href', stylesheetUrl)
    document.head.appendChild(el)
  }

  function _createElsAndAppend () {
    // Create city locator
    var el = document.createElement('div')
    var selectEl = document.createElement('select')
    var optionEl = document.createElement('option')
    var optionText = document.createTextNode(CITY_SELECT_PLACEHOLDER_TEXT)

    optionEl.setAttribute('disabled', '')
    optionEl.setAttribute('selected', '')
    optionEl.appendChild(optionText)

    selectEl.className = 'js--mz-citysearch-select2'
    selectEl.appendChild(optionEl)

    el.id = 'mz-citysearch'
    el.className = 'mz-citysearch'
    el.appendChild(selectEl)

    document.body.appendChild(el)
    return el
  }

  function _adjustLeafletUI() {
    var el = document.createElement('style')
    var css = '.leaflet-top.leaflet-left { top: 72px; }'
    el.type = 'text/css'
    el.appendChild(document.createTextNode(css))
    document.head.appendChild(el)
  }

  _loadExternalStylesheet(SELECT2_STYLESHEET)
  _loadExternalStylesheet(STYLESHEET)
  var el = _createElsAndAppend()
  _adjustLeafletUI()

  $.get(CITY_DATA_URL, function (data) {
    // Process data
    CITY_DATA = data.map(function (item) {
      return {
        name: item.n,
        lat: item.l.split('/')[0],
        lng: item.l.split('/')[1],
        zoom: item.z
      }
    })

    $(document).ready(function () {
      var $select = $('.js--mz-citysearch-select2');
      CITY_DATA.forEach(function (item) {
        $select.append('<option value="' + item.name + '" data-lat="' + item.lat + '" data-lng="' + item.lng + '" data-zoom="' + item.zoom + '">' + item.name + '</option>')
      })

      $select.select2({
        placeholder: 'Search'
      })

      // Add a class to set it to the expanded state
      $select.on('select2:opening', function (e) {
        el.classList.add('js--mz-citysearch-expanded')
      })

      $select.on('select2:close', function (e) {
        el.classList.remove('js--mz-citysearch-expanded')
      })

      // Input into the search field should not bubble up and
      // interact with other GUIs inserted onto page.
      // Example: dat-gui listens for 'h' key to hide the UI
      $select.on('select2:open', function (e) {
        $('.select2-search__field').on('keydown', function (e) {
          e.stopPropagation()
        })
      })

      $select.on('select2:select', function (e) {
        /* global map */
        var el = e.params.data.element
        var lat = el.dataset.lat
        var lng = el.dataset.lng
        var zoom = (el.dataset.zoom === 'undefined') ? null : el.dataset.zoom
        if (zoom) {
          map.setView([lat, lng], zoom)
        } else {
          map.setView([lat, lng])
        }
      })
    })
  })
})()
