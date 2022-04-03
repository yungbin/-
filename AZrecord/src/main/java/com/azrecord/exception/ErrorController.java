package com.azrecord.exception;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController {
	@GetMapping("/auth_error")
	public String auth_error() {
		return "error/auth_error";
	}
}