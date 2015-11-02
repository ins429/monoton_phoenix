export class Login extends React.Component {
    constructor(props) {
        super(props);
    }

    componentWillMount() {
    }

    render() {
        return (
            <div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" className="form-control" />
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" className="form-control" />
                </div>

                <button type="submit" className="btn btn-primary">Signup</button>
            </div>
        );
    }
}
