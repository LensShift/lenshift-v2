<template>
  <form novalidate="novalidate" id="new_stream" enctype="multipart/form-data"accept-charset="UTF-8" class="new_stream" ref="streamData" v-on:submit.prevent="createStream">
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
        <div class="column small-12 medium-6 large-6">
          <div class="input integer optional stream_estimated_reading_time">   
            <label for="stream_estimated_reading_time" class="integer optional">Estimated reading time</label>
            <input type="number" step="1" name="stream[estimated_reading_time]" id="stream_estimated_reading_time" class="numeric integer optional" v-model="stream.estimated_reading_time">
          </div>
        </div>
        <div class="column small-12 medium-6 large-6">
          <div class="input select required stream_lens_shifter">    
            <label for="stream_lens_shifter_id" class="select required"><abbr title="required">*</abbr> LensShifter</label>
              <select name="stream[lens_shifter_id]" id="stream_lens_shifter_id" class="select required" v-model="stream.lens_shifter_id">
                <option value=""></option>
                <option v-for="lensShifter in lensShifters" :value="lensShifter.id">{{lensShifter.full_name}}</option>

              </select>
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
      <input type="file" name="stream[image]" id="stream_image" class="file optional" @change="onFileChange">
    </div>
    <div>
      <img :src="imageURL">
    </div>

   
    <div class="form-actions">

    <input type="submit" name="commit" value="Create Stream" data-disable-with="Create Stream" class="button">
    </div>
  </form>
</template>
<script>
import axios from 'axios'

export default {
  props: {
    token: String
  },
  components: {
  },
  data: function () {
    return {
      message: "Hello Vue! Everyone two",
      authToken: null,
      stream: {
        title: null,
        description: null,
        estimated_reading_time: null,
        image: null,
        guiding_questions: null,
        tag_list: null,
        lens_shifter_id: null
      },
      lensShifters: gon.lens_shifters,
      imageURL: null
    }
  },
  methods: {
    createStream: function() {
      // console.log('create')
      // console.log(this.token)


      const formData = new FormData(this.$refs.streamData)

      formData.append(
          'stream[image]',
          this.stream.image
        )

      console.log(formData)
      
      axios.post('/fellow/streams', formData)
        .then(res => {
          // console.log(res)
          this.$emit('stream', res)
        }, error => {
          console.log(error)
        })
    },
    onFileChange(e) {
      console.log('file uploading')
      var file = e.target.files[0]
      let filename = file.name
      // console.log(filename)
      if (filename.lastIndexOf('.') <= 0) {
        return alert('Please add a file with valid extension')
      }

      const fileReader = new FileReader()
      fileReader.addEventListener('load', () => {
        this.imageURL = fileReader.result
      })
      fileReader.readAsDataURL(file)

      this.stream.image = file
    }
  },
  created() {


    // gon.lens_shifters.forEach((element) => {
    //   profile.push(element.profile)
    // })
    // console.log(profile)
  }
}
</script>