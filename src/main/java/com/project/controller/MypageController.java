package com.project.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.Member;
import com.project.domain.Point;
import com.project.domain.Store;
import com.project.dto.CustomUserDetails;
import com.project.dto.MypageLike;
import com.project.dto.MypageReview;
import com.project.dto.PageRequest;
import com.project.dto.PageResponse;
import com.project.service.MypageService;
import com.project.service.PointService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MypageController {

	private final MypageService mypageService;
	private final PointService pointService;
	
	@GetMapping("/mypage")
    public String myPage(@RequestParam(name = "likePage",defaultValue="1") int likePage,
    					@RequestParam(name = "reviewPage",defaultValue="1") int reviewPage,
    					@RequestParam(name = "size",defaultValue="5") int size,
    					@AuthenticationPrincipal CustomUserDetails userDetails,
						Model model) {
		
		// 세션으로 id받기 , 멤버값 하나 구해오기
		Member member = userDetails.getMember();
		
		if(member.getCategory().equals("사업자")) {
			List<Store> store =  mypageService.getStoreList(member.getId());
			for(Store a : store) {
				System.out.println(a);
			}
			model.addAttribute("store",store);
		}
		
		// 좋아요와 리뷰 각각의 PageRequest 객체 생성
		PageRequest likePageRequest = new PageRequest(member.getId(),likePage, size);
		PageRequest reviewPageRequest = new PageRequest(member.getId(),reviewPage, size);
		
		// 서비스에서 각각의 PageRequest로 데이터 조회 후 PageResponse로 감싸기
		
		PageResponse<MypageLike> likePageResponse = mypageService.getMypageLike(likePageRequest);
		PageResponse<MypageReview> reviewPageResponse = mypageService.getMypageReview(reviewPageRequest);
		
		model.addAttribute("likePageResponse",likePageResponse);
		model.addAttribute("reviewPageResponse",reviewPageResponse);
		
		// 포인트
		int point = pointService.getTotalPoints(member.getId());
		model.addAttribute("point",point);
		
    	return "mypage/mypage";
    }
	
	
	@PostMapping("/profile/upload")
	@ResponseBody
	public Map<String,Object> uploadProfilePic(@RequestParam("file") MultipartFile file,@AuthenticationPrincipal CustomUserDetails userDetails){
		Map<String,Object> response = new HashMap<>();
		
		Member member = userDetails.getMember();
		
		try {
			if(!file.isEmpty()) {
				
				String uploadDir = new File("src/main/resources/static/images").getAbsolutePath();
				String fileName = UUID.randomUUID().toString()+"_"+file.getOriginalFilename().replaceAll(" ", "_");
				String filePath = uploadDir + File.separator +fileName;
				
				if(member.getProfileImage() != null && !member.getProfileImage().equals("/images/default.jpg")){
					Path exsitingFilePath = Paths.get(uploadDir + member.getProfileImage().replace("/images", ""));
					Files.deleteIfExists(exsitingFilePath);
				}
				// System.out.println(filePath);
				// 파일 저장
				file.transferTo(new File(filePath));
				
				String fileUrl = "/images/" + fileName;
				
				System.out.println(fileUrl);
				
				member.setProfileImage(fileUrl);
				
				int i = mypageService.fileUpload(member);
				
				response.put("success", true);
				response.put("profilePicUrl", fileUrl);
			}else {
				response.put("success", false);
				response.put("message", "파일이 비어있습니다.");
			}
			
		}catch(Exception e) {
			response.put("success", false);
			e.printStackTrace();
		}
		return response;
	}
	
	@GetMapping("/profile")
    public String profile(@AuthenticationPrincipal CustomUserDetails userDetails , Model model) {
		Member member = mypageService.getMember(userDetails.getUsername());
		model.addAttribute("member",member);
		// 포인트
				int point = pointService.getTotalPoints(member.getId());
				model.addAttribute("point",point);
    	return "mypage/profile";
    }
	
	@PostMapping("/profile")
	public String profileEdit(@AuthenticationPrincipal CustomUserDetails userDetails, Member member,RedirectAttributes redirectAttributes) {
		member.setId(userDetails.getId());
		member.setMemberId(userDetails.getUsername());
		System.out.println(member);
		try {
			int i = mypageService.updateMember(member);			
			if(i != 1)redirectAttributes.addFlashAttribute("message","변경에 실패하였습니다.");
			else redirectAttributes.addFlashAttribute("message","변경에 성공하였습니다.");
	    } catch (Exception e) {
	        // 기타 예외 처리
	        redirectAttributes.addFlashAttribute("message", "이미 존재하는 닉네임입니다.");
	    }			
		return "redirect:/profile";
	}
	
	
	@GetMapping("/account")
    public String accountSettings(@AuthenticationPrincipal CustomUserDetails userDetails,Model model) {
//		Member member = mypageService.getMember(24);
//		model.addAttribute("member",member);
//    	if(oauth2User!=null) System.out.println("User Attributes: " + oauth2User.getAttributes());
		// 포인트
				int point = pointService.getTotalPoints(userDetails.getId());
				model.addAttribute("point",point);
    	return "mypage/account";
    }
	
	@PostMapping("/account")
	public String accountUpdate(@RequestParam(value="current_password",required = false) String currentPassword,
								@RequestParam(value="new_password",required = false) String newPassword,
								@AuthenticationPrincipal CustomUserDetails userDetails,
			RedirectAttributes redirectAttributes) {
		
		System.out.println("현재 = " + currentPassword);
		boolean b = mypageService.changePassword(userDetails.getMember(),currentPassword,newPassword);
		if(b) redirectAttributes.addFlashAttribute("message","비밀번호가 변경 되었습니다.");
		else redirectAttributes.addFlashAttribute("message","비밀번호가 맞지 않습니다.");
		return "redirect:/account";
	}
	
	// 고칠것
	@PostMapping("/deleteAccount")
	public String deleteAccount(@AuthenticationPrincipal CustomUserDetails userDetails, RedirectAttributes redirectAttributes) {
		int i = mypageService.deleteMember(userDetails.getId());
		return "redirect:/logout";
	}
	
	@GetMapping("/updateSocialId")
	public String updateSocialId(@AuthenticationPrincipal CustomUserDetails userDetails,HttpSession session) {
		int i = mypageService.updateSocialId(userDetails,session);
		session.removeAttribute("socialName");
		return "redirect:/account";
	}
	
	@GetMapping("/userPoint")
	public String userPoint(@AuthenticationPrincipal CustomUserDetails userDetails,Model model) {
		// 포인트
		int point = pointService.getTotalPoints(userDetails.getId());
		model.addAttribute("point",point);
		return "mypage/userPoint";
	}
	
	@GetMapping("/findPointByMemberId")
    @ResponseBody
	public List<Point> getPointByMember(@RequestParam("member_id") long memberId) {
		return pointService.findPointByuserId(memberId);
	}
}
