<script>
import axios from 'axios'
import streamForm from './streamForm'
import lessonForm from './lessonForm'
import lessonsList from './lessonsList'
import moment from 'moment'
import lessonActionsMixin from '../mixins/lessonActionsMixin'
import Velocity from 'velocity-animate'
import 'velocity-animate/velocity.ui'

export default {
  components: {
    'stream-form': streamForm,
    'lesson-form': lessonForm,
    'lessons-list': lessonsList
  },
  mixins: [lessonActionsMixin],
  data: function () {
    return {
      showNewStream: false,
      showLessonForm: false,
      streamLoading: false,
      currentLesson: null,
      lensShifters: gon.lens_shifters,
      stream: {
        title: "New Stream",
        description: null,
        estimated_reading_time: null,
        guiding_questions: null,
        tag_list: null,
        lens_shifter_id: null,
        id: null,
        published_at: null,
        image: null,
      },
      lessons: [],
      notice: null
    }
  },
  computed: {
    lensShifterName: function() {
      return this.lensShifters.find(lens => {
        return lens.id === this.stream.lens_shifter_id
      }).full_name
    }
  },
  methods: {
    newStream: function(formObject) {
      // console.log(formObject)
      this.streamLoading = true
      // already has token in the stream form
      axios.post('/fellow/streams', formObject)
        .then(res => {
          this.streamLoading = false
          this.showNewStream = true
          this.stream = res.data
          // console.log(this.stream.sid)
        }, error => {
          console.log(error)

          this.stream.title = formObject.get('stream[title]')
          this.stream.description = formObject.get('stream[description]')
          this.stream.estimated_reading_time = formObject.get('stream[estimated_reading_time]')
          this.stream.guiding_questions = formObject.get('stream[guiding_questions]')
          this.stream.tag_list = formObject.get('stream[tag_list]')
          this.stream.lens_shifter_id = formObject.get('stream[lens_shifter_id]')
          this.stream.published_at = formObject.get('stream[published_at]')
          this.stream.image = formObject.get('stream[image]')
          this.streamLoading = false
          this.showNewStream = false
          this.noticeType = 'alert'
          let field = Object.keys(error.response.data.errors)
          this.notice = `${field} ${error.response.data.errors[field]}`
        })

    },
    beforeEnter: function(el) {
      el.style.opacity = 0
    },
    beforeFormEnter: function(el) {
      el.style.opacity = 0
    },
    enter: function(el, done) {
      Velocity(el, "transition.slideRightBigIn", {delay: 500}, {duration: 500}, {drag: true}, {complete: done})
    },
    formEnter: function(el, done) {
      Velocity(el, "transition.fadeIn", {delay: 500}, {duration: 500}, {drag: false}, {complete: done})
    },
    formLeave: function(el, done) {
      Velocity(el, "transition.slideRightBigOut", {duration: 490}, {complete: done}) 
    }
  }
}
</script>
