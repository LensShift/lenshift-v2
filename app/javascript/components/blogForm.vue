<template>
  <div>
  	<div v-if="notice" :class="['callout', noticeType, 'small']">{{notice}}</div>
  	<i v-if="blogLoading" class="fa fa-circle-o-notch fa-spin loading" style="font-size:90px;"></i>
  	<div v-if="!blogLoading">
  	<h1>{{blogPost.title}}</h1>
  	<label for="blog_title" class="string required"><abbr title="required">*</abbr> Title</label>
    <input type="text" id="blog_title" v-model="blogPost.title" placeholder="title" />
    <label for="blog_tags" class="string required">Tags</label>
    <input type="text" id="blog_tags" v-model="blogPost.tag_list" />
    <label for="blog_published_at" class="string required">Published Date</label>
    <input type="date" id="blog_published_at" v-model="blogPost.published_at" />
    <label for="blog_content" class="string required">Content</label>
    <medium-editor :text="blogPostContent" data-source="blogPostContent" :options="longOptions" custom-tag="div" v-on:edit="applyChanges" class="long-summary-text"></medium-editor>
	</div>
    <br />
    <button v-if="blogPost.created_at" v-on:click="updateBlog" class="button">Update</button>
    <button v-if="!blogPost.created_at" v-on:click="createBlog" class="button">Create</button> 
    <a href="/fellow/blogs" alt="back to blogs list">back</a>
  </div>
</template>

<script>
import editor from 'vue2-medium-editor';
import mediumEditorMixin from '../mixins/mediumEditorMixin'
import axios from 'axios'
import moment from 'moment'

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
    			tag_list: null,
    			published_at: null
    		},
        blogPostContent: null,
    		noticeType: null,
    		notice: null
    	}
  	},
  	methods: {
  		createBlog: function() {
  			this.blogLoading = true
  			var meta = document.getElementsByTagName('meta')
    		var token = meta['csrf-token'].content

        this.blogPost.content =  this.blogPostContent
        this.blogPost.published_at = new Date(this.blogPost.published_at)
  			axios.post('/fellow/blogs.json', {'utf8': '✓','authenticity_token': token, blog: this.blogPost}).then(res => {
  				console.log(res.data)
  				this.blogLoading = false
  				this.blogPost = res.data
          this.blogPost.tag_list = res.data.tags.map(tag => tag.name).join("; ")
          moment(res.data.published_at).format('YYYY-MM-DD')
  				this.noticeType = 'success'
  				this.notice = "blog created"
  			}).catch(error => {
  				console.log(error)
  				this.blogLoading = false
  				this.noticeType = 'alert'
          		let field = Object.keys(error.response.data.errors)
          		this.notice = `${field} ${error.response.data.errors[field]}`
  			})
  		},
      updateBlog: function() {
        this.blogLoading = true
        var meta = document.getElementsByTagName('meta')
        var token = meta['csrf-token'].content

        this.blogPost.content =  this.blogPostContent
        axios.patch(`/fellow/blogs/${this.blogPost.id}.json`, {'utf8': '✓','authenticity_token': token, blog: this.blogPost}).then(res => {
          console.log(res.data)
          this.blogLoading = false
          this.blogPost = res.data
          this.blogPost.tag_list = res.data.tags.map(tag => tag.name).join("; ")
          moment(res.data.published_at).format('YYYY-MM-DD')
          this.noticeType = 'success'
          this.notice = "blog updated"
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
      if(this.blog) {
        this.blogPost = this.blog
        console.log(this.blog.published_at)
        this.blogPost.published_at = moment(this.blog.published_at).format('YYYY-MM-DD')

        console.log(this.blogPost.published_at)
        this.blogPostContent = this.blog.content
        this.blogPost.tag_list = this.blog.tags.map(tag => tag.name).join("; ")

      }
  	}
}
</script>
