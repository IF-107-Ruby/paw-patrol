import React, {Component} from 'react';
import WatchersForm from './WatchersForm';
import '../../../../../assets/stylesheets/watchers.scss';
import axios from 'axios';
import AxiosHelper from '../../shared/AxiosHelper';
import FlashMessage from './FlashMessage';


class WatchersBlock extends Component {
  constructor(props) {
    super(props);
    this.state = { 
      availableWatchers: this.props.available_watchers,
      selectedWatchers: this.props.selected_ids,
      showForm: false,
      showFlash: false
     };
    this.handleForm = this.handleForm.bind(this);
    this.closeFlash = this.closeFlash.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleForm() {
    this.setState((state) => ({
      showForm: !state.showForm,
      showFlash: false
    }))
  }

  closeFlash() {
    this.setState({ showFlash: false})
  }

  handleChange(event) {
    let options = event.target.options;
    let value = [];
    for (let i = 0, l = options.length; i < l; i++) {
      if (options[i].selected) {
        value.push(options[i].value);
      }
    }
    this.setState({ selectedWatchers: value });
  }

  handleSubmit(event) {
    let watcher_ids = this.state.selectedWatchers;
    let id = this.props.ticket_id
    axios
      .patch(`${this.props.ticket_id}/watchers`, {
        ticket: {
        watcher_ids: watcher_ids, 
        id: id}
      })
      .then(res => {
        this.setState((state) => ({
          showFlash: !state.showFlash
        }))
      })
      .catch(error => {
        console.log(error)
      })
    event.preventDefault();
  }

  render() {
    const {showForm,
          availableWatchers,
          selectedWatchers} = this.state;
          
    const btnStyle = { display: showForm ? 'none' : 'block' };

    return (
      <>
        <div className="d-flex justify-content-end">
          <button 
            className="button margin-top-10 button-sliding-icon"
            id='add-watchers-btn'
            onClick={this.handleForm}
            style = {btnStyle}
            >
              Add watchers
              <i className='icon-material-outline-visibility'></i>
          </button>
        </div>
        {this.state.showFlash ?
          <FlashMessage closeFlash = {this.closeFlash} />
          : 
          null
        }
        <WatchersForm 
          availableWatchers={availableWatchers}
          handleChange={this.handleChange}
          handleSubmit={this.handleSubmit}
          selectedWatchers={selectedWatchers}
          showForm={showForm}
          handleForm = {this.handleForm}
        />  
      </>
    );
  }
}

export default WatchersBlock;