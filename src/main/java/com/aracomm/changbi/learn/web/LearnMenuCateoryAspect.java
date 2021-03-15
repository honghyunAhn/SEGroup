package com.aracomm.changbi.learn.web;

import java.util.List;
import java.util.Map;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.aracomm.changbi.learn.dao.CourseDao;

@Component
@Aspect
public class LearnMenuCateoryAspect {
	@Autowired
	CourseDao dao;

    @Around("execution(public String com.aracomm.changbi.learn.web.*Controller.*(..)) && args(model,..)")
    public Object setMenuData(ProceedingJoinPoint joinPoint, Model model) throws Throwable {

        List<Map<String, String>> courseCategoryList = dao.selectCourseCategoryListForMenu();
        model.addAttribute("courseCategoryList", courseCategoryList);

        return joinPoint.proceed();
    }
}
