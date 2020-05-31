import React, {Component} from 'react';
import _ from 'lodash';
import axios from '../../../shared/AxiosHelper';
import classNames from 'classnames';
import WatchersForm from './WatchersForm';
import FlashMessage from './FlashMessage';
import './watchers-block.scss';


class WatchersBlock extends Component {
  constructor(props) {
    super(props);
    this.state = { 
      availableWatchers: _.get(this.props, 'available_watchers', []),
      selectedWatchers: _.get(this.props, 'selected_ids', []),
      showForm: false,
      showFlash: false,
      serverError: false
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
    const values = _.map(_.filter(options, 'selected'), 'value');

    this.setState({ selectedWatchers: values });
  }

  handleSubmit(event) {
    const watcher_ids = [...this.state.selectedWatchers];
    const id = this.props.ticket_id;
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
        this.setState((state) => ({
          serverError: true,
          showFlash: !state.showFlash
        }))
      })
    event.preventDefault();
  }

  render() {
    const {showForm,
          availableWatchers,
          selectedWatchers,
          serverError} = this.state;
          
    const btnClasses = classNames('button margin-top-10 button-sliding-icon',
                                  { 'hide-btn': showForm });

    return (
      <>
        <div className="d-flex justify-content-end">
          <button 
            className={btnClasses}
            id='add-watchers-btn'
            onClick={this.handleForm}
            >
              Add watchers
              <i className='icon-material-outline-visibility'></i>
          </button>
        </div>
        {this.state.showFlash ?
          <FlashMessage closeFlash = {this.closeFlash} serverError = {serverError} />
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
