<script>
import streamForm from './streamForm'
import lessonForm from './lessonForm'
import Velocity from 'velocity-animate'
import 'velocity-animate/velocity.ui'

export default {
  components: {
    'stream-form': streamForm,
    'lesson-form': lessonForm
  },
  data: function () {
    return {
      showNewStream: false,
      stream: {
        title: "New Stream",
        description: null,
        estimated_reading_time: null,
        guiding_questions: null,
        tags: null,
        lens_shifter: null,
        id: null,
        lessons: []
      },
      component: 'stream-form'
    }
  },
  methods: {
    newStream: function(object) {
      console.log(object)
      this.component = 'lesson-form'
      this.showNewStream = true
      this.stream = object.data
      console.log(this.stream.id)
    },
    addLesson: function(object) {
      this.component = 'lesson-form'
      this.showNewStream = true
      this.stream.lessons.push(object.data)
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
