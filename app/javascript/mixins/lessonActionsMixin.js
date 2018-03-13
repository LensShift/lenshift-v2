export default {
	methods: {
		addLesson: function (object) {
  			this.lessons.push(object.data)
  		},
  		newLesson: function () {
  			// data properties in streamEdit and streamNew
      		this.currentLesson = null
      		this.showLessonForm = true 
    	},
		lessonEdit: function(lessonId) {
	      this.currentLesson = this.lessons.find(lesson => {
	        return lesson.id === lessonId
	      })
	      // console.log(this.currentLesson)
	      this.showLessonForm = true
		},
	    updateLessonsList: function(object) {
	      var i = this.lessons.findIndex(l => l.id == object.id)
	      // console.log(i)
	      // console.log(object)
	      this.$set(this.lessons, i, object)
	      // console.log(this.lessons)
	    }
	}
}