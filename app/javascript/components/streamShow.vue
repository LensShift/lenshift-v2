<script>

export default {
  data: function () {
    return {
      stream: JSON.parse(gon.stream),
      currentLesson: null,
      activeLessonIndex: 0,
      currentResource: null,
      safeURL: null
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
  },
  methods: {
    showResource: function (resource) {
      this.currentResource = resource
      let resourceURL = new URL(resource.source_url)
      this.safeURL = resourceURL.protocol === 'https:'
      
    },
    showLesson: function (lesson, index) {
      this.currentLesson = lesson
      this.activeLessonIndex = index
    }
  },
  created () {
    const currentStream = JSON.parse(gon.stream)
    this.stream = currentStream
    this.currentLesson = currentStream.lessons[0]
    this.currentResource = this.currentLesson.resource_items[0]
    let resourceURL = new URL(this.currentResource.source_url)
    this.safeURL = resourceURL.protocol === 'https:'
  }
}
</script>
