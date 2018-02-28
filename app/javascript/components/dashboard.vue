<script>
import profileForm from './profileForm'
import fileUploadMixin from '../mixins/fileUploadMixin'
import axios from 'axios'

export default {
  data: function () {
    return {
      component: 'profile-form',
      newImage: false,
      profile: {
      	image: null
      }
    }
  },
  mixins: [fileUploadMixin],
  components: {
    'profile-form': profileForm
  },
  methods: {
  	saveImage: function(id) {
  		this.newImage = false
  		const formData = new FormData()
  		var meta = document.getElementsByTagName('meta')
    	var token = meta['csrf-token'].content

      	formData.append(
          'profile[avatar]',
          this.profile.image
        )

        formData.append(
          'authenticity_token',
          token
        )

      	console.log(formData)
      
      	axios.patch(`/profiles/${id}.json`, formData)
	        .then(res => {
	          console.log(res)
	        }, error => {
	          console.log(error)
	          this.newImage = true
	        })
  	}
  },
  created () {
  	this.imageURL = gon.avatar.avatar.url
  }
}
</script>
