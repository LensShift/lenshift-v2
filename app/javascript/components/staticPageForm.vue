<script>
import editor from 'vue2-medium-editor';
import mediumEditorMixin from '../mixins/mediumEditorMixin'

export default {
	mixins: [mediumEditorMixin],
	components: {
		'medium-editor': editor
	},
	data: function () {
    	return {
      		pageTitle: null,
      		pageContent: null,
          placement_list: null,
    	}
  	},
  	created () {
  		if (gon.page !== null && gon.page !== undefined) {
  			this.pageTitle = gon.page.title
  			this.pageContent = gon.page.content
        this.placement_list = gon.page.placement_list
  		}
  	}
}
</script>