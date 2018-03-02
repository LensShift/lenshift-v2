<template>
    <div class="lesson-container">
        <div v-if="safeURL">
        <div v-if="resource.resource_type === 'video' || resource.resource_type === 'podcast'" class="content-container" v-html="resource.video_embed"></div>

        <div  v-else-if="resource.resource_type === 'graphic'" class="content-container"><img :src="resource.image.url"></div>

        <div v-else-if="resource.no_iframe === true">
          <span v-html="resource.analysis_content"></span>
            <a :href="resource.source_url" alt="resource link" class="button" target="_blank">Click here to read more about it</a>
        </div>

        <div v-else>
          <div class="iframe-head"><b>from</b> {{origin}}</div>
          <iframe :srcdoc="resource.article_content" class="resource-iframe"></iframe>
        </div>
      </div>
      <div v-else>
        <div class="card stream-resource-card">
          <div class="card-divider">{{resource.title}}</div>
            <div class="card-section">
                <span v-html="resource.analysis_content"></span>
                <a :href="resource.source_url" alt="resource link" class="button" target="_blank">Click here to read more about it</a>
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
