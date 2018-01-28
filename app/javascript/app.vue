<template>
  <div>
    <app-navbar></app-navbar>
    <p>{{ message }}</p>
    test app
  </div>
</template>

<script>

export default {
  data: function () {
    return {
      message: "Hello Vue! Everyone two"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
