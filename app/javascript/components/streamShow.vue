<script>
import streamOverview from './streamOverview'
import streamResource from './streamResource'

export default {
  data: function () {
    return {
      stream: gon.stream,
      lessonsCount: gon.lessons.length + 1,
      resourcesCount: gon.resourcesCount,
      resources: gon.firstResources,
      lessons: gon.lessons,
      currentLesson: gon.lessons[0],
      activeLessonIndex: 0,
      activeResourceIndex: 0,
      currentResource: null
    }
  },
  components: {
    'stream-overview': streamOverview,
    'stream-resource': streamResource
  },
  computed: {
  	
  },
  methods: {
    showResource: function (resource, index) {
      // this.currentResource = resource
      // let resourceURL = new URL(resource.source_url)
      // this.activeResourceIndex = index
      // this.safeURL = resourceURL.protocol === 'https:'
      // this.origin = resourceURL.origin
    },
    showLesson: function (lesson, index) {
      this.currentLesson = lesson
      this.currentResource = this.currentLesson.resource_items[0]
      this.activeResourceIndex = 0
      this.activeLessonIndex = index
    }
  },
  created () {
    console.log(gon)
    // this.currentLesson = this.stream.lessons[0]
    this.currentResource = this.resources[0]

  }
}
</script>
