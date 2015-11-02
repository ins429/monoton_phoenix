export class Signup extends React.Component {
    constructor(props) {
        super(props);
    }

    componentWillMount() {
    }

    submit(params) {
        $.ajax({
            data: {
                email: this.refs.email.getDOMNode().value,
                password: this.refs.password.getDOMNode().value,
                _csrf_token: CSRF
            },
            method: 'post',
            url: '/signup'
        })
        .done(function(resp) {
            this.props.setCurrentUser(resp);
        }.bind(this))
        .fail(function() {
            // fix me
        }.bind(this));
    }

    render() {
        return (
            <div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" ref="email" className="form-control" />
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" ref="password" className="form-control" />
                </div>

                <input type="submit" className="btn btn-primary" ref="button" value="Signup" onClick={this.submit.bind(this)}/>
            </div>
        );
    }
}
