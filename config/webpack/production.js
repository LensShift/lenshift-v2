const environment = require('./environment')

module.exports = environment.toWebpackConfig({
	warnings: true
})
