<template>
  <form novalidate="novalidate" id="new_stream" enctype="multipart/form-data"accept-charset="UTF-8" class="new_stream" ref="streamData" v-on:submit.prevent="streamAction(action, $event)">
    <input name="utf8" type="hidden" value="✓"> 

    <input type="hidden" name="authenticity_token" id="authenticity_token" ref="authToken" :value="token"> 

    <div class="form-inputs">
      
      <div class="input string required stream_title">
        <label for="stream_title" class="string required"><abbr title="required">*</abbr> Title</label>
        <input type="text" name="stream[title]" id="stream_title" class="string required" v-model="stream.title">
      </div> 

      <div class="input text optional stream_description">
        
        <label for="stream_description" class="text optional">Description</label>
        <textarea name="stream[description]" id="stream_description" class="text optional shorter-summary-text" v-model="stream.description"></textarea>
      </div> 
      <div class='row'>
        <div class="column small-12 medium-4 large-4">
          <div class="input integer optional stream_estimated_reading_time">   
            <label for="stream_estimated_reading_time" class="integer optional">Estimated reading time</label>
            <input type="number" step="1" name="stream[estimated_reading_time]" id="stream_estimated_reading_time" class="numeric integer optional" v-model="stream.estimated_reading_time">
          </div>
        </div>
        <div class="column small-12 medium-4 large-4">
          <div class="input select required stream_lens_shifter">    
            <label for="stream_lens_shifter_id" class="select required"><abbr title="required">*</abbr> LensShifter</label>
              <select name="stream[lens_shifter_id]" id="stream_lens_shifter_id" class="select required" v-model="stream.lens_shifter_id">
                <option value=""></option>
                <option v-for="lensShifter in lensShifters" :value="lensShifter.id">{{lensShifter.full_name}}</option>

              </select>
          </div>
        </div>
        <div class="column small-12 medium-4 large-4">
          <div class="input date optional stream_published_at">    
            <label for="stream_published_at" class="integer optional">Publish Date</label>
            <input type="date" name="stream[published_at]" id="stream_published_at" class="date optional" v-model="stream.published_at">
          </div>
        </div>
      </div> 
    </div>

    <div class="input text optional stream_guiding_questions">
      <label for="stream_guiding_questions" class="text optional">Guiding questions</label>
      <textarea name="stream[guiding_questions]" id="stream_guiding_questions" class="text optional shorter-summary-text" v-model="stream.guiding_questions"></textarea>
    </div> 

    <div class="input string optional stream_tag_list">
      <label for="stream_tag_list" class="string optional">Tag list (separate by ";")</label>
      <input type="text" value="" name="stream[tag_list]" id="stream_tag_list" class="string optional" v-model="stream.tag_list">
    </div> 

    <div class="input file optional stream_image">
      <label for="stream_image" class="file optional">Image</label>
      <input type="file" name="stream[image]" id="stream_image" class="file optional" @change="onFileChange($event, 'stream')">
    </div>
    <div>
      <img :src="imageURL">
    </div>
    <br />
   
    <div class="form-actions">

    <input type="submit" name="commit" :value="action + ' Stream'" data-disable-with="Stream" class="button">
    </div>
  </form>
</template>
<script>
import fileUploadMixin from '../mixins/fileUploadMixin'

export default {
  props: {
    action: String,
    currentStream: {
      type: Object,
      required: false
    },
    lensShifters: Array
  },
  components: {
  },
  mixins: [fileUploadMixin],
  data: function () {
    return {
      token: null,
      stream: {
        title: null,
        description: null,
        estimated_reading_time: null,
        image: null,
        guiding_questions: null,
        tag_list: null,
        lens_shifter_id: null,
        published_at: null
      },
      imageURL: null
    }
  },
  methods: {
    streamAction: function(callAction, event) {
      // console.log(event.target.elements)
      // console.log('create')
      // console.log(this.token)
      const formData = new FormData(this.$refs.streamData)
      formData.append(
          'stream[image]',
          this.stream.image
        )
      // console.log(formData)
      this.$emit('stream-' + callAction, formData)
    }
  },
  created() {
    if(this.currentStream) {
      this.stream = this.currentStream
      this.imageURL = this.stream.image.url
    }
    var meta = document.getElementsByTagName('meta')
    this.token = meta['csrf-token'].content
  }
}
</script>