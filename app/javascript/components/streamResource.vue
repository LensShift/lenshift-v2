<template>
    <div class="lesson-container">

        <div class="card stream-resource-card">
          <div class="card-divider"><span class="stream-resource-title"><i>from LensShift Library on:</i></span>{{resource.title}}</div>
            <div class="card-section">
                <span v-html="resource.analysis_content"></span>
 
                <div v-if="resource.resource_type === 'video' || resource.resource_type === 'podcast'" class="content-container" v-html="resource.video_embed"></div>

                <div  v-else-if="resource.resource_type === 'graphic'" class="content-container"><img :src="resource.image.url"></div>

                <div v-else>
                  <br />
                    <a :href="resource.source_url" alt="resource link" class="button" target="_blank">Click here to see the original content</a>
                </div>
            </div>
        </div>
    
  </div>
</template>

<script>

export default {
  name: "streamResource",
  props: {
    resource: Object
  },
  data: function () {
    return {
      origin: null
    }
  },
  computed: {
    safeURL: function() {
        let resourceURL = new URL(this.resource.source_url)
        return resourceURL.protocol === 'https:'
    }
  },
  created () {
    let resourceURL = new URL(this.resource.source_url)
    this.origin = resourceURL.origin
  }
}
</script>
