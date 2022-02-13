package com.finale.bookit.booking.model.dao;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.booking.model.vo.Criteria;

import java.util.List;
import java.util.Map;

public interface BookingDao {

    int selectTotalBookingCount(Map<String, Object> param);

    List<Booking> selectBookingList(Map<String, Object> param);

	Booking selectBooking(Map<String, Object> param);

	List<BookInfo> selectBook(Map<String, Object> param);

	int selectCountByIsbn(String isbn13);

	int insertBookInfo(BookInfo bookInfo);

	int insertBooking(Booking booking);

	List<Booking> selectBorrowedList(String id);

	List<Booking> selectLentList(Map<String, Object> param);

	List<Booking> selectMyBookingList(Map<String, Object> param);

	int selectTotalMyBookingCount(Map<String, Object> param);

	int selectTotalMyLentBookingCount(Map<String, Object> param);

}
