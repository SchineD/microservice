package at.gv.wien.m01.pace.api.config;

// import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.ForwardedHeaderFilter;

@Configuration
public class FilterConfigViewHeader {

    @Bean
    ForwardedHeaderFilter forwardedHeaderFilter() {
        return new ForwardedHeaderFilter();
    }

//    @Bean
//    FilterRegistrationBean<ViewRequestHeaderFilter> viewRequestHeaderFilter() {
//        final FilterRegistrationBean<ViewRequestHeaderFilter> filterRegistrationBean = new FilterRegistrationBean<>();
//        ViewRequestHeaderFilter viewRequestHeaderFilter = new ViewRequestHeaderFilter();
//        filterRegistrationBean.setFilter(viewRequestHeaderFilter);
//        filterRegistrationBean.setOrder(3);
//        return filterRegistrationBean;
//    }

}
