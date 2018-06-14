package com.qzq.haha.MyShopService.Impl;

import com.qzq.haha.MyShopDao.ArticleMapper;
import com.qzq.haha.MyShopService.ArticleService;
import com.qzq.haha.POJO.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ArticleServiceImpl implements ArticleService {
    @Autowired
    private ArticleMapper articleMapper;
    @Override
    public List<Article> selectAll() {
        return articleMapper.selectList();
    }
}
