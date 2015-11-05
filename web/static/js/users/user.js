import {Signup} from './signup';
import {Login} from './login';

export class User extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: null
        };
    }

    componentDidMount() {
        $.ajax({
            url: '/showme'
        })
        .done(function(resp) {
            this.setCurrentUser(resp);
        }.bind(this))
        .fail(function(resp) {
            console.log(resp);
            // fix me
        }.bind(this));
    }

    setCurrentUser(user) {
        this.setState({
            user: user
        });
    }

    render() {
        let view = (this.state.user) ?
            <LoggedIn user={this.state.user} setCurrentUser={this.setCurrentUser.bind(this)}/> :
            <LoggedOut setCurrentUser={this.setCurrentUser.bind(this)}/>

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

    submit() {
        $.ajax({
            data: {
                _csrf_token: CSRF
            },
            method: 'delete',
            url: '/logout'
        })
        .done(function(resp) {
            this.props.setCurrentUser(null);
        }.bind(this))
        .fail(function(resp) {
            console.log(resp);
            // fix me
        }.bind(this));
    }

    render() {
        return (
              <div>
                  <span>{this.props.user.email}</span>
                  <button onClick={this.submit.bind(this)}>Logout</button>
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
                  <Login setCurrentUser={this.props.setCurrentUser}/>
              </div>
        );
    }
}
