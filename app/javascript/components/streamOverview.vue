<template>
  <div>
    <div v-html="stream.guiding_questions"></div>
      
      <table class="unstriped">
          <tr>
              <th class="horizontal-table-head"><small>Date</small></th>
              <td>{{stream.published_at}}</td>
          </tr>
          <tr>
              <th class="horizontal-table-head"><small>Reading Time</small></th>
              <td>{{stream.estimated_reading_time}}</td>
          </tr>
          <tr>
              <th class="horizontal-table-head"><small>No. of Lessons</small></th>
              <td>{{lessonsCount}}</td>
          </tr>
          <tr>
              <th class="horizontal-table-head"><small>No. of Resources</small></th>
              <td>{{resourcesCount}}</td>
          </tr>
              
      </table>
      <div v-for="lesson in lessons"><div class="lesson-title">{{lesson.title}}</div></div>
    <div 
  </div>
</template>

<script>

export default {
  name: "StreamOverview",
  props: {
    stream: Object,
    lessons: Object,
    lessonsCount: Number,
    resourcesCount: Number
  },
  data: function () {
    return { 
      
    }
  },
  created () {
  }
}
</script>