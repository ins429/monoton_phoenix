import {Socket} from 'phoenix';
import {ImagesForm} from './uploader';

class Monoton extends React.Component {
    componentWillMount() {
    }

    render() {
        return (
            <section>
                <div id="stage" className="container-fluid">
                    <Grid/>
                    <ImagesForm url="/photos"/>
                </div>
            </section>
        );
    }
}

class Grid extends React.Component {
    componentWillMount() {
    }

    render() {
        let image = (
            <div className="image">
                <Img src=""/>
            </div>
        )
        return (
            <div className="images">
                {image}
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
