<script>
import fileUploadMixin from '../mixins/fileUploadMixin'
import axios from 'axios'

export default {
  mixins: [fileUploadMixin],
  data: function () {
    return {
      photos: gon.photos,
      photo: {
        title: "",
        desc: "",
        image: null
      },
      uploadPhotos: [],
      newImage: false
    }
  },
  methods: {
  	saveImage: function(e) {
      
      const formData = new FormData()
      var meta = document.getElementsByTagName('meta')
      var token = meta['csrf-token'].content

      console.log(e)

      var filename = this.photo.image.name

      var ext = filename.slice((filename.lastIndexOf('.') - 1 >>> 0) + 2);
      console.log(ext)

      formData.append('photo[image]', this.photo.image, this.photo.title.split(" ").join("_") + "." + ext)
      formData.append('authenticity_token', token)
      formData.append('photo[title]', this.photo.title)
      formData.append('photo[desc]', this.photo.desc)

        console.log(formData)
      
        axios.post(`/fellow/photos`, formData)
          .then(res => {
            console.log(res)
          }, error => {
            console.log(error)
          })
    }
  }
}
</script>