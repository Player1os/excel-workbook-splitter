const request = require('request');

const userToken = 'AQIC5wM2LY4SfczlFpF0w7lecVIVy6K%2B1g1ZkGCSGWU8l0w%3D%40AAJTSQACMTEAAlNLAAk5NzQ5MzU2NjQAAlMxAAIwMg%3D%3D%23';

request({
  method: 'POST',
  url: `https://eam.intranet.st.sk:443/eam/json/sessions/${userToken}?_action=validate`,
  headers: {
	'Content-Type': 'application/json',
  },
}, (err, res, body) => {
	if (err || (res.statusCode !== 200)) {
		return;
	}

	if (!res.body.valid) {
		console.log('Not valid');
		
		return;
	}

	request({
		url: `https://eam.intranet.st.sk:443/eam/json/users/${res.body.uid}?_fields=uid,cn`,
		headers: {
			'eamAuthToken': userToken,
		},
	}, (err, res, body) => {
		if (err || (res.statusCode !== 200)) {
			return;
		}

		console.log(res.body);
	});
});