<script>
import _ from 'lodash';

export default {
  name: 'resourceList',
  data: function () {
    return {
      resources: gon.resources,
      sortBy: null,
      icons: gon.icons
    }
  },
  computed: {
    sortedResources: function() {
      return _.orderBy(this.resources, this.sortBy)
    }
  }
}
</script>