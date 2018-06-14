package com.qzq.haha.MyShopController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.qzq.haha.MyShopService.ArticleService;
import com.qzq.haha.MyShopService.ArticleTypeService;
import com.qzq.haha.MyShopService.UserService;
import com.qzq.haha.POJO.Article;
import com.qzq.haha.POJO.ArticleType;
import com.qzq.haha.POJO.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("login")
public class UserController {
     @Autowired
    private UserService userService;
    @Autowired
    private ArticleTypeService articleTypeService;
    @Autowired
    private ArticleService articleService;
    @RequestMapping("/login.do")
    public void indexof(HttpServletRequest request,HttpServletResponse response){

        List<ArticleType> _list = getFirstArticle();
        List<ArticleType> s_list = getFirstArticle();
        List<Article> articles = getArticle();
        request.getSession().setAttribute("allSecondArticleTypes",s_list);
        request.getSession().setAttribute("firstArticleTypes",_list);
        request.getSession().setAttribute("firstArticleTypes",_list);
        request.setAttribute("allSecondArticleTypes",s_list);
        request.setAttribute("firstArticleTypes",_list);
        try {
            request.getRequestDispatcher("/jsp/login.jsp").forward(request,response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

     @RequestMapping("/check.do")
    public @ResponseBody String verifyUser(@RequestParam("username") String username,
                                           @RequestParam("password") String passsword ,
                                           HttpServletRequest request){
       User user =  userService.checkUser(username,passsword);
         HttpSession httpSession = request.getSession();
       if(user!=null){

           httpSession.setAttribute("username",username);
           httpSession.setAttribute("password",passsword);
           httpSession.setAttribute("islogin",true);
               GsonBuilder gb = new GsonBuilder();
               Gson gson = gb.create();
               String jsonString=gson.toJson(user).toString();
               System.out.println(jsonString);
              return jsonString;


       }else{
           httpSession.setAttribute("islogin",false);
           return null;
       }


     }
    @RequestMapping("/index.do")
    public void toindex(HttpServletRequest request,HttpServletResponse response){
         HttpSession httpSession = request.getSession();
         Object islogin= httpSession.getAttribute("islogin");
         if(islogin==null||(Boolean) islogin==false){

             try {

                 request.getRequestDispatcher("/jsp/login.jsp").forward(request ,response);
             } catch (ServletException e) {
                 e.printStackTrace();
             } catch (IOException e) {
                 e.printStackTrace();
             }

         }else {
             try {
                 List<ArticleType> s_list = getFirstArticle();
                 request.setAttribute("allSecondArticleTypes",s_list);
                 List<ArticleType> _list = getFirstArticle();
                 request.setAttribute("firstArticleTypes",_list);
             request.getRequestDispatcher("/list/start.do").forward(request ,response);
         } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    }

public List<ArticleType> getFirstArticle(){
    List<ArticleType> list = articleTypeService.listAll();
    List<ArticleType> _list = new ArrayList<ArticleType>();
    for (ArticleType value:list) {
        if(value.getCode().length()==4){
            _list.add(value);
        }
    }
    return _list;
}
    public List<ArticleType> getSecondArticle(){
        List<ArticleType> list = articleTypeService.listAll();
        List<ArticleType> _list = new ArrayList<ArticleType>();
        for (ArticleType value:list) {
            if(value.getCode().length()==8){
                _list.add(value);
            }
        }
        return _list;
    }
    public List<Article> getArticle(){
        List<Article> list = articleService.selectAll();


        return list;
    }
}
