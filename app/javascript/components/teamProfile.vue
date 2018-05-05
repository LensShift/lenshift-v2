<template>
  <modal @close="$emit('close')" class="profile-modal">
    <h2 slot="header" class="profile-heading">{{member.name}}</h2>
    <p slot="header"><b>{{member.role}}</b></p>

    <div slot="body">
      
      <p>{{member.info.biography}}</p>
      <h4>Why LensShift?</h4>
      <p>{{member.info.why}}</p>
      <h4>3 Places I feel or call home:</h4>
      <p>{{member.info.home_1}}, {{member.info.home_2}}, {{member.info.home_3}}</p>
    </div>

    <div slot="footer"></div>
  </modal>
</template>

<script>
import modal from './modal'

export default {
  components: {
    modal
  },
  props: {
    member: Object
  },
  data: function () {
    return {
    }
  }
}
</script>

