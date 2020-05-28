import React from 'react'; 
import './watchers-block.scss';

const FlashMessage = props => {
  const {closeFlash} = props;
  return(
    <div id='flash-messages'>
      <div className='notification success closeable'>
        <p>Watchers updated!</p>
        <a className='close' onClick={closeFlash}></a>
      </div>
    </div>
  )
}

export default FlashMessage;
