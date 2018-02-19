<template>
  <form novalidate="novalidate" id="new_lesson" enctype="multipart/form-data"accept-charset="UTF-8" class="new_lesson" ref="lessonData" @submit.prevent="addLesson">
    <h3>Add Lesson</h3>
    <input name="utf8" type="hidden" value="✓"> 

    <input type="hidden" name="authenticity_token" id="authenticity_token" ref="authToken" :value="token"> 

    <div class="form-inputs">
      
      <div class="input string required lesson_title">
        <label for="lesson_title" class="string required"><abbr title="required">*</abbr> Title</label>
        <input type="text" name="lesson[title]" id="lesson_title" class="string required" v-model="lesson.title">
      </div> 

    <div class="input text optional lesson_analysis">
      
      <label for="lesson_analysis" class="text optional">Analysis (At a Glance)</label>
      <textarea name="lesson[analysis]" id="lesson_analysis" class="text optional short-summary-text" v-model="lesson.analysis"></textarea>
    </div>
    <div class="row">
      <div class="column small-12 medium-6 large-6">
        <label>Add Resource Items</label>
        <draggable :list="newResourceList" :options="{group: 'resources', ghostClass: 'ghost', chosenClass: 'chosen'}" class="resource-destination-window" @add="addResource" @end="checkMove" ref="newList">
          <div v-for="resource in newResourceList" :key="resource.id" class="callout warning" :id="resource.id"><b>Google Doc ID:</b> {{resource.google_doc_id}}<br /><b>Title: </b>{{resource.title}}</div>
        </draggable>
      </div>
      <div class="column small-12 medium-6 large-6">
        <label>Published Resources</label>
        <draggable v-model="resources" :options="{group: 'resources', ghostClass: 'ghost', chosenClass: 'chosen'}" class="resource-selection-window">
          <div v-for="resource in resources" :key="resource.id" class="callout warning resource-item" :id="resource.id"><b>Google Doc ID:</b> {{resource.google_doc_id}}<br /><b>Title: </b>{{resource.title}}</div>
        </draggable>
      </div>
    </div>

    </div>
    <div class="form-actions">
      <br />
      <br />

    <input type="submit" name="commit" value="Create lesson" data-disable-with="Create lesson" class="button">
    <a href="/fellow/streams" alt="streams index" class="button warning">Finished</a>
    </div>
  </form>
</template>

<script>
import draggable from 'vuedraggable'
import axios from 'axios'

export default {
  props: {
    token: String,
    streamId: Number
  },
  components: {
    draggable,
  },
  data: function () {
    return {
      message: "Hello Vue! Everyone lesson",
      lesson: {
        title: null,
        analysis: null,
        resource_item_ids: [],
        syllabuses_attributes: [],
        stream_id: this.streamId
      },
      newResourceList: [],
      resources: gon.resources
    }
  },
  methods: {
    addResource: function (evt) {
        // this.lesson.resource_item_ids = this.newResourceList.map(element => {
        //   return element.id
        // })
        // console.log(this.lesson.resource_item_ids)
    },
    checkMove: function (evt, originalEvent) {
      console.log('move', evt)
      this.lesson.syllabuses_attributes = {'row_order_position': evt.newIndex, 'resource_id': evt.item.id}
      // console.log('new index', this.lesson.resources)
    },
    addLesson: function() {
        this.lesson.resource_item_ids = this.newResourceList.map(element => {
          return element.id
        })
        console.log(this.lesson.resource_item_ids)
       axios.post('/fellow/streams/'+ this.streamId + '/lessons', {'utf8': '✓','authenticity_token': this.token, 'lesson': this.lesson})
        .then(res => {
          console.log('lesson response', res)
          this.$emit('stream', res)
          this.lesson.title = null
          this.lesson.analysis = null
          this.resource_item_ids = []
          this.syllabuses_attributes = []
          this.newResourceList = []
        }, error => {
          console.log(error)
        })
    }
  },
  created() {
    // console.log('resources', this.resources)
  }
}
</script>
