export class ImagesForm extends React.Component {
    constructor(props) {
        super(props);
    }

    componentWillMount() {
    }

    uploadFile(e) {
        let fd = new FormData();    

        fd.append('file', this.refs.file.getDOMNode().files[0]);
        fd.append('_csrf_token', CSRF);

        console.log(this.props);
        $.ajax({
            url: this.props.url,
            data: fd,
            processData: false,
            contentType: false,
            type: 'POST',
            success: (data) => {
                console.log(data);
            }
        });
        e.preventDefault()
    }

    render() {
        return (
              <div>
                  <form ref="uploadForm" encType="multipart/form-data">
                      <input ref="file" type="file" name="file"/>
                      <input type="button" ref="button" value="Upload" onClick={this.uploadFile.bind(this)}/>
                  </form>
              </div>
        );
    }
}