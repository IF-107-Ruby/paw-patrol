import React from "react";
import PropTypes from "prop-types";
import ReactPaginate from "react-paginate";

Pagination.propTypes = {
  pageCount: PropTypes.number,
  initialPage: PropTypes.number,
  onPageChange: PropTypes.func,
};

function Pagination(props) {
  const { pageCount, initialPage, onPageChange } = props;

  if (pageCount == 1) return null;

  return (
    <div>
      <div className="pagination-container margin-top-20 margin-bottom-20">
        <nav className="pagination" role="navigation" aria-label="pager">
          <ReactPaginate
            pageCount={pageCount}
            initialPage={initialPage}
            onPageChange={onPageChange}
            pageRangeDisplayed={4}
            marginPagesDisplayed={2}
            previousClassName="pagination-arrow"
            previousLinkClassName="ripple-effect"
            previousLabel={
              <i className="icon-material-outline-keyboard-arrow-left"></i>
            }
            nextClassName="pagination-arrow"
            nextLinkClassName="ripple-effect"
            nextLabel={
              <i className="icon-material-outline-keyboard-arrow-right"></i>
            }
            breakLinkClassName="ripple-effect"
            activeLinkClassName="current-page"
            pageLinkClassName="ripple-effect"
            disabledClassName="d-none"
          />
        </nav>
      </div>
    </div>
  );
}

export default Pagination;
