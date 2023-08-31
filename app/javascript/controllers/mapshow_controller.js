import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="mapshow"
export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Array
  }

  connect() {
    console.log("Hello form mapshow!")
    mapboxgl.accessToken = this.apiKeyValue
    this.mapshow = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    this.mapshow.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl }))

  }

  #addMarkersToMap() {

      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.mapshow)

  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markerValue.forEach(mark => bounds.extend([ mark.lng, mark.lat ]))
    this.mapshow.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
