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
      let token = this.$refs.indexTable.getAttribute("token")
      let now = new Date();
      axios.patch(`/fellow/resource_items/${id}.json`, {'utf8': '✓', authenticity_token: token, resource_item: {published_at: now}}).then(res => {
        console.log(res)
        this.$refs['resourceStatus' + res.data.id].innerHTML = "<span class='label success'>published</span>"
        this.$refs['resourcePublishDate' + res.data.id].innerHTML = moment(res.data.published_at).format('MM/DD/YYYY')
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
