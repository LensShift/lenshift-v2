const path    = require("path")
const webpack = require("webpack")
const { VueLoaderPlugin } = require("vue-loader");

const mode =
  process.env.NODE_ENV === "development" ? "development" : "production";

module.exports = {
  mode,
  devtool: "source-map",
  entry: {
    application: "./app/javascript/application.js"
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, "app/assets/builds"),
  },
  plugins: [
    new VueLoaderPlugin(),
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ],
  resolve: {
    extensions: ['*', '.js', '.vue', '.json'],
   },
  module: {
    rules: [
      {
        test: /\.(png|jpe?g|gif|eot|woff2|woff|ttf|svg)$/i,
        type: "asset/resource"
      },
      {
        test: /\.css$/i,
        use: ["style-loader", "css-loader"]
      },
      {
        test: /\.vue(\.erb)?$/,
        use: ["vue-loader"]
      },
      {
        test: /\.(js)$/,
        exclude: /node_modules/,
        use: ["babel-loader"]
      }
    ]
  }
}
