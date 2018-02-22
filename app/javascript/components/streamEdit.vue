<script>
import lessonForm from './lessonForm'

export default {
  data: function () {
    return {
      showLessonForm: false,
      newLessons: []
    }
  },
  components: {
    'lesson-form': lessonForm
  },
  methods: {
  	addLesson: function (object) {
  		this.newLessons.push(object.data)
  	}
  }
}
</script>
