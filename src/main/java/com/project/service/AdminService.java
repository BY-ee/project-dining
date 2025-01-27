package com.project.service;

import java.io.File;
import java.io.IOException;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.domain.Event;
import com.project.domain.Member;
import com.project.domain.Menu;
import com.project.domain.Notice;
import com.project.domain.Review;
import com.project.domain.Store;
import com.project.dto.EventDTO;
import com.project.dto.NoticeDTO;
import com.project.dto.Pagination;
import com.project.dto.RequestData;
import com.project.dto.ReviewDTO;
import com.project.dto.ReviewMemberDTO;
import com.project.dto.StoreDetailDTO;
import com.project.dto.StoreWithDetailDTO;
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
	
	// 유저 조회
	public Pagination<Member> selectMembers(RequestData requestData) {
		int page = requestData.getPage();
		int size = requestData.getSize();
		
		int start = (page - 1) * size + 1;
		int end = start + size - 1;
		long totalCount = memberMapper.countMembers(requestData);

		List<Member> members = memberMapper.selectMembers(start, end, requestData);

		return new Pagination<>(members, page, size, totalCount);
	}
	
	// 특정 유저 조회
	public Member selectMember(long id) {
		return memberMapper.selectMember(id);
	}

	// 회원 차단
	public void blockMember(long id, int banTime) {
		memberMapper.blockMember(id, banTime);
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
		long totalCount = storeMapper.countStores(requestData);
		
		List<Store> stores = storeMapper.selectStores(start, end, requestData);
		
		return new Pagination<>(stores, page, size, totalCount);
	}
	
	// 가게 조회
	public StoreDetailDTO selectStoreById(long id) {
		StoreDetailDTO store = storeMapper.selectStoreById(id);
		List<Menu> menus = storeMapper.selectMenuById(id);
		try {
			store.setMenuImage(menus.get(0).getMenuImage());
			store.setMenuDescription(menus.get(0).getMenuDescription());
			store.setMenuName(menus.get(0).getMenuName());
			store.setMenuPrice(menus.get(0).getMenuPrice());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return store;
	}
	
	// 가게 찜 개수 조회
	public long selectLikeCountById(long id) {
		return storeMapper.getLikeCountByStoreId(id);
	}
	
	// 카테고리가 포함된 가게 데이터
	public StoreWithDetailDTO selectStoreWithDetailById(long id) {
		StoreWithDetailDTO store = storeMapper.selectStoreWithDetailById(id);
		if(storeMapper.selectMenuImagesById(id).size() != 0) {
			store.setMenuImage(storeMapper.selectMenuImagesById(id).get(0));
		}
		store.setThemes(storeMapper.selectThemesById(id));
		
		return store;
	}
	
	// 가게 게시글 게시중단
	public void inactivateStore(long id) {
		storeMapper.inactivateStore(id);
	}

	// 가게 게시글 재게시
	public void reactivateStore(long id) {
		storeMapper.reactivateStore(id);
	}
	
	// 게시글 검토
	public void updateReadStatus(long id) {
		storeMapper.updateReadStatus(id);
	}
	
	// 게시글 승인
	@Transactional
	public void enrollStore(long id) {
		storeMapper.enrollStore(id);
		storeMapper.reactivateStore(id);
	}
	
	// 게시글 반려
	public void withdrawStore(long id) {
		storeMapper.withdrawStore(id);
	}

	// 메뉴 조희
	public List<Menu> selectMenus(long storeId) {
		return menuMapper.selectMenus(storeId);
	}

	// 리뷰 조회
	public Pagination<ReviewDTO> selectReviews(RequestData requestData) {
		int page = requestData.getPage();
		int size = requestData.getSize();
		
		int start = (page - 1) * size + 1;
		int end = start + size - 1;
		long totalCount = reviewMapper.countReviews(requestData);
		
		List<ReviewDTO> reviews = reviewMapper.selectReviews(start, end, requestData);
		
		return new Pagination<>(reviews, page, size, totalCount);
	}
	
	// 특정 리뷰 확인
	public Review selectDetailReview(String nickname, String storeName) {
		return reviewMapper.selectReviewByNicknameAndStoreName(nickname, storeName);
	}
	
	// 작성자 정보가 추가된 상세리뷰 조회
	public ReviewMemberDTO selectDetailReviewMember(long id) {
		return reviewMapper.selectReviewMemberById(id);
	}
	
	// 리뷰 게시중단
	public void inactivateReview(long id) {
		reviewMapper.inactivateReview(id);
	}
	
	// 리뷰 재게시 
	public void reactivateReview(long id) {
		reviewMapper.reactivateReview(id);
	}

	// 공지 조회
	public Pagination<Notice> selectNotice(RequestData requestData) {
		int page = requestData.getPage();
		int size = requestData.getSize();
		
		int start = (page - 1) * size + 1;
		int end = start + size - 1;
		long totalCount = noticeMapper.countNotice(requestData);
		
		List<Notice> notice = noticeMapper.selectNotice(start, end, requestData);
		
		return new Pagination<>(notice, page, size, totalCount);
	}

	// 특정 공지 조회
	public Notice selectNoticeById(long id) {
		return noticeMapper.selectNoticeById(id);
	}
	
	// 공지 작성
	public void insertNotice(NoticeDTO noticeDTO) {
	    String filePath = null;
	    String fileName = null;
	    MultipartFile noticeImage = noticeDTO.getImagePath();

	    if (noticeImage != null && !noticeImage.isEmpty()) {
	        String staticImagePath = new File("src/main/resources/static/images").getAbsolutePath();
	        fileName = System.currentTimeMillis() + "_" + noticeImage.getOriginalFilename();
	        filePath = staticImagePath + "/" + fileName;

	        File file = new File(filePath);

	        try {
	            // 파일 저장
	            noticeImage.transferTo(file);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }

	    Notice notice = new Notice();
	    notice.setTitle(noticeDTO.getTitle());
	    notice.setContent(noticeDTO.getContent());
	    if(fileName != null) {
	    	notice.setNoticeImage("/images/" + fileName); // DB에는 상대 경로로 저장
	    } else {
	    	notice.setNoticeImage(null);
	    }
	    
		noticeMapper.insertNotice(notice);
	}
	
	// 공지 수정
	public void updateNotice(NoticeDTO noticeDTO, int id) {
	    String filePath = null;
	    String fileName = null;
	    MultipartFile noticeImage = noticeDTO.getImagePath();

	    if (noticeImage != null && !noticeImage.isEmpty()) {
	        String staticImagePath = new File("src/main/resources/static/images").getAbsolutePath();
	        fileName = System.currentTimeMillis() + "_" + noticeImage.getOriginalFilename();
	        filePath = staticImagePath + "/" + fileName;

	        File file = new File(filePath);

	        try {
	            // 파일 저장
	            noticeImage.transferTo(file);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }

	    Notice notice = new Notice();
	    notice.setTitle(noticeDTO.getTitle());
	    notice.setContent(noticeDTO.getContent());
	    if(fileName != null) {
	    	notice.setNoticeImage("/images/" + fileName); // DB에는 상대 경로로 저장
	    } else {
	    	notice.setNoticeImage(null);
	    }
	    
		noticeMapper.updateNotice(notice, id);
	}
	
	// 공지 게시중단
	public void inactivateNotice(long id) {
		noticeMapper.inactivateNotice(id);
	}

	// 공지 재게시
	public void reactivateNotice(long id) {
		noticeMapper.reactivateNotice(id);
	}

	// 이벤트 조회
	public Pagination<Event> selectEvents(RequestData requestData) {
		int page = requestData.getPage();
		int size = requestData.getSize();
		
		int start = (page - 1) * size + 1;
		int end = start + size - 1;
		long totalCount = noticeMapper.countEvents(requestData);
		
		List<Event> notice = noticeMapper.selectEvents(start, end, requestData);
		
		return new Pagination<>(notice, page, size, totalCount);
	}
	
	// 특정 이벤트 조회
	public Event selectEventById(long id) {
		return noticeMapper.selectEventById(id);
	}
	
	// 이벤트 글 작성
	public void insertEvent(EventDTO eventDTO) {
	    String filePath = null;
	    String fileName = null;
	    MultipartFile eventImage = eventDTO.getImagePath();

	    if (eventImage != null && !eventImage.isEmpty()) {
	        String staticImagePath = new File("src/main/resources/static/images").getAbsolutePath();
	        fileName = System.currentTimeMillis() + "_" + eventImage.getOriginalFilename();
	        filePath = staticImagePath + "/" + fileName;

	        File file = new File(filePath);

	        try {
	            // 파일 저장
	            eventImage.transferTo(file);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }

	    Event event = new Event();
	    event.setCategory(eventDTO.getCategory());
	    event.setTitle(eventDTO.getTitle());
	    event.setContent(eventDTO.getContent());
	    event.setStartDate(Date.from(eventDTO.getStartDate().atZone(ZoneId.systemDefault()).toInstant()));
	    event.setEndDate(Date.from(eventDTO.getEndDate().atZone(ZoneId.systemDefault()).toInstant()));
	    if(fileName != null) {
	    	event.setEventImage("/images/" + fileName); // DB에는 상대 경로로 저장
	    } else {
	    	event.setEventImage(null);
	    }
	    
	    noticeMapper.insertEvent(event);
	}

	
	// 이벤트 수정
	public void updateEvent(EventDTO eventDTO, int id) {
	    String filePath = null;
	    String fileName = null;
	    MultipartFile eventImage = eventDTO.getImagePath();

	    if (eventImage != null && !eventImage.isEmpty()) {
	        String staticImagePath = new File("src/main/resources/static/images").getAbsolutePath();
	        fileName = System.currentTimeMillis() + "_" + eventImage.getOriginalFilename();
	        filePath = staticImagePath + "/" + fileName;

	        File file = new File(filePath);

	        try {
	            // 파일 저장
	            eventImage.transferTo(file);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    Event event = new Event();
	    event.setCategory(eventDTO.getCategory());
	    event.setTitle(eventDTO.getTitle());
	    event.setContent(eventDTO.getContent());
	    event.setStartDate(Date.from(eventDTO.getStartDate().atZone(ZoneId.systemDefault()).toInstant()));
	    event.setEndDate(Date.from(eventDTO.getEndDate().atZone(ZoneId.systemDefault()).toInstant()));
	    if(fileName != null) {
	    	event.setEventImage("/images/" + fileName); // DB에는 상대 경로로 저장
	    } else {
	    	event.setEventImage(null);
	    }
	    
		noticeMapper.updateEvent(event, id);
	}
	
	// 이벤트 글 게시중단
	public void inactivateEvent(long id) {
		noticeMapper.inactivateEvent(id);
	}

	// 이벤트 글 재게시
	public void reactivateEvent(long id) {
		noticeMapper.reactivateEvent(id);
	}
}
