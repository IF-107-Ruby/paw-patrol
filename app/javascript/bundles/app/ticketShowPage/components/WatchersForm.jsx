import React from 'react';
import avatar from '../../../../../assets/images/user-avatar-placeholder.png';
import '../../../../../assets/stylesheets/watchers.scss';

const WatchersForm = props => {
  const { handleSubmit,
          showForm,
          handleChange,
          selectedWatchers,
          availableWatchers,
          handleForm } = props;

  const btnStyle = {display: showForm ? 'block' : 'none'};

  const options = availableWatchers.map((watcher) => {
    return (
      <option key={watcher.id} value={watcher.id}>
        {watcher.full_name}
      </option>
    )
  })
  
  return(
    <form onSubmit={handleSubmit}
          style={btnStyle}
          className='add-watcher-form'
          >
      <div className='row'>
        <div className='col-xl-12'>
          <div className='dashboard-box margin-top-0'>
            <div className='headline'>
              <h3>
                <i className='icon-material-outline-add'></i>
                Add watchers
              </h3>
            </div>
            <div className='content with-padding padding-bottom-0'>
              <div className='row'>
                <div className='col-auto'>
                  <div className='avatar-wrapper data-tippy-placement="bottom"'>
                    <img src={avatar}/>
                  </div>
                </div>
                <div className='col'>
                  <div className='row'>
                    <div className='col'>
                      <div className='submit-field'>
                        <h5>Select watchers</h5>
                        <select className='with-border selectpicker' 
                          multiple={true} 
                          id="ticket_watcher_ids"
                          data-size={4}
                          title="Add ticket watchers"
                          data-live-search={true}
                          required='required'
                          onChange={handleChange}
                          value={selectedWatchers}
                        >
                            {options}
                        </select>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className='col-xl-12'>
          <div className='row'>
            <div className='col-auto'>
              <button type="submit" className='button ripple-effect button-sliding-icon margin-top-30'>
                Save changes  
                <i className='icon-feather-check'></i>
              </button>
            </div>
            <div className='col-auto'>
              <a className='button dark ripple-effect button-sliding-icon margin-top-30' 
                  id='cancel-watchers-btn'
                  onClick={handleForm}>
                Cancel  
                <i className='icon-feather-x'></i>
              </a>
            </div>
          </div>
        </div>
      </div>
    </form>
  )
}

export default WatchersForm;