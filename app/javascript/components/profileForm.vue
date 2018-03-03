<template>
	<form novalidate="novalidate" id="edit_profile_6" enctype="multipart/form-data" action="/profiles/6" accept-charset="UTF-8" method="post" class="simple_form edit_profile" @submit.prevent="profileUpdate($event)">
		<div class="form-inputs">
			<div v-if="notice" class="callout success">{{notice}}</div>
			<div class="input date optional profile_birthdate">
				<label for="profile_birthdate" class="date optional">Birthdate</label>
				<input type="date" name="profile[birthdate]" id="profile_birthdate" class="date optional" v-model="updatedProfile.birthdate">
			</div> 

			<div class="input date optional profile_gender">
				<label for="profile_birthdate" class="date optional">Gender</label>
				<select name="profile[gender]" id="profile_gender" class="select optional" v-model="updatedProfile.gender">
					<option value=""></option> 
					<option v-for="gender in genders" :value="gender">{{gender}}</option> 
				</select>
			</div>
			
			<div class="input string optional profile_location relative-block">
     			<label for="profile_location" class="string optional">Location</label>

      			<input v-model="location" type="text" name="profile[location]" id="profile_location" aria-controls="places" data-is-focus="true" data-yeti-box="places" aria-haspopup="true" aria-expanded="false" class="string optional dropdown-input"  v-on:input="getLocation" v-on:focus="focus" v-on:blur="blur" v-on:keyup.enter="keyEnter" v-on:keydown.tab="keyEnter" v-on:keyup.up="keyUp" v-on:keydown.down="keyDown">
      
      			<ul v-if="isActive" class="dropdown-options" id='places'>
        			<li v-if="isActive" v-for="(place, index) in suggestions" v-on:click="selectPlace(index)" :class="['select-option-item', {'select-option-active': index === cursor}]" v-on:mouseover="cursor = index">{{place.name}}</li>
      			</ul>
    		</div>
			
			<div class="input hidden profile_address">
				<input type="hidden" :value="updatedProfile.address" name="profile[address]" id="profile_address" class="hidden">
			</div> 
			
			<div class="input select optional profile_sector">
				<label for="profile_sector" class="select optional">Sector</label>
				<select name="profile[sector]" id="profile_sector" class="select optional" v-model="updatedProfile.sector">
					<option value=""></option> 
					<option v-for="sector in sectors" :value="sector">{{sector}}</option> 
				</select>
			</div> 
						
			<div class="input boolean optional profile_contact_consent">
				<input value="0" type="hidden" name="profile[contact_consent]">
				<label for="profile_contact_consent" class="boolean optional checkbox">
			
				<input type="checkbox" v-model="updatedProfile.contact_consent" name="profile[contact_consent]" id="profile_contact_consent" class="boolean optional">Keep me updated about LensShift</label>
			</div>
		</div> 
				
			<div class="form-actions">
				<input type="submit" name="commit" value="Update Profile" data-disable-with="Update Profile" class="button">
			</div>
	</form>

</template>

<script>
import axios from 'axios'
import profileFormMixin from '../mixins/profileFormMixin'

export default {
	props: {
		profile: Object
	},
	mixins: [profileFormMixin],
  	data: function () {
	    return {
	    	loading: false,
		    sectors: gon.sectors,
		    updatedProfile: {
		     	birthdate: null,
		      	address: null,
		      	location: null,
		      	sector: null,
		      	contact_consent: true
	    	},
	    	notice: null
    }
  },
  methods: {
  	profileUpdate: function (event) {
  		event.target.elements.commit.disabled = true
    	var meta = document.getElementsByTagName('meta')
    	var token = meta['csrf-token'].content
    	this.profile.address = this.address
    	this.profile.location = this.location
  		axios.patch(`/profiles/${this.profile.id}.json`,  {'utf8': '✓','authenticity_token': token, profile: this.updatedProfile })
  			.then(res => {
  				console.log(res)
  				Object.keys(res.data).forEach(key => {
  					this.profile[key] = res.data[key]
  				})
  				event.target.elements.commit.disabled = false
  				this.notice = "Your profile is updated!"
  			}, error => {
  				console.log(error)
  			})
  	}
  },
  created() {
	this.updatedProfile = this.profile
	this.location = this.profile.location
	this.genders = gon.genders
  }
}
</script>
