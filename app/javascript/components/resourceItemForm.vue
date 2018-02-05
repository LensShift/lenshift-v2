<script>
import editor from 'vue2-medium-editor';

export default {
  name: 'resourceItemForm',
  components: {
    'medium-editor': editor
  },
  data: function () {
    return {
      title: gon.resource_item.title,
      shortSummary: gon.resource_item.short_summary,
      keyTakeaways: gon.resource_item.key_takeaways,
      analysisContent: gon.resource_item.analysis_content,
      image: null,
      lensShifter: null,
      resourceType: null,
      longOptions: {
        toolbar: {
          buttons: ['bold','italic','underline','strikethrough','anchor','image','orderedlist','unorderedlist', 'indent', 'outdent','justifyLeft','justifyCenter','justifyRight', 'h2','h3','h4']
        }
      },
      shortOptions: {
        toolbar: {
          buttons: ['bold','italic','underline','anchor','unorderedlist']
        }
      }
    }
  },
  methods: {
    applyChanges: function(operation) {
      // console.log("i am being edited")
      // console.log(operation.api.origElements.attributes['data-source'].value)
      let source = operation.api.origElements.attributes['data-source'].value
      this[source] = operation.api.origElements.innerHTML
    },
    addImage: function(imageLink) {
      // console.log(imageLink)
      this.image = imageLink
    }
  },
  created() {
    // console.log('image', gon.resource_item)
    this.image = gon.resource_item.image !== null && gon.resource_item.image !== undefined ? gon.resource_item.image.url : gon.resource_item.remote_image_url

    this.resourceType = gon.resource_item.resource_type.toLowerCase()

    console.log('article', this.articleContent)
  }
  
}
</script>