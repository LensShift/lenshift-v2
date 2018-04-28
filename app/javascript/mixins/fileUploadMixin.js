export default {
	data: function () {
		return {
			fileURL: null,
			fileType: null,
			fileName: null
		}
	},
	methods: {
		onPickFile(input) {
			this.$refs[input].click()
		},
		onFileChange(e) {
	      // console.log('file uploading')
	      var file = e.target.files[0]
	      console.log('file uploading', file)
	      this.fileName = file.name
	      this.fileType = file.type.split("/")[0]
	      // console.log(fileName)
	      if (this.fileName.lastIndexOf('.') <= 0) {
	        return alert('Please add a file with valid extension')
	      }

	      const fileReader = new FileReader()
	      fileReader.addEventListener('load', () => {
	        this.fileURL = fileReader.result
	      })
	      fileReader.readAsDataURL(file)

	      this.fileObject.file = file
	    }
	}
}