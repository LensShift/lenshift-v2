import axios from 'axios'

export default {
  data: function () {
    return {
      location: null,
      suggestions: null,
      address: null,
      isActive: false,
      cursor: -1,
      city: null,
      state: null,
      country: null
    }
  },
  methods: {
    getLocation: function() {
      this.isActive = false
      if(this.location.length > 4) {
          axios.get('https://open.mapquestapi.com/nominatim/v1/search.php' + '?key=' + gon.mapquest_key + "&format=json" + "&q=" + this.location + "&addressdetails=1")
            .then(res => {
                // console.log(res)
                // console.log('mapquest', gon.mapquest_key)
                this.suggestions = res.data.map(place => {
                  return { 'name': place.display_name, 'address': place.address }
                })
                this.isActive = true
            })
      } else {
        // console.log('not yet')
      }
    },
    selectPlace: function(index) {
      this.location = this.suggestions[index].name
      this.address = JSON.stringify(this.suggestions[index].address)
    },
    focus: function () {
      this.isActive = true
    },
    blur: function () {
      setTimeout(() => this.isActive = false, 200)
    },
    keyUp: function (e) {
      e.preventDefault();
      // console.log('up')
      if(this.cursor > -1) {
        this.cursor--
        // console.log(this.cursor)
        // console.log(this.$el.getElementsByClassName('select-option-item')[this.cursor])
        this.selectPlace(this.cursor)
        this.itemView(this.$el.getElementsByClassName('select-option-item')[this.cursor])
      } else {
        this.cursor = this.suggestions.length - 1
        // console.log(this.$el.getElementsByClassName('select-option-item')[this.cursor])
        this.selectPlace(this.cursor)
        this.itemView(this.$el.getElementsByClassName('select-option-item')[this.cursor])
      }
    },
    keyDown: function (e) {
      // console.log('down')
      this.isActive = true
      if (this.cursor < this.suggestions.length -1) {
        this.cursor++
        // console.log(this.cursor)
        // console.log(this.$el.getElementsByClassName('select-option-item')[this.cursor])
        this.selectPlace(this.cursor)
        this.itemView(this.$el.getElementsByClassName('select-option-item')[this.cursor])
      } else {
        this.cursor = -1
      }
    },
    itemView (item) {
      if(item && item.scrollIntoView) {
        item.scrollIntoView(false)
      }
    },
    keyEnter: function (e) {
      e.preventDefault();
      if (this.isActive && this.suggestions[this.cursor]) {
        this.selectPlace(this.cursor)
        this.isActive = false
      }
    }

  }
}