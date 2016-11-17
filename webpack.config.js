var path = require('path');
    SRC_DIR = './web/static',
    JS_SRC_DIR = SRC_DIR + '/js',
    CSS_SRC_DIR = SRC_DIR + '/css',
    DEST_DIR = './priv/static';

module.exports = {
    entry: JS_SRC_DIR + '/app.js',

    resolve: {
        extensions: ['', '.js']
    },

    module: {
        loaders: [
            {
                query: {
                    presets: ['es2015', 'react']
                },
                test: /\.js?$/,
                loader: 'babel',
                exclude: /(node_modules|bower_components)/,
                include: path.resolve(JS_SRC_DIR)
            },
            {
                test: /\.css$/,
                loader: 'style-loader!css-loader'
            },
            {
                test: /\.scss$/,
                exclude: /(node_modules|bower_components)/,
                loaders: ['style', 'css', 'sass'],
                include: path.resolve(CSS_SRC_DIR)
            },
            // { test: /\.(woff2?|svg|jpe?g|png|gif|ico)$/, loader: 'url?limit=10000' },
            // { test: /\.(ttf|eot|svg|woff)$/, loader: 'file' }

            // Image URL config. Generate data URI's for images smaller than 10,000 bytes
            {
                test: /\.(png|gif|jpe?g|svg)$/i, loader: 'url?limit=10000'
            },

            // Image file config. Generate hashed file names to make them easy to cache.
            {
                test: /\.(png|gif|jpe?g|svg)$/i,
                loader: 'file?hash=sha512&digest=hex&name=[path][name]-[hash].[ext]'
            },

            // Inline font files smaller than 10000 bytes
            { test: /\.(woff2?|ttf|eot|svg)$/, loader: 'url' },

            // File loader for fonts larger than 10000 bytes.
            // { test: /\.(woff2?|ttf|eot|svg)$/, loader: 'file?name=[name].[ext]' }

            { test: require.resolve('jquery'), loader: 'expose?jQuery!expose?$'  }
        ]
    },

    output: {
        path: DEST_DIR + '/js',
        filename: 'app.js'
    }
};
