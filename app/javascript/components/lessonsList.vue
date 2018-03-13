<template>
  <div>
    <h4>Lessons</h4>
        <draggable v-model="lessonsList" :options="{ghostClass: 'ghost', chosenClass: 'chosen', handle:'.drag-icon'}" element="ul" class="sort-tabs" :move="checkMove">
          <li v-for="(lesson, index) in lessonsList" :key="lesson.id" ><i class="fa fa-bars drag-icon"></i>{{lesson.title}}<i class="fa fa-pencil-square edit-icon" v-on:click="editLesson(lesson.id)"></i></li>
        </draggable>
    </div>
  </div>
</template>

<script>
import draggable from 'vuedraggable'
import axios from 'axios'

export default {
  components: {
    'draggable': draggable
  },
  props: {
    lessons: Array,
    streamId: Number
  },
  data: function () {
    return {
      lessonsList: this.lessons
    }
  },
  methods: {
    checkMove: function (evt, originalEvent) {
      console.log('move', evt.draggedContext.futureIndex)
      console.log('original', originalEvent)
      var meta = document.getElementsByTagName('meta')
      var token = meta['csrf-token'].content

      axios.patch(`/fellow/streams/${this.streamId}/lessons/${evt.draggedContext.element.id}.json`, {'utf8': '✓','authenticity_token': token,lesson: {row_order_position: evt.draggedContext.futureIndex}})
        .then(res => {
          // console.log(res)
          this.$emit('new-list', this.lessons)
        }, error => {
          console.log(error)
        })
    },
    editLesson: function (lessonId) {
      this.$emit('edit-lesson', lessonId)
    } 
  },
  created () {
  }
}
</script>
