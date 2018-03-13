<script>
import lessonForm from './lessonForm'
import streamForm from './streamForm'
import lessonsList from './lessonsList'
import lessonActionsMixin from '../mixins/lessonActionsMixin'
import axios from 'axios'

export default {
  data: function () {
    return {
      showLessonForm: false,
      currentLesson: null,
      lessons: JSON.parse(gon.lessons),
      stream: gon.stream,
      lensShifters: gon.lens_shifters,
      notice: null,
      noticeType: null,
      streamLoading: false
    }
  },
  mixins: [lessonActionsMixin],
  components: {
    'lesson-form': lessonForm,
    'stream-form': streamForm,
    'lessons-list': lessonsList
  },
  methods: {
    updateStream: function(formObject) {
      this.notice = null
      // console.log(formObject)
      this.streamLoading = true
      // already has token in the stream form
      axios.patch(`/fellow/streams/${this.stream.id}.json`, formObject)
        .then(res => {
          this.streamLoading = false
          this.showNewStream = true
          this.noticeType = 'success'
          this.notice = 'Wohoo! This stream has been successfully updated'
          this.stream = res.data
          // console.log(this.stream.sid)
        }, error => {
          console.log('error', error)

          this.stream.title = formObject.get('stream[title]')
          this.stream.description = formObject.get('stream[description]')
          this.stream.estimated_reading_time = formObject.get('stream[estimated_reading_time]')
          this.stream.guiding_questions = formObject.get('stream[guiding_questions]')
          this.stream.tag_list = formObject.get('stream[tag_list]')
          this.stream.lens_shifter_id = formObject.get('stream[lens_shifter_id]')
          this.stream.published_at = formObject.get('stream[published_at]')
          this.stream.image = formObject.get('stream[image]')
          this.streamLoading = false
          this.noticeType = 'alert'
          this.notice = "Problem updating the stream"
        })
    }
  }
}
</script>
