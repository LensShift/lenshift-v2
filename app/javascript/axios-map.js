import axios from 'axios'

const instance = axios.create({
	baseURL: 'https://maps.googleapis.com/maps/api/place/queryautocomplete/json?'
	// headers: {'Access-Control-Allow-Origin': '*'}
});

export default instance