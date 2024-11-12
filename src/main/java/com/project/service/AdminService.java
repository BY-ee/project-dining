package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.domain.Member;
import com.project.domain.Review;
import com.project.domain.Store;
import com.project.dto.Pagination;
import com.project.dto.RequestData;
import com.project.domain.Menu;
import com.project.domain.Notice;
import com.project.mapper.MemberMapper;
import com.project.mapper.MenuMapper;
import com.project.mapper.NoticeMapper;
import com.project.mapper.ReviewMapper;
import com.project.mapper.StoreMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService {
	private final NoticeMapper noticeMapper;
	private final MemberMapper memberMapper;
	private final StoreMapper storeMapper;
	private final MenuMapper menuMapper;
	private final ReviewMapper reviewMapper;

	// 공지 작성
	public void insertNotice(Notice notice) {
		noticeMapper.insertNotice(notice);
	}
	
	// 유저 조회
	public Pagination<Member> selectMembers(RequestData requestData) {
		int page = requestData.getPage();
		int size = requestData.getSize();
		
		int start = (page - 1) * size + 1;
		int end = start + size - 1;
		long totalCount = memberMapper.countMembers();

		List<Member> members = memberMapper.selectMembers(start, end);

		return new Pagination<>(members, page, size, totalCount);
	}
	
	// 특정 유저 조회
	public Member selectMember(long id) {
		return memberMapper.selectMember(id);
	}

	// 회원 차단
	public void blockMember(long id) {
		memberMapper.blockMember(id);
	}
	
	// 회원 차단해제
	public void unblockMember(long id) {
		memberMapper.unblockMember(id);
	}
	
	// 가게 목록 조회
	public Pagination<Store> selectStores(RequestData requestData) {
		int page = requestData.getPage();
		int size = requestData.getSize();
		
		int start = (page - 1) * size + 1;
		int end = start + size - 1;
		long totalCount = storeMapper.countStores();
		
		List<Store> stores = storeMapper.selectStores(start, end);
		
		return new Pagination<>(stores, page, size, totalCount);
	}
	
	// 가게 게시글 게시중단
	public void inactivateStore(long id) {
		storeMapper.inactivateStore(id);
	}

	// 가게 게시글 재게시
	public void reactivateStore(long id) {
		storeMapper.reactivateStore(id);
	}

	// 메뉴 조희
	public List<Menu> selectMenus(long storeId) {
		return menuMapper.selectMenus(storeId);
	}

	// 리뷰 조회
	public Pagination<Review> selectReviews(RequestData requestData) {
		int page = requestData.getPage();
		int size = requestData.getSize();
		
		int start = (page - 1) * size + 1;
		int end = start + size - 1;
		long totalCount = reviewMapper.countReviews();
		
		List<Review> reviews = reviewMapper.selectReviews(start, end);
		
		return new Pagination<>(reviews, page, size, totalCount);
	}
	
	// 특정 리뷰 확인
	public Review selectDetailReview(long id) {
		return reviewMapper.selectReviewById(id);
	}
	
	// 게시 신청한 가게 조회
	public Pagination<Store> selectEnrolledStores(RequestData requestData) {
		int page = requestData.getPage();
		int size = requestData.getSize();
		
		int start = (page - 1) * size + 1;
		int end = start + size - 1;
		long totalCount = storeMapper.countEnrolledStores();
		
		List<Store> enrolledStores = storeMapper.selectEnrolledStores(start, end);
		
		return new Pagination<>(enrolledStores, page, size, totalCount);
	}

	// 공지 조회
	public Pagination<Notice> selectNotice(RequestData requestData) {
		int page = requestData.getPage();
		int size = requestData.getSize();
		
		int start = (page - 1) * size + 1;
		int end = start + size - 1;
		long totalCount = noticeMapper.countNotice();
		
		List<Notice> notice = noticeMapper.selectNotice(start, end);
		
		return new Pagination<>(notice, page, size, totalCount);
	}
}
