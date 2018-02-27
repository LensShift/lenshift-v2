<script>
import axios from 'axios'
import moment from 'moment'

export default {
  data: function () {
    return {
    }
  },
  methods: {
    publishNow: function (id) {
      const meta = document.getElementsByTagName('meta')
      let token = meta['csrf-token'].content
      let now = new Date();
      axios.patch(`/fellow/streams/${id}.json`, {'utf8': '✓', authenticity_token: token, stream: {published_at: now}}).then(res => {
        console.log(res)
        this.$refs['streamStatus' + res.data.id].innerHTML = "<span class='label success'>published</span>"
        this.$refs['streamPublishDate' + res.data.id].innerHTML = moment(res.data.published_at).format('MM/DD/YYYY')
      }, error => {
        console.log(error)
      })
    }
  }
}
</script>