package com.qzq.haha.MyShopDao;

import com.qzq.haha.POJO.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ArticleMapper {
    public List<Article> selectList();
}
