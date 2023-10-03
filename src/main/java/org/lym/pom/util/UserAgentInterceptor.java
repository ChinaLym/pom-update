package org.lym.pom.util;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpRequest;
import org.springframework.http.client.ClientHttpRequestExecution;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.ClientHttpResponse;

import java.io.IOException;

public class UserAgentInterceptor implements ClientHttpRequestInterceptor {
    @Override
    public ClientHttpResponse intercept(HttpRequest request, byte[] body, ClientHttpRequestExecution execution)
            throws IOException {
        HttpHeaders headers = request.getHeaders();
        headers.add(HttpHeaders.REFERER, "https://mvnrepository.com");
        headers.add(HttpHeaders.USER_AGENT,
                "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36");
        headers.add(HttpHeaders.COOKIE, "cf_clearance=61e575da1405f308e4747fa497f1a1ee92471fa8-1584947991-0-150; __cfduid=d339e8997bb3f1de8d2bd31cf937122aa1584947991; _ga=GA1.2.439155402.1584948010; _gid=GA1.2.1028680018.1584948010; MVN_SESSION=eyJhbGciOiJIUzI1NiJ9.eyJkYXRhIjp7InVpZCI6ImFmOGM3MzgwLTZjZDYtMTFlYS1hNzI1LTQ5Y2RkNzA5MGQ5OCJ9LCJleHAiOjE2MTY0ODUzODgsIm5iZiI6MTU4NDk0OTM4OCwiaWF0IjoxNTg0OTQ5Mzg4fQ.AhPkfs5ccVH93Fdpud34Dagioy6RomqauWMTyblpK30");

        return execution.execute(request, body);
    }
}