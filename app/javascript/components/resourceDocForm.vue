<script>
import editor from 'vue2-medium-editor';

export default {
  name: 'resourceDocForm',
  components: {
    'medium-editor': editor
  },
  data: function () {
    return {
      title: gon.parsed_file.title,
      shortSummary: gon.parsed_file.short_summary,
      keyTakeaways: gon.parsed_file.key_takeaways,
      analysisContent: gon.parsed_file.analysis_content,
      image: gon.parsed_file.image,
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
    this.resourceType = gon.parsed_file.type.toLowerCase()

  }
  
}
</script>