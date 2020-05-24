import React, {Component} from 'react';
import WatchersForm from './WatchersForm';
import axios from 'axios';

const csrfToken = document.querySelector('[name=csrf-token]').content
  axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken;

class WatchersBlock extends Component {
  constructor(props) {
    super(props);
    this.state = { 
      availableWatchers: this.props.available_watchers,
      selectedWatchers: this.props.selected_ids,
      showForm: false,
      showFlash: false
     };
  }

  handleForm = () => {
    this.setState({
      showForm: !this.state.showForm,
      showFlash: false
    })
  }

  handleChange = (event) => {
    let options = event.target.options;
    let value = [];
    for (let i = 0, l = options.length; i < l; i++) {
      if (options[i].selected) {
        value.push(options[i].value);
      }
    }
    this.setState({ selectedWatchers: value });
  }

  handleSubmit = (event) => {
    let watcher_ids = this.state.selectedWatchers;
    let id = this.props.ticket_id
    axios
      .patch(`${this.props.ticket_id}/watchers`, {
        ticket: {
        watcher_ids: watcher_ids, 
        id: id}
      })
      .then(response => {
        console.log(response);
        this.setState({
          showFlash: !this.state.showFlash
        })
      })
      .catch(error => {
        console.log(error)
      })
    event.preventDefault();
  }

  render() {
    return (
      <>
        <div className="d-flex justify-content-end">
          <button 
            className="button margin-top-10 button-sliding-icon"
            id='add-watchers-btn'
            onClick={this.handleForm}
            style = {{ display: this.state.showForm ? 'none' : 'block' }}
            >
              Add watchers
              <i className='icon-material-outline-visibility'></i>
          </button>
        </div>
        {this.state.showFlash ?
          <div id='flash-messages'>
            <div className='notification success closeable'>
              <p>Watchers updated!</p>
              <a className='close'></a>
            </div>
          </div>
          : 
          null
        }

        {/* { this.state.showForm ? */}
          <WatchersForm 
            availableWatchers={this.state.availableWatchers}
            handleChange={this.handleChange}
            handleSubmit={this.handleSubmit}
            selectedWatchers={this.state.selectedWatchers}
            showForm={this.state.showForm}
            handleForm = {this.handleForm}
          />  
        {/* :
        null
        } */}
      </>
    );
  }
}

export default WatchersBlock;