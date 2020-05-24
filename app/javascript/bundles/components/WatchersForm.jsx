import React from 'react';

const WatchersForm = props => {
    return(
      <form onSubmit={props.handleSubmit}>
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
                      <img src='user-avatar-placeholder.png'/>
                    </div>
                  </div>
                  <div className='col'>
                    <div className='row'>
                      <div className='col'>
                        <div className='submit-field'>
                          <h5>Select watchers</h5>
                          <select className='with-border selectpicker' 
                            multiple={true} 
                            data-size={7}
                            title="Add ticket watchers"
                            data-live-search={true}
                            required='required'
                            onChange={props.handleChange}
                            value={props.selectedWatchers}
                          >
                              {props.availableWatchers.map((watcher) => {
                                return (
                                  <option key={watcher.id} value={watcher.id}>
                                    {watcher.full_name}
                                  </option>
                                )
                              })}
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
                   onClick={props.handleForm}>
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