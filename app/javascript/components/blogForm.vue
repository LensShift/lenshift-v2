<template>
  <div>
  	<div v-if="notice" :class="['callout', noticeType, 'small']">{{notice}}</div>
  	<i v-if="blogLoading" class="fa fa-circle-o-notch fa-spin loading" style="font-size:90px;"></i>
  	<div v-if="!blogLoading">
  	<h1>{{blogPost.title}}</h1>
  	<label for="blog_title" class="string required"><abbr title="required">*</abbr> Title</label>
    <input type="text" id="blog_title" v-model="blogPost.title" placeholder="title" />
    <label for="blog_published_at" class="string required">Tags</label>
    <input type="text" id="blog_published_at" v-model="blogPost.tag_list" />
    <label for="blog_published_at" class="string required">Published Date</label>
    <input type="date" id="blog_published_at" v-model="blogPost.published_at" />
    <label for="blog_content" class="string required">Content</label>
    <input type="hidden" id="blog_content" v-model="blogPost.content" />
    <medium-editor :text="blogPost.content" data-source="blogPost.content" :options="longOptions" custom-tag="div" v-on:edit="applyChanges" class="long-summary-text"></medium-editor>
	</div>
    <br />
    <br />
    <button v-on:click="createBlog" class="button">Create</button>
  </div>
</template>

<script>
import editor from 'vue2-medium-editor';
import mediumEditorMixin from '../mixins/mediumEditorMixin'
import axios from 'axios'
export default {
	mixins: [mediumEditorMixin],
	components: {
		'medium-editor': editor
	},
	props: {
		blog: {
			type: Object,
			required: false
		}
	},
  	data: function () {
    	return {
    		blogLoading: false,
    		blogPost: {
    			title: null,
    			content: null,
    			tags: null,
    			published_at: null
    		},
    		noticeType: null,
    		notice: null
    	}
  	},
  	methods: {
  		createBlog: function() {
  			this.blogLoading = true
  			var meta = document.getElementsByTagName('meta')
    		var token = meta['csrf-token'].content
  			axios.post('/fellow/blogs', {'utf8': '✓','authenticity_token': token, blog: this.blogPost}).then(res => {
  				console.log(res.data)
  				this.blogLoading = false
  				this.blogPost = res.data
  				this.noticeType = 'success'
  				this.notice = "blog created"
  			}).catch(error => {
  				console.log(error)
  				this.blogLoading = false
  				this.noticeType = 'alert'
          		let field = Object.keys(error.response.data.errors)
          		this.notice = `${field} ${error.response.data.errors[field]}`
  			})
  		}
  	},
  	created () {
  		this.blogPost = this.blog
  	}
}
</script>
