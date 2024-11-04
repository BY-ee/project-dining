package com.project.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.mapper.LoginMapper;
import com.project.domain.LoginDomain;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginService {

	private final LoginMapper loginMapper;

	    
	public LoginDomain getUser(String userid) {
		return loginMapper.getUser(userid);
	}



	public String get(String naverInfoApiUrl, Map<String, String> naverHeader) {
		
		HttpURLConnection con = LoginService.connect(naverInfoApiUrl);
		
		 try {
	            con.setRequestMethod("GET");
	            for(Map.Entry<String, String> header : naverHeader.entrySet()) {
	                con.setRequestProperty(header.getKey(), header.getValue());
	            }
	            int responseCode = con.getResponseCode();
	            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	                return readBody(con.getInputStream());

	                
	            } else { // 에러 발생
	                return readBody(con.getErrorStream());
	            }
	        } catch (IOException e) {
	            throw new RuntimeException("API 요청과 응답 실패", e);
	        } finally {
	            con.disconnect();
	        }

	}

	 private String readBody(InputStream body) {
		
		    InputStreamReader streamReader = new InputStreamReader(body, StandardCharsets.UTF_8);


	        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	            StringBuilder naverRB = new StringBuilder();


	            String line;
	            while ((line = lineReader.readLine()) != null) {
	            	naverRB.append(line);
	            }


	            return naverRB.toString(); // 디코딩 된 json 정보
	            
	        } catch (IOException e) {
	            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
	        }
	    }
	

    // connection 확인하기
	private static HttpURLConnection connect(String naverInfoApiUrl) {
		
		 try {
	            URL url = new URL(naverInfoApiUrl);
	            return (HttpURLConnection)url.openConnection();
	        } catch (MalformedURLException e) {
	            throw new RuntimeException("API URL이 잘못되었습니다. : " + naverInfoApiUrl, e);
	        } catch (IOException e) {
	            throw new RuntimeException("연결이 실패했습니다. : " + naverInfoApiUrl, e);
	        }
	 }
	 
}
