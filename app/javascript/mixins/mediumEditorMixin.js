export default {
	data () {
		return {
			longOptions: {
		        toolbar: {
		          buttons: ['bold','italic','underline','strikethrough','anchor','image','orderedlist','unorderedlist', 'indent', 'outdent','justifyLeft','justifyCenter','justifyRight', 'h2','h3','h4', 'html']
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
	      console.log("i am being edited")
	      // console.log(operation.api.origElements.attributes['data-source'].value)
	      let source = operation.api.origElements.attributes['data-source'].value
	      this[source] = operation.api.origElements.innerHTML
	    }
	}
}