<script>
import _ from 'lodash';
import InfiniteLoading from 'vue-infinite-loading';
import axios from 'axios';

export default {
  name: 'resourceList',
  data: function () {
    return {
      resources: gon.resources,
      sortBy: null,
      icons: gon.icons,
      page: 1
    }
  },
  components: {
    InfiniteLoading,
  },
  computed: {
    sortedResources: function() {
      return _.orderBy(this.resources, this.sortBy)
    }
  },
  methods: {
    infiniteHandler($state) {
      this.page += 1
      // console.log(this.page)
      // this.resources.length / 8 + 1
      axios.get('/library.json?page=' + this.page, 
        {headers: {'Content-Type':  'application/json', responseType: 'json'}})
        .then(res => {
          // console.log(res.data)
          if (res.data.length > 0) {
            this.resources = this.resources.concat(res.data)
            $state.loaded();
          } else {
            $state.complete()
          };  
        }, error => {
          console.log(error)
        })
    }
  },
  created () {
  }
}
</script>