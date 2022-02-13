package com.finale.bookit.booking.model.service;

import com.finale.bookit.booking.model.dao.BookingDao;
import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.booking.model.vo.Criteria;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BookingServiceImpl implements BookingService {

	@Autowired
	private BookingDao bookingDao;

	@Override
	public List<Booking> selectBookingList(Map<String, Object> param) {
		return bookingDao.selectBookingList(param);
	}

	@Override
	public int selectTotalBookingCount(Map<String, Object> param) {
		return bookingDao.selectTotalBookingCount(param);
	}

	@Override
	public Booking selectBooking(Map<String, Object> param) {
		return bookingDao.selectBooking(param);
	}

	@Override
	public List<BookInfo> selectBook(Map<String, Object> param) {
		return bookingDao.selectBook(param);
	}

	@Override
	public int selectCountByIsbn(String isbn13) {
		return bookingDao.selectCountByIsbn(isbn13);
	}

	@Override
	public int insertBookInfo(BookInfo bookInfo) {
		return bookingDao.insertBookInfo(bookInfo);
	}

	@Override
	public int insertBooking(Booking booking) {
		return bookingDao.insertBooking(booking);
	}

	@Override
	public List<Booking> selectBorrowedList(String id) {
		return bookingDao.selectBorrowedList(id);
	}

	@Override
	public List<Booking> selectLentList(Map<String, Object> param) {
		return bookingDao.selectLentList(param);
	}

	@Override
	public List<Booking> selectMyBookingList(Map<String, Object> param) {
		return bookingDao.selectMyBookingList(param);
	}

	@Override
	public int selectTotalMyBookingCount(Map<String, Object> param) {
		return bookingDao.selectTotalMyBookingCount(param);
	}

	@Override
	public int selectTotalMyLentBookingCount(Map<String, Object> param) {
		return bookingDao.selectTotalMyLentBookingCount(param);
	}

	

}
