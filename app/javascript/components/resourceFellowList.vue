<script>
import axios from 'axios'

export default {
  data: function () {
    return {
    }
  },
  methods: {
    publishNow: function (id, token) {
      let now = new Date();
      axios.patch(`/fellow/resource_items/${id}.json`, {'utf8': '✓', authenticity_token: token, resource_item: {published_at: now}}).then(res => {
        // console.log(res)
        this.$refs['resource' + res.data.id].innerHTML = "<span class='label success'>published</span>"
      }, error => {
        console.log(error)
      })
    }
  }
}
</script>
