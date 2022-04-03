package com.azrecord.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

// 자동 생성과 역할
@ControllerAdvice
@Log4j
public class CommanExceptionAdvice {
	
	// Exception 예외가 발생되면 가져와서 처리해 준다. - 500번 오류
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {
		
		// 콘솔에 에러 메시지 출력
		log.error("/////////////////// 예외처리 ///////////////////");
		log.error("* 에러 메시지 : " + ex.getMessage());
		
		// JSP 페이지로 예외를 전달하기 위해 model에 담는다.
		model.addAttribute("exception", ex);
		
		// model 출력
		log.error(model);
		
		// JSP로 이동시킨다.
		return "error/error_500";
	}
	
	// 404 번 오류
	// 404 번 오류 클래스 정의
	@ExceptionHandler(NoHandlerFoundException.class)
	// 404번 오류 코드를 클라이언트에 전송
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		
		log.error("/////////////////// no Page 404 error ///////////////////");
		log.error("요청한 페이지가 없음");
		
		return "error/error_404";
	}
}
