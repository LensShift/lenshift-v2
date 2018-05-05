<script>
import teamProfile from './teamProfile';

export default {
  data: function () {
    return {
      teamMembers: gon.team_members,
      showModal: false,
      member: null
    }
  },
  components: {
    'team-profile': teamProfile
  },
  methods: {
    showProfile: function(profile) {
      this.member = profile
      this.showModal = true
    }
  }
}
</script>