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
      page: 1,
      currentTag: null
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
      var currentParams = this.parsedQueryString()

      if(Object.keys(currentParams)[0] === 'tag') {
        axios.get('/library.json?page=' + this.page + '&tag=' + currentParams.tag, 
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
      } else {
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
    parsedQueryString: function() {
      var queryString = window.location.search.substring(1);
      var params = {}, queries, temp, i, l;
        // Split into key/value pairs
      queries = queryString.split("&");
        // Convert the array of strings into an object
      for ( i = 0, l = queries.length; i < l; i++ ) {
            temp = queries[i].split('=');
            params[temp[0]] = temp[1];
      }
      return params;
    }
  },
  created () {
    var currentParams = this.parsedQueryString()
    this.currentTag = currentParams.tag.split("+").join(" ")
  } 
}
</script>