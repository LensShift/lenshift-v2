<script>
import Velocity from 'velocity-animate'
import 'velocity-animate/velocity.ui'

export default {
  data: function () {
    return {
      showMenu: false
    }
  },
  methods: {
    openMenu: function (el, done) {
      Velocity(el, {left: 0}, {duration: 900}, {complete: done})
    },
    closeMenu: function (el, done) {
      Velocity(el, {left: 1400}, {duration: 1000}, {complete: done})
    }
  }
}
</script>
