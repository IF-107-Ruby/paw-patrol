import React from 'react'; 
import './watchers-block.scss';

const FlashMessage = props => {
  const {closeFlash, serverError} = props;
  
  const flashClassName = `${serverError ? 'warning' : 'success'}`;

  return(
    <div id='flash-messages'>
      <div className={`notification closeable ${flashClassName}`} >
        {serverError ?
          <p>Unable to update watchers!</p>
        :
          <p>Watchers updated!</p>
        }  
        <a className='close' onClick={closeFlash}></a>
      </div>
    </div>
  )
}

export default FlashMessage;
