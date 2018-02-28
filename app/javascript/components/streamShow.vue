<script>

export default {
  data: function () {
    return {
      stream: JSON.parse(gon.stream),
      currentLesson: null,
      activeLessonIndex: 0,
      activeResourceIndex: 0,
      currentResource: null,
      safeURL: null,
      origin: null
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
    showResource: function (resource, index) {
      this.currentResource = resource
      let resourceURL = new URL(resource.source_url)
      this.activeResourceIndex = index
      this.safeURL = resourceURL.protocol === 'https:'
      this.origin = resourceURL.origin
    },
    showLesson: function (lesson, index) {
      this.currentLesson = lesson
      this.currentResource = this.currentLesson.resource_items[0]
      this.activeResourceIndex = 0
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
