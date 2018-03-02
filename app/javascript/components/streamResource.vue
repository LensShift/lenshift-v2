<template>
    <div class="lesson-container">
        <div v-if="safeURL">
        <div v-if="currentResource.resource_type === 'video' || currentResource.resource_type === 'podcast'" class="content-container" v-html="currentResource.video_embed"></div>

        <div  v-else-if="currentResource.resource_type === 'graphic'" class="content-container"><img :src="currentResource.image.url"></div>

        <div v-else-if="currentResource.no_iframe === true">
          <span v-html="currentResource.analysis_content"></span>
            <a :href="currentResource.source_url" alt="resource link" class="button" target="_blank">Click here to read more about it</a>
        </div>

        <div v-else>
          <div class="iframe-head"><b>from</b> {{origin}}</div>
          <iframe :srcdoc="currentResource.article_content" class="resource-iframe"></iframe>
        </div>
      </div>
      <div v-else>
        <div class="card stream-resource-card">
          <div class="card-divider">{{currentResource.title}}</div>
            <div class="card-section">
                <span v-html="currentResource.analysis_content"></span>
                <a :href="currentResource.source_url" alt="resource link" class="button" target="_blank">Click here to read more about it</a>
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
      currentResource: this.resource,
      origin: null
    }
  },
  computed: {
    safeURL: function() {
        let resourceURL = new URL(this.currentResource.source_url)
        return resourceURL.protocol === 'https:'
    }
  },
  created () {
    let resourceURL = new URL(this.currentResource.source_url)
    this.origin = resourceURL.origin
  }
}
</script>
