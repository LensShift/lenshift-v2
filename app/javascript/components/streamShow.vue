<script>
import streamOverview from './streamOverview'
import streamResource from './streamResource'
import axios from 'axios'

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
      currentResource: null,
      resourceLoading: false
    }
  },
  components: {
    'stream-overview': streamOverview,
    'stream-resource': streamResource
  },
  computed: {
  	
  },
  methods: {
    showResource: function (index) {
      this.currentResource = this.resources[index]
      let resourceURL = new URL(this.currentResource.source_url)
      this.activeResourceIndex = index
    },
    showLesson: function (lesson, index, lesson_id) {
      this.resourceLoading = true
      axios.get(`/streams/${this.stream.id}/lessons/${lesson_id}`)
        .then(res => {
          // console.log(res)
          this.resources = res.data
          this.currentLesson = lesson
          this.currentResource = this.resources[0]
          this.activeResourceIndex = 0
          this.activeLessonIndex = index
          this.resourceLoading = false
        }, error => {
          console.log(error)
        })


    }
  },
  created () {
    console.log(gon)
    // this.currentLesson = this.stream.lessons[0]
    this.currentResource = this.resources[0]

  }
}
</script>
