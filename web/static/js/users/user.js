import {Signup} from './signup';

export class User extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: null
        };
    }

    componentWillMount() {
    }

    setCurrentUser(user) {
        this.setState({
            user: user
        });
    }

    render() {
        let view = (this.state.user) ?
            <LoggedIn user={this.state.user}/> :
            <LoggedOut setCurrentUser={this.setCurrentUser} />

        return (
              <div>{view}</div>
        );
    }
}

export class LoggedIn extends React.Component {
    constructor(props) {
        super(props);
    }

    componentWillMount() {
    }

    render() {
        return (
              <div>
                  <span>{this.props.user.email}</span>
              </div>
        );
    }
}

export class LoggedOut extends React.Component {
    constructor(props) {
        super(props);
    }

    componentWillMount() {
    }

    render() {
        return (
              <div>
                  <a href="/login">Login</a>
                  <a href="/signup">Sign up</a>
                  <Signup setCurrentUser={this.props.setCurrentUser}/>
              </div>
        );
    }
}
