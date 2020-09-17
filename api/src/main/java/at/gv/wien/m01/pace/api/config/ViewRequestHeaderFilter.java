package at.gv.wien.m01.pace.api.config;

import lombok.extern.java.Log;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

/**
 * Activate the header logging filter in
 * @see  FilterConfigViewHeader
 */
@Log
public class ViewRequestHeaderFilter  implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        log.info(" ***********************:::  Filter ");
        Enumeration<String> headers = req.getHeaderNames();
        while (headers.hasMoreElements()) {
            String hd = headers.nextElement();
            log.info(hd + " :: " + req.getHeader(hd));
        }
        log.info(" ============================:::   Filter ");

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }

    public void init(FilterConfig filterConfig) throws ServletException {
    }
}
