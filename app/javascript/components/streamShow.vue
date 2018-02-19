<script>

export default {
  data: function () {
    return {
      stream: JSON.parse(gon.stream)
    }
  },
  computed: {
  	resourcesCount: function() {
  		var n = 0
  		this.stream.lessons.forEach(lesson => {
  			n += lesson.resource_items.length
  		})
  		return n
  	}
  }
}
</script>
