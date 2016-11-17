import React from 'react'
import TagsInput from '../../components/tags-input'
import ReactDOM from 'react-dom'

export default (() => {
    return {
        call() {
            let tagsEl = document.querySelector('[data-tags]'),
                value = (tagsEl && tagsEl.dataset.tags || '').split(',').filter((tag) => { return tag.trim() })

            ReactDOM.render(
                <TagsInput tags={value} name="post[tags]" />,
                tagsEl
            );
        }
    }
})()
