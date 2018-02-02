<script>
import axiosMap from '../axios-map.js';

export default {
  name: 'lensShifterProfileForm',
  data: function () {
    return {
      location: gon.profile.location,
      suggestions: null,
      mapquest_key: gon.mapquest_key,
      isActive: false,
      cursor: -1,
    }
  },
  methods: {
    getLocation: function() {
      this.isActive = false
      if(this.location.length > 4) {
          axiosMap.get('https://open.mapquestapi.com/nominatim/v1/search.php' + '?key=' + gon.mapquest_key + "&format=json" + "&q=" + this.location + "&addressdetails=1").then(res => {
                // console.log(res)
                // console.log('mapquest', gon.mapquest_key)
                this.suggestions = res.data.map(place => {
                  return place.display_name
                })
                this.isActive = true
            })
      } else {
        // console.log('not yet')
      }
    },
    selectPlace: function(index) {
      this.location = this.suggestions[index]
    },
    focus: function () {
      this.isActive = true
    },
    blur: function () {
      setTimeout(() => this.isActive = false, 200)
    },
    keyUp: function (e) {
      e.preventDefault();
      console.log('up')
      if(this.cursor > -1) {
        this.cursor--
        console.log(this.cursor)
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
</script>