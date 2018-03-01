<script>
import editor from 'vue2-medium-editor';
import axios from 'axios';
import mediumEditorMixin from '../mixins/mediumEditorMixin'

export default {
  name: 'resourceItemForm',
  components: {
    'medium-editor': editor
  },
  mixins: [mediumEditorMixin],
  data: function () {
    return {
      title: gon.resource_item.title,
      shortSummary: gon.resource_item.short_summary,
      keyTakeaways: gon.resource_item.key_takeaways,
      analysisContent: gon.resource_item.analysis_content,
      image: null,
      lensShifter: null,
      resourceType: null,
      article: {},
      articleScraped: false,
      notice: null
    }
  },
  methods: {
    addImage: function(imageLink) {
      // console.log(imageLink)
      this.image = imageLink
    },
    getArticle: function(id) {
      axios.get(`/fellow/resource_items/${id}/get_article.json`)
        .then(res => {
        console.log(res)
        this.articleScraped = true
        this.article['title'] = res.data.title
        this.article['description'] = res.data.description
        this.article['content'] = res.data.content
      }, error => {
        console.log(error)
        this.notice = error.notice
      })
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