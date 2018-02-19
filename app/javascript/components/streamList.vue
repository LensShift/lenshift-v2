<script>
import _ from 'lodash';

export default {
  data: function () {
    return {
      streams: JSON.parse(gon.streams),
      sortBy: null
    }
  },
  computed: {
    sortedStreams: function() {
      return _.orderBy(this.streams, this.sortBy)
    }
  },
  methods: {
    syllabusShow: function(id) {

      console.log(this.$refs['streamFrame' + id][0].style.display)

      if (this.$refs['streamFrame' + id][0].style.display === 'none') {
          this.$refs['streamImage' + id][0].style.display = 'none'
          this.$refs['streamFrame' + id][0].style.display = 'block'
      } else {
          this.$refs['streamImage' + id][0].style.display = 'block'
          this.$refs['streamFrame' + id][0].style.display = 'none'
      }
    }
  }
}
</script>
