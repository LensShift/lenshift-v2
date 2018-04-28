<script>
import fileUploadMixin from '../mixins/fileUploadMixin'
import axios from 'axios'

export default {
  mixins: [fileUploadMixin],
  data: function () {
    return {
      documents: gon.documents,
      photos: gon.photos,
      fileObject: {
        title: "",
        desc: "",
        file: null
      },
      uploadPhotos: [],
      newImage: false
    }
  },
  methods: {
  	saveFile: function(e) {
      
      const formData = new FormData()
      var meta = document.getElementsByTagName('meta')
      var token = meta['csrf-token'].content

      console.log(e)

      var ext = this.fileName.slice((this.fileName.lastIndexOf('.') - 1 >>> 0) + 2);
      console.log(ext)

      if(this.fileType === 'image') {
        formData.append('photo[image]', this.fileObject.file, this.fileObject.title.split(" ").join("_") + "." + ext)
        formData.append('authenticity_token', token)
        formData.append('photo[title]', this.fileObject.title)
        formData.append('photo[desc]', this.fileObject.desc)

        console.log(formData)
      
        axios.post(`/fellow/photos`, formData)
          .then(res => {
            console.log(res)
            this.photos.push(res.data)
            this.fileObject.title = null
            this.fileObject.desc = null
            this.fileObject.file = null
            this.fileURL = null
          }, error => {
            console.log(error)
          })
      } else {
        formData.append('document[file]', this.fileObject.file, this.fileObject.title.split(" ").join("_") + "." + ext)
        formData.append('authenticity_token', token)
        formData.append('document[title]', this.fileObject.title)
        formData.append('document[desc]', this.fileObject.desc)

        console.log(formData)
      
        axios.post(`/fellow/documents`, formData)
          .then(res => {
            console.log(res)
            this.documents.push(res.data)
            this.fileObject.title = null
            this.fileObject.desc = null
            this.fileObject.file = null
            this.fileURL = null
          }, error => {
            console.log(error)
          })
      }
      

    }
  }
}
</script>