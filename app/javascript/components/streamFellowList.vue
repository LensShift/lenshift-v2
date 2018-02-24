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
      axios.patch(`/fellow/streams/${id}.json`, {'utf8': '✓', authenticity_token: token, stream: {published_at: now}}).then(res => {
        // console.log(res)
        this.$refs['stream' + res.data.id].innerHTML = "<span class='label success'>published</span>"
      }, error => {
        console.log(error)
      })
    }
  }
}
</script>