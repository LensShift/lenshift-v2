<script>
import axios from 'axios'
import moment from 'moment'

export default {
  data: function () {
    return {
      sortParams: null
    }
  },
  methods: {
    publishNow: function (id, event) {
      event.target.disabled = true
      var meta = document.getElementsByTagName('meta')
      var token = meta['csrf-token'].content
      let now = new Date();
      axios.patch(`/fellow/resource_items/${id}.json`, {'utf8': '✓', authenticity_token: token, resource_item: {published_at: now}}).then(res => {
            console.log(res)
            this.$refs['resourceStatus' + res.data.id].innerHTML = "<span class='label success'>published</span>"
            this.$refs['resourcePublishDate' + res.data.id].innerHTML = moment(res.data.published_at).format('MM/DD/YYYY')
          }, error => {
            console.log(error)
            event.target.disabled = false
          })
    },
    unpublishNow: function (id, event) {
      event.target.disabled = true
      var meta = document.getElementsByTagName('meta')
      var token = meta['csrf-token'].content
      let now = new Date();
      axios.patch(`/fellow/resource_items/${id}.json`, {'utf8': '✓', authenticity_token: token, resource_item: {published_at: ""}}).then(res => {
            console.log(res)
            this.$refs['resourceStatus' + res.data.id].innerHTML = "<button class='button table-button small' v-on:click='publishNow(<%= resource_item.id %>, $event)'>Publish</button>"
            this.$refs['resourcePublishDate' + res.data.id].innerHTML = ""
          }, error => {
            console.log(error)
            event.target.disabled = false
          })
    }
  },
  created () {
    const windowPath = new URL(window.location.href)
    this.sortParams = windowPath.searchParams.get("sort")

  }
}
</script>
