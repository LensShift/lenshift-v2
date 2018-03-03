<script>
import axios from 'axios'

export default {
  name: 'contactForm',
  data: function () {
    return {
      query: {
        name: null,
        email: null,
        subject: null,
        message: null
      },
      notice: null,
      loading: false,
      submitted: false,
      validSubmit: false
    }
  },
  methods: {
    getCookie: function (cname) {
      var name = cname + "=";
      var decodedCookie = decodeURIComponent(document.cookie);
      var ca = decodedCookie.split(';');
      for(var i = 0; i <ca.length; i++) {
          var c = ca[i];
          while (c.charAt(0) == ' ') {
              c = c.substring(1);
          }
          if (c.indexOf(name) == 0) {
              return c.substring(name.length, c.length);
          }
      }
      return "";
    },
    submitQuery: function (e) {
      this.notice = null
      this.loading = true
      if(this.getCookie('lensShiftQuery')) {
         if(this.query.email && this.query.message) {
          this.validSubmit = true
        } else {
          this.notice = []
            if(!this.query.email) this.notice.push("Email is required. ")
            if(!this.query.message) this.notice.push("Message is require.")
            this.validSubmit = false
            this.loading = false
        }

        if (this.validSubmit) {
          axios.post("https://lensshift-admin.firebaseio.com/queries.json", this.query)
          .then(res => {
             this.query.name = null
             this.query.email = null
             this.query.subject = null
             this.query.message = null
             this.loading = false
             this.submitted = true

          }).catch(error => {
            this.notice = error
            console.log(error)
          })
        }
        
      } else {
        this.notice = "Sorry, it doesn't look like you are human. You can't submit the contact form"
      }
    }
  },
  created() {
      var now = new Date();
      var twoHours = new Date(now.getTime() + (2*1000*60*60))
      document.cookie = "lensShiftQuery=I am a human; expires=" + twoHours; 
  }
}
</script>