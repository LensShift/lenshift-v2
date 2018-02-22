<template type="text/x-template" id="modal-template">
  <transition name="modal">
    <div class="modal-element">
      <div class="modal-mask" v-on:click="$emit('close')"></div>
      <div class="modal-wrapper">
          <div class="modal-container">

            <div class="modal-header">
              <slot name="header">
                default header
              </slot>
            </div>

            <div class="modal-body">
              <slot name="body">
                default body
              </slot>
            </div>

            <div class="modal-footer">
              <slot name="footer">
                default footer
                <button class="modal-default-button button" @click="$emit('close')">
                  OK
                </button>
              </slot>
            </div>
          </div>
       </div>
    </div>
  </transition>
</template>

<script>
export default {
  name: 'modal',
  data () {
    return {
      
    }
  },
  methods: {

  }
}
</script>