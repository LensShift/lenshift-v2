<template>
  <modal novalidate="novalidate" id="new_lesson" class="new_lesson" ref="lessonData" @close="$emit('close')">

    <h3 slot="header">Add Lesson</h3>
    <div v-if="notice" :class="['callout', noticeType, 'small']">{{notice}}</div>
    <input name="utf8" type="hidden" value="✓"> 

    <div slot="body" class="form-inputs">
      
      <div class="input string required lesson_title">
        <label for="lesson_title" class="string required"><abbr title="required">*</abbr> Title</label>
        <input type="text" name="lesson[title]" id="lesson_title" class="string required" v-model="lesson.title">
      </div> 

      <div class="input text optional lesson_analysis">
        
        <label for="lesson_analysis" class="text optional">Analysis (At a Glance)</label>
        <textarea name="lesson[analysis]" id="lesson_analysis" class="text optional short-summary-text" v-model="lesson.analysis"></textarea>
      </div>

        <table v-if="currentLesson">
          <thead><tr><th colspan="3">Resources</th></tr></thead>
          <draggable v-model="newResourceList" element="tbody" :options="{ghostClass: 'ghost', chosenClass: 'chosen', handle:'.drag-icon'}" v-on:end="checkMove">
            <tr v-for="syl in newResourceList" :key="syl.id" :id="syl.id">
              <td><i class="fa fa-bars drag-icon"></i></td>
              <td>{{syl.resource_item.google_doc_id}}</td>
              <td>{{syl.resource_item.title}} </td>
             </tr>
          </draggable>
        </table>

      <div class="row" v-if="!currentLesson">
        <div class="column small-12 medium-6 large-6">
          <label>Add Resource Items</label>
          <draggable :list="newResourceList" :options="{group: 'resources', ghostClass: 'ghost', chosenClass: 'chosen'}" class="resource-destination-window" ref="newList">
            <div v-for="resource in newResourceList" :key="resource.id" class="draggable-resource-item-destination small" :id="resource.id"><small><b>Google Doc id:</b> {{resource.google_doc_id}}<br />{{resource.title}}</small></div>
          </draggable>
        </div>
        <div class="column small-12 medium-6 large-6">
          <label>Published Resources</label>
          <input type="search" id="search" class="small" placeholder="search by google id or title" v-model="searchTerm" />
          <draggable :list="filteredResources" :options="{group: 'resources', ghostClass: 'ghost', chosenClass: 'chosen'}" class="resource-selection-window">
            <div v-for="resource in filteredResources" :key="resource.id" class="small draggable-resource-item" :id="resource.id"><small><b>Google Doc id:</b> {{resource.google_doc_id}}<br />{{resource.title}}</small></div>
          </draggable>
        </div>
      </div>

    </div>
    <div slot="footer" class="form-actions">
      <br />
    <input v-if="currentLesson" type="submit" name="commit" value="update lesson" data-disable-with="Update lesson" class="button" @click="updateLesson" @submit.prevent="updateLesosn">
    <input v-else type="submit" name="commit" value="create lesson" data-disable-with="Create lesson" class="button" @click="addLesson" @submit.prevent="addLesson">
    </div>

  </modal>
</template>

<script>
import modal from './modal'
import draggable from 'vuedraggable'
import axios from 'axios'
import _ from 'lodash'

export default {
  props: {
    streamId: Number,
    currentLesson: Object
  },
  components: {
    draggable, modal
  },
  data: function () {
    return {
      token: null,
      searchTerm: '',
      lesson: {
        title: null,
        analysis: null,
        resource_item_ids: [],
        syllabuses_attributes: [],
        stream_id: this.streamId
      },
      newResourceList: [],
      resources: gon.resources,
      noticeType: null,
      notice: null
    }
  },
  computed: {
   filteredResources: function() {
      return this.resources.filter(resource => {
        return resource.title.toLowerCase().indexOf(this.searchTerm.toLowerCase()) > -1 ||
        String(resource.google_doc_id).match(this.searchTerm)
      })
    }
  },
  methods: {
    // addResource: function (evt) {
    //     // this.lesson.resource_item_ids = this.newResourceList.map(element => {
    //     //   return element.id
    //     // })
    //     // console.log(this.lesson.resource_item_ids)
    // },
    checkMove: function (evt) {
      // console.log('move', evt)
      // console.log('move to', evt.newIndex)

      axios.patch(`/fellow/streams/${this.streamId}/lessons/${this.lesson.id}.json`, {'utf8': '✓','authenticity_token': this.token, lesson: {syllabuses_attributes: {id: evt.item.id, row_order_position: evt.newIndex}}})
        .then(res => {
          // console.log(res)
          this.$emit('lesson-change', res.data)
        }, error => {
          console.log(error)
        })
    },
    addLesson: function() {
        this.lesson.resource_item_ids = this.newResourceList.map(element => {
          return element.id
        })
        // console.log(this.lesson.resource_item_ids)
       axios.post('/fellow/streams/'+ this.streamId + '/lessons', {'utf8': '✓','authenticity_token': this.token, 'lesson': this.lesson})
        .then(res => {
          // console.log('lesson response', res)
          this.$emit('lesson', res)
          this.$emit('close')
          this.lesson.title = null
          this.lesson.analysis = null
          this.resource_item_ids = []
          this.syllabuses_attributes = []
          this.newResourceList = []
        }, error => {
          console.log(error)
          this.noticeType = 'alert'
          let field = Object.keys(error.response.data.errors)
          this.notice = `${field} ${error.response.data.errors[field]}`
        })
    },
    updateLesson: function() {
       axios.patch(`/fellow/streams/${this.streamId}/lessons/${this.lesson.id}.json`, {'utf8': '✓','authenticity_token': this.token, 'lesson': this.lesson})
        .then(res => {
          // console.log('lesson response', res)
          this.lesson.title = null
          this.lesson.analysis = null
          this.resource_item_ids = []
          this.syllabuses_attributes = []
          this.newResourceList = []
          this.noticeType = 'success'
          this.notice = 'The lesson is updated!'
          this.$emit('lesson-change', res.data)
          this.$emit('close')
        }, error => {
          console.log(error)
          this.noticeType = 'alert'
          let field = Object.keys(error.response.data.errors)
          this.notice = `${field} ${error.response.data.errors[field]}`
        })
    }
  },
  created() {
    if(this.currentLesson) {
      this.lesson = this.currentLesson
      this.newResourceList = _.sortBy(this.currentLesson.syllabuses, ['row_order'])
    }

    var meta = document.getElementsByTagName('meta')
    this.token = meta['csrf-token'].content
    // console.log('resources', this.resources)
  }
}
</script>
