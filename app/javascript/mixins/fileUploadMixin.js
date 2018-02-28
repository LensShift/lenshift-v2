export default {
	data: function () {
		return {
			imageURL: null
		}
	},
	methods: {
		onPickFile() {
			this.$refs.imageUpload.click()
		},
		onFileChange(e, object) {
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

	      this[object].image = file
	      this.newImage = true
	    }
	}
}