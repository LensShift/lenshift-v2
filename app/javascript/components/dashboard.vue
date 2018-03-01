<script>
import profileForm from './profileForm'
import fileUploadMixin from '../mixins/fileUploadMixin'
import axios from 'axios'
import Velocity from 'velocity-animate'
import 'velocity-animate/velocity.ui'

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
  	saveImage: function(e, id) {
  		
  		const formData = new FormData()
  		var meta = document.getElementsByTagName('meta')
    	var token = meta['csrf-token'].content

      console.log(e)
      e.target.innerHTML = "<i class='fa fa-spinner fa-spin'></i>"

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
            this.newImage = false
	        }, error => {
	          console.log(error)
	          this.newImage = true
	        })
  	},
    buttonEnter: function (el, done) {
      Velocity(el, "transition.slideDownIn", {duration: 1000}, {complete: done})
    },
    buttonLeave: function (el, done) {
      Velocity(el, "transition.bounceUpOut", {duration: 1000}, {complete: done})
    }
  },
  created () {
  	this.imageURL = gon.avatar.avatar.url
  }
}
</script>
