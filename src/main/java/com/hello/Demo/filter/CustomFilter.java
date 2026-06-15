package com.hello.Demo.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class CustomFilter extends OncePerRequestFilter {
    private final Logger logger = LoggerFactory.getLogger(CustomFilter.class);

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        // Custom logic before the request is processed
        System.out.println("Custom filter is processing the request: " + request.getRequestURI());
        logger.info("Custom filter is processing the request: " + request.getRequestURI());
        // Continue with the next filter in the chain
        filterChain.doFilter(request, response);

        // Custom logic after the request is processed
        System.out.println("Custom filter has finished processing the request.");
        logger.info("Custom filter has finished processing the request.");
    }
}
