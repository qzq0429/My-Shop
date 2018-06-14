package com.qzq.haha.MyShopDao;

import com.qzq.haha.POJO.Article;
import com.qzq.haha.POJO.ArticleType;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ArticleTypeMapper {
    public List<ArticleType> listAll();
}
