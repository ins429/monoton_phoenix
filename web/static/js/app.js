import {Socket} from 'phoenix';
import {ImagesForm} from './uploader';
import {User} from './users/user';

class Monoton extends React.Component {
    componentWillMount() {
    }

    render() {
        return (
            <section>
                <div id="stage" className="container-fluid">
                    <User/>
                    <Grid/>
                    <ImagesForm url="/photos" method="POST"/>
                </div>
            </section>
        );
    }
}

class Grid extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            images: []
        };
    }

    componentDidMount() {
        $.ajax({
            url: '/photos'
        })
        .done(function(resp) {
            this.setState({
                images: resp
            });
        }.bind(this))
        .fail(function() {
            // fix me
        }.bind(this));
    }

    render() {
        console.log(this.state.images);
        let images = this.state.images.map(img => {
            return (img.photo) ? <div className="image">
                    <Img src={img.photo.urls.thumb}/>
                </div> : false;
        });

        console.log(images);
        return (
            <div className="images">
                {images}
            </div>
        );
    }
}

class Img extends React.Component {
    componentWillMount() {
    }

    render() {
        return (
            <div>
                <img src={this.props.src} alt="" />
            </div>
        );
    }
}

React.render(<Monoton/>, document.getElementById('canvas'));
