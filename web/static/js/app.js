import page from 'page'
import jQuery from 'jquery'
import React from 'react'
import {render} from 'react-dom'
import '../vendor/css/normalize.css'
import '../vendor/css/skeleton.css'
import '../css/app.scss'

import NewPhotoPage from './pages/photos/new'
import PostForm from './pages/posts/form'

export const App = {
    common: [
    ],
    pages: {
        '/photos/new': [NewPhotoPage],
        '/posts/new': [PostForm],
        '/posts/[0-9]*/edit': [PostForm]
    },
    requireAndCall(page) {
        if (page && page.call) {
            page.call()
        }
    },
    run: function() {
        let route = window.location.pathname

        App.common.forEach(App.requireAndCall)
        for (let path in App.pages) {
            if (route.match(new RegExp(`^${path}$`))) {
                App.pages[path].forEach(App.requireAndCall)
            }
        };
    }
};

if (document.readyState != 'loading'){
    App.run();
} else {
    document.addEventListener('DOMContentLoaded', App.run);
}
