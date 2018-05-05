<script>
import axios from 'axios'

export default {
	data: function () {
		return {
			location1: null,
			location1LatLong: null,
			location2: null,
			location2LatLong: null,
			location3: null,
			location3LatLong: null,
			suggestions: null
		}
	},
	methods: {
		getLatLong: function (locationInput) {
			axios.get('https://open.mapquestapi.com/geocoding/v1/address' + '?key=' + gon.mapquest_key + '&format=json' + '&location=' + this[locationInput] + '&thumbMaps=true')
            .then(res => {
            	console.log(res)
            	this.suggestions = res.data.results[0].locations

            	this[locationInput+'LatLong'] = JSON.stringify(res.data.results[0].locations[0].latLng)
            }).catch(error => {
            	console.log(error)
            })
		}
	},
	created () {
		if(gon.team_member) {
			this.location1 = gon.team_member.info.home_1
			this.location1LatLong = gon.team_member.info.home_1_lat_long
			this.location2 = gon.team_member.info.home_2
			this.location2LatLong = gon.team_member.info.home_2_lat_long
			this.location3 = gon.team_member.info.home_3
			this.location3LatLong = gon.team_member.info.home_3_lat_long
		}
	}
}
</script>