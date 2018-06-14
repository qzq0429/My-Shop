package com.qzq.haha.MyShopController;

import com.qzq.haha.MyShopService.ArticleTypeService;
import com.qzq.haha.POJO.ArticleType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RequestMapping("list")
@Controller
public class ListController {
    @Autowired
    ArticleTypeService articleTypeService;
z
    @RequestMapping("/start.do")
    public void start(HttpServletRequest request, HttpServletResponse response){
//        List<ArticleType> list = articleTypeService.listAll();
//        List<ArticleType> _list = new ArrayList<ArticleType>();
//        for (ArticleType value:list) {
//            if(value.getCode().length()==4){
//                _list.add(value);
//            }
//        }
//        request.setAttribute("firstArticleTypes",_list);
        List<ArticleType> s_list = (List<ArticleType>) request.getSession().getAttribute("allSecondArticleTypes");
        List<ArticleType> _list = (List<ArticleType>) request.getSession().getAttribute("firstArticleTypes");
        request.setAttribute("allSecondArticleTypes",s_list);
        request.setAttribute("firstArticleTypes",_list);
            if(request.getParameter("typecode")!=null){
                String typecode =request.getParameter("typecode");
                request.setAttribute("typecode",typecode);
            }

        try {
            request.getRequestDispatcher("/jsp/list.jsp").forward(request,response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

}
