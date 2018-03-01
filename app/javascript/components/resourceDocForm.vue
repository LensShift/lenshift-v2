<script>
import editor from 'vue2-medium-editor';
import mediumEditorMixin from '../mixins/mediumEditorMixin'

export default {
  name: 'resourceDocForm',
  components: {
    'medium-editor': editor
  },
  mixins: [mediumEditorMixin],
  data: function () {
    return {
      title: gon.parsed_file.title,
      shortSummary: gon.parsed_file.short_summary,
      keyTakeaways: gon.parsed_file.key_takeaways,
      analysisContent: gon.parsed_file.analysis_content,
      image: gon.parsed_file.image,
      resourceType: null,
      lensShifter: null,
    }
  },
  methods: {
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