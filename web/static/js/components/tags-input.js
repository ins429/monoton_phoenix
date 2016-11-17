import React from 'react'

export default class TagsInput extends React.Component {
    constructor() {
        super()
        this.state = {
            tags: []
        }
    }

    componentDidMount() {
        this.setState({
            tags: this.props.tags || []
        })
    }

    render() {
        return (
            <div className='tags-input' onClick={this.focusInput.bind(this)}>
                {this.tags()}
                {this.input()}
                <input
                    type="hidden"
                    name={this.props.name}
                    value={this.state.tags} />
            </div>
        )
    }

    focusInput() {
        this.refs.input.focus()
    }

    pushTag(tag) {
        let tags = this.state.tags

        tags.push(tag)
        this.setState({
            tags: tags
        })
    }

    removeLastTag() {
        let tags = this.state.tags

        tags.pop()
        this.setState({
            tags: tags
        })
    }

    removeTag(tag) {
        let tags = this.state.tags,
            index = tags.indexOf(tag)

        tags.splice(index, 1)
        this.setState({
            tags: tags
        })
    }

    onKeyDown(e) {
        let tags = this.state.tags,
            value = e.target.value.trim()

        if ([13, 9].includes(e.keyCode) && value) {
            this.pushTag(value)
            e.target.value = ''
            e.preventDefault()
        } else if ([8, 46].includes(e.keyCode) && value === '') {
            this.removeLastTag()
            e.preventDefault()
        }
    }

    input() {
        return (
            <input
                ref="input"
                type="text"
                onKeyDown={this.onKeyDown.bind(this)} />
        )
    }

    tags() {
        return this.state.tags.map((tag) => {
            return (
                <span className="tag">
                    {tag}
                    <span className='close' onClick={this.removeTag.bind(this, tag)} />
                </span>
            )
        })
    }
}
