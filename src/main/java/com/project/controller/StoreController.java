package com.project.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import com.project.domain.Member;
import com.project.domain.Menu;
import com.project.domain.Store;
import com.project.dto.CustomUserDetails;
import com.project.dto.MemberLike;
import com.project.service.StoreService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class StoreController {

	private final StoreService storeService;

	// 가게정보 불러오기
	@GetMapping("/storeDetail")
	public String getStoreDetail(@RequestParam("store_ID") long storeId,
			@AuthenticationPrincipal CustomUserDetails userDetails,
			// HttpSession session,
			Model model) {

		try {
			Long memberId = null;

	        // 로그인 여부 확인
	        if (userDetails != null && userDetails.getMember() != null) {
	            Member member = userDetails.getMember();
	            memberId = member.getId();
	            System.out.println("로그인된 사용자입니다. memberId: " + memberId);
	        } else {
	            System.out.println("비로그인 사용자입니다.");
	        }

			// 가게 및 메뉴 정보 가져오기
			Store storeDetail = storeService.getStoreDetailById(storeId);
			List<Menu> menuList = storeService.getMenuById(storeId);

			// 가게 카테고리값 가져오기
			List<Store> categoryList = storeService.getStoreCategory(storeId);

			System.out.println("storeDetail값:" + storeDetail);
			System.out.println("menuList값:" + menuList);
			System.out.println("categoryList값:" + categoryList);

			// 가게 이미지 경로 앞에 /img/를 붙이기
			if (storeDetail.getMainImage1() != null) {
				storeDetail.setMainImage1("/images/store/" + storeDetail.getMainImage1());
			}
			if (storeDetail.getMainImage2() != null) {
				storeDetail.setMainImage2("/images/store/" + storeDetail.getMainImage2());
			}

			// 각 메뉴의 이미지 경로에 "/img/" 추가
			for (Menu menu : menuList) {
				if (menu.getMenuImage() != null) {
					menu.setMenuImage("/images/store/" + menu.getMenuImage());
				}
			}

			// MemberLike DTO에 likeCount 설정
			MemberLike memberLike = new MemberLike();
			memberLike.setStoreId(storeId);
			
			// 로그인된 사용자만 memberId 설정
	        if (memberId != null) {
	            memberLike.setMemberId(memberId);
	        }

			// 찜 좋아요 수 가져오기
			long likeCount = storeService.getLikeCountByStoreId(storeId); // DB에서 likeCount 가져오기
			memberLike.setLikeCount(likeCount);

			model.addAttribute("storeId", storeId);
			model.addAttribute("storeDetail", storeDetail);
			model.addAttribute("menuList", menuList);
			model.addAttribute("memberLike", memberLike);
			model.addAttribute("categoryList", categoryList);
			
		} catch (NullPointerException e) {
			throw new NullPointerException("(StoreController) Null Pointer Exception\n" + e.getMessage());
		}

		return "store/store";
	}

	// 찜상태
	@GetMapping("/getLikeStatus")
	public ResponseEntity<MemberLike> getLikeStatus( @AuthenticationPrincipal CustomUserDetails userDetails,
			@RequestParam("storeId") Long storeId) {

		Long memberId = userDetails.getMember().getId();
		System.out.println("받은 데이터: memberId=" + memberId + ", storeId=" + storeId);
		
		// 찜 상태와 찜 개수 가져오기
		boolean isLiked = storeService.isMemberLikedStore(storeId, memberId);
		long likeCount = storeService.getLikeCountByStoreId(storeId);

		// MemberLike 객체 생성 및 반환
		MemberLike memberLike = new MemberLike();
		
		memberLike.setStoreId(storeId);
		memberLike.setMemberId(memberId);
		memberLike.setLikeCount(likeCount);
		memberLike.setLiked(isLiked);

		return ResponseEntity.ok(memberLike);
	}

	// 찜기능
	@PostMapping("/likeStore")
	public ResponseEntity<?> likeStore(@RequestBody MemberLike memberLike) {

		boolean isLiked = memberLike.isLiked();

		// isLiked 상태에 따라 찜 추가 또는 삭제
		if (isLiked) {
			storeService.addLike(memberLike.getMemberId(), memberLike.getStoreId());
		} else {
			storeService.removeLike(memberLike.getMemberId(), memberLike.getStoreId());
		}

		// 업데이트된 찜 수 반환
		long updatedLikeCount = storeService.getLikeCountByStoreId(memberLike.getStoreId());
		memberLike.setLikeCount(updatedLikeCount);

		return ResponseEntity.ok(memberLike);
	}

}
